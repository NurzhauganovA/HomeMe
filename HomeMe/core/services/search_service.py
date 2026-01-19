import math
from pgvector.django import CosineDistance
from django.db.models import Q, F
from core.bi_client import EnhancedBIGroupClient
from telegram_bot.models import SecondaryProperty, BIUnit, BIComplex
from core.dto import PropertyDTO
from typing import List, Dict, Optional
import logging

logger = logging.getLogger(__name__)


class EnhancedSearchService:
    """
    Профессиональный сервис поиска недвижимости.
    Интегрирует AI-анализ, многоступенчатую фильтрацию и умную сортировку.
    """

    def __init__(self, ai_service):
        self.bi_client = EnhancedBIGroupClient()
        self.ai_service = ai_service

    def _map_unit_to_dto(self, unit: BIUnit, complex_obj: BIComplex) -> PropertyDTO:
        """Конвертирует BIUnit в PropertyDTO"""
        return PropertyDTO(
            source="bi_group",
            title=f"{complex_obj.name} - {unit.room_count}-комн",
            address=complex_obj.address,
            price=float(unit.current_price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            description=f"Срок сдачи: {unit.deadline or complex_obj.deadline}. Класс: {complex_obj.class_name}",
            url=complex_obj.website,
            image_url=complex_obj.image_url,
            latitude=complex_obj.latitude,
            longitude=complex_obj.longitude,
            property_class=complex_obj.class_name,
            deadline=unit.deadline or complex_obj.deadline
        )

    def intelligent_search(self, analysis_result: Dict, limit: int = 10):
        """Гибридный поиск с fallback"""
        property_type = analysis_result.get('property_type', 'any')

        results = []

        # 1. Базовая фильтрация ЖК
        complex_qs = BIComplex.objects.all()

        # Город (через city_uuid)
        city_name = analysis_result.get('city')
        if city_name:
            city_uuid = self.bi_client.CITY_MAP.get(city_name)
            if city_uuid:
                complex_qs = complex_qs.filter(city_uuid=city_uuid)

        # Гео-фильтр
        coords = analysis_result.get('coordinates')
        if coords and 'lat' in coords and 'lon' in coords:
            lat, lon = coords['lat'], coords['lon']
            radius = analysis_result.get('radius_km', 5.0)
            lat_delta = radius / 111
            lon_delta = radius / max(1e-6, (111 * abs(math.cos(math.radians(lat)))))

            complex_qs = complex_qs.filter(
                latitude__isnull=False,
                longitude__isnull=False,
                latitude__range=(lat - lat_delta, lat + lat_delta),
                longitude__range=(lon - lon_delta, lon + lon_delta)
            )

        # Векторная сортировка (если есть lifestyle запрос)
        query_text = analysis_result.get('embedding_text')
        if query_text:
            embedding = self.ai_service.get_embedding(query_text)
            if embedding:
                complex_qs = complex_qs.annotate(
                    similarity=CosineDistance('embedding', embedding)
                ).order_by('similarity')
            else:
                # Fallback: сортировка по дате
                complex_qs = complex_qs.order_by('-updated_at')

        # Берем топ-10 ЖК
        top_complexes = list(complex_qs[:10])

        if not top_complexes:
            logger.warning("⚠️ No complexes found matching criteria")
            return []

        # 2. Ищем квартиры в этих ЖК
        results = []
        rooms = analysis_result.get('rooms')
        max_price = analysis_result.get('max_price', 999999999999)
        min_area = analysis_result.get('min_area')
        max_area = analysis_result.get('max_area')

        for comp in top_complexes:
            units_qs = BIUnit.objects.filter(
                complex=comp,
                is_active=True,
                price_discount__lte=max_price
            )

            # Фильтр комнат (только если указано)
            if rooms:
                units_qs = units_qs.filter(room_count=rooms)

            floor_prefs = analysis_result.get('floor_preferences', [])
            if 'not_first' in floor_prefs:
                units_qs = units_qs.exclude(floor=1)
            if 'not_last' in floor_prefs:
                units_qs = units_qs.exclude(floor=F('max_floor'))
            if 'high' in floor_prefs:
                units_qs = units_qs.annotate(
                    floor_ratio=F('floor') * 1.0 / F('max_floor')
                ).filter(floor_ratio__gte=0.6)

            # Фильтр площади
            if min_area:
                units_qs = units_qs.filter(area__gte=min_area)
            if max_area:
                units_qs = units_qs.filter(area__lte=max_area)

            units = units_qs.order_by('price_discount')[:3]  # Топ-3 из каждого ЖК

            for u in units:
                results.append(self._map_unit_to_dto(u, comp))

        # Ограничиваем общий результат
        return results[:limit]

    def _search_bi_group(self, city, district, rooms, max_price, min_price,
                         min_area, max_area, semantic_keywords, coordinates, radius_km) -> List[PropertyDTO]:
        """Поиск в BI Group с интеллектуальными фильтрами"""

        # Базовый поиск через существующий клиент
        results = self.bi_client.search_properties(
            rooms=rooms,
            max_price=max_price,
            city=city,
            district=district,
            geo_center=coordinates,
            geo_radius_km=radius_km,
            location_keywords=semantic_keywords,
            limit=50  # Берем больше для пост-фильтрации
        )

        # Дополнительная фильтрация по площади
        if min_area or max_area:
            filtered = []
            for r in results:
                if min_area and r.area < min_area:
                    continue
                if max_area and r.area > max_area:
                    continue
                filtered.append(r)
            results = filtered

        # Фильтр по минимальной цене
        if min_price:
            results = [r for r in results if r.price >= min_price]

        return results

    def _search_secondary_intelligent(self, city, district, rooms, max_price, min_price,
                                      min_area, max_area, lifestyle_tags, semantic_keywords,
                                      description_phrases, exclusion_keywords, embedding_text,
                                      coordinates, radius_km,
                                      limit) -> List[PropertyDTO]:
        """
        Интеллектуальный поиск по вторичке с векторной близостью и многокритериальной фильтрацией
        """
        qs = SecondaryProperty.objects.filter(is_active=True)

        # ========== ЖЕСТКИЕ ФИЛЬТРЫ ==========
        if rooms:
            qs = qs.filter(rooms=rooms)

        if max_price:
            qs = qs.filter(price__lte=max_price)

        if min_price:
            qs = qs.filter(price__gte=min_price)

        if min_area:
            qs = qs.filter(area__gte=min_area)

        if max_area:
            qs = qs.filter(area__lte=max_area)

        # ========== ИНТЕЛЛЕКТУАЛЬНЫЕ ФИЛЬТРЫ ==========

        # 1. Локация (район, ключевые слова)
        if district or semantic_keywords:
            location_q = Q()

            if district:
                location_q |= Q(address__icontains=district) | Q(description__icontains=district)

            for keyword in semantic_keywords:
                if keyword:
                    location_q |= (
                            Q(address__icontains=keyword) |
                            Q(title__icontains=keyword) |
                            Q(description__icontains=keyword) |
                            Q(district__icontains=keyword) |
                            Q(city__icontains=keyword)
                    )

            if location_q:
                qs = qs.filter(location_q)

        # 1.1 Географический фильтр (если есть координаты)
        if coordinates and radius_km:
            lat, lon = coordinates
            lat_delta = radius_km / 111  # приблизительно км -> градусы
            # избегаем деления на ноль на полюсах
            lon_delta = radius_km / max(1e-6, (111 * abs(math.cos(math.radians(lat)))))
            qs = qs.filter(
                latitude__gte=lat - lat_delta,
                latitude__lte=lat + lat_delta,
                longitude__gte=lon - lon_delta,
                longitude__lte=lon + lon_delta,
            )

        # 2. Lifestyle фильтры (если есть описания в БД)
        if lifestyle_tags:
            lifestyle_q = Q()

            # Маппинг lifestyle -> ключевые слова для поиска в описании
            lifestyle_keywords_map = {
                'quiet': ['тихий', 'спокойный', 'уютный', 'тихо'],
                'lively': ['центр', 'оживленн', 'активн'],
                'nature': ['парк', 'зелен', 'сквер', 'лес', 'природ'],
                'family': ['семь', 'детск', 'школ', 'сад', 'площадк'],
                'student': ['универ', 'студ', 'общежит', 'вуз'],
                'metro': ['метро', 'станци'],
                'park': ['парк', 'сквер', 'зелен'],
                'school': ['школ', 'лицей', 'гимназ', 'детск'],
                'mall': ['тц', 'торговый', 'магазин', 'мега', 'mall'],
                'view': ['вид', 'панорам', 'окн'],
                'renovation': ['ремонт', 'евроремонт', 'дизайн'],
                'parking': ['парков', 'гараж', 'машиномест'],
                'security': ['охран', 'консьерж', 'домофон', 'видеонаблюд']
            }

            for tag in lifestyle_tags:
                keywords = lifestyle_keywords_map.get(tag, [])
                for kw in keywords:
                    lifestyle_q |= Q(description__icontains=kw) | Q(title__icontains=kw)

            if lifestyle_q:
                qs = qs.filter(lifestyle_q)

        # 3. Exclusion фильтр (что НЕ должно быть)
        if exclusion_keywords:
            for exclude_kw in exclusion_keywords:
                if exclude_kw:
                    qs = qs.exclude(
                        Q(description__icontains=exclude_kw) | Q(title__icontains=exclude_kw)
                    )

        # ========== ВЕКТОРНАЯ СОРТИРОВКА ==========
        if embedding_text:
            query_vec = self.ai_service.get_embedding(embedding_text)

            if query_vec:
                logger.info("🎯 Using vector similarity search")
                # Сортируем по косинусной близости
                qs = qs.alias(
                    similarity=CosineDistance('embedding', query_vec)
                ).order_by('similarity')  # Меньше = ближе
            else:
                logger.warning("⚠️ Vector embedding failed, using fallback sorting")
                qs = qs.order_by('-created_at')
        else:
            # Fallback: по дате добавления
            qs = qs.order_by('-created_at')

        # ========== КОНВЕРТАЦИЯ В DTO ==========
        results = []
        for p in qs[:limit * 2]:  # Берем с запасом для ранжирования
            dto = PropertyDTO(
                source="secondary",
                title=p.title,
                address=p.address,
                price=float(p.price),
                rooms=p.rooms,
                area=p.area,
                floor=p.floor,
                description=p.description or "",
                url=f"https://homeme.kz/obj/{p.id}",
                image_url=p.image.url if p.image else ""
            )
            results.append(dto)

        return results

    def _rank_results(self, results: List[PropertyDTO], analysis: Dict) -> List[PropertyDTO]:
        """
        Финальное ранжирование результатов на основе AI-анализа.
        Учитывает приоритеты: локация > lifestyle > цена/параметры.
        """
        if not results:
            return []

        priority_tags = analysis.get('priority_tags', [])
        lifestyle_tags = analysis.get('lifestyle_tags', [])

        # Простая эвристика: BI Group приоритетнее, но учитываем lifestyle
        def score_result(dto: PropertyDTO) -> float:
            score = 0.0

            # Бонус для BI Group (новостройки приоритетнее)
            if dto.source == 'bi_group':
                score += 2.0

            # Бонус за совпадение с lifestyle (поиск в описании)
            desc_lower = dto.description.lower()
            title_lower = dto.title.lower()
            address_lower = dto.address.lower()

            combined_text = f"{title_lower} {address_lower} {desc_lower}"

            for tag in priority_tags:
                if tag in combined_text:
                    score += 1.5

            for tag in lifestyle_tags:
                if tag in combined_text:
                    score += 0.5

            return score

        # Сортируем по score (выше = лучше)
        ranked = sorted(results, key=score_result, reverse=True)
        return ranked
