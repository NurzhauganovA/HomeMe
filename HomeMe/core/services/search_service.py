import logging
import math

from typing import List, Dict
from django.db.models import Q
from pgvector.django import CosineDistance

from telegram_bot.models import BIUnit, BIComplex, BICommercialComplex, BICommercialUnit, SecondaryProperty
from core.dto import PropertyDTO
from core.bi_client import EnhancedBIGroupClient

logger = logging.getLogger(__name__)


class EnhancedSearchService:
    def __init__(self, ai_service):
        self.ai_service = ai_service
        self.city_map = EnhancedBIGroupClient.CITY_MAP

    def intelligent_search(self, params: Dict, offset: int = 0, limit: int = 5) -> List[PropertyDTO]:
        """
        Умный поиск с фильтрацией по AI-тегам и группировкой по ЖК.
        """
        results = []
        source = params.get('source', 'mixed')
        bi_category = params.get('bi_category', 'residential')
        embedding_text = params.get('embedding_text', '').lower()

        # Получаем координаты из параметров (их туда положил DialogManager)
        coords = params.get('coordinates')
        radius_km = params.get('radius_km', 3.0)

        # Вектор для ранжирования по смыслу
        query_vector = self.ai_service.get_embedding(embedding_text) if embedding_text else None

        # --- 1. ФОРМИРОВАНИЕ ФИЛЬТРОВ (HYBRID SEARCH) ---
        # Анализируем текст запроса на наличие жестких критериев

        complex_filters = Q()

        # ГЕО-ФИЛЬТР (RADIUS SEARCH) - "Убийца" нерелевантных результатов
        lat, lon = self._normalize_coords(coords)
        if lat is not None and lon is not None:

            # 1 градус широты ~= 111 км
            lat_delta = radius_km / 111.0
            # 1 градус долготы зависит от широты (косинус)
            lon_delta = radius_km / (111.0 * math.cos(math.radians(lat)))

            # Жестко отсекаем всё, что не попадает в квадрат координат
            complex_filters &= Q(
                latitude__range=(lat - lat_delta, lat + lat_delta),
                longitude__range=(lon - lon_delta, lon + lon_delta)
            )
            logger.info(f"📍 GEO FILTER ACTIVE: {lat}, {lon} (+/- {radius_km}km)")

        # Фильтр по берегу (используем данные из features, которые заполнил AI при синхронизации)
        if 'левый' in embedding_text or 'left' in embedding_text:
            complex_filters &= Q(features__side='Left')
        elif 'правый' in embedding_text or 'right' in embedding_text:
            complex_filters &= Q(features__side='Right')

        # Фильтр по городу
        if params.get('city'):
            city_uuid = self.city_map.get(params['city'])
            if city_uuid:
                complex_filters &= Q(city_uuid=city_uuid)

        # --- 2. ПОИСК BI GROUP ---
        if source in ['bi', 'mixed']:
            if bi_category == 'commercial':
                target_complexes = BICommercialComplex.objects.filter(complex_filters)
            else:
                target_complexes = BIComplex.objects.filter(complex_filters)

            # Если есть вектор, сортируем ЖК по смысловой близости
            if query_vector:
                target_complexes = target_complexes.alias(
                    distance=CosineDistance('embedding', query_vector)
                ).order_by('distance')

            # Для пагинации с группировкой нужно взять ЖК с запасом
            # (Offset применяем к списку ЖК, а не квартир)
            complexes_list = list(target_complexes[offset: offset + limit + 5])

            for comp in complexes_list:
                if query_vector and not coords:
                    pass

                if bi_category == 'commercial':
                    units = BICommercialUnit.objects.filter(complex=comp, is_active=True)
                else:
                    units = BIUnit.objects.filter(complex=comp, is_active=True)

                if params.get('min_price'):
                    units = units.filter(price__gte=params['min_price'])
                if params.get('max_price'):
                    units = units.filter(price__lte=params['max_price'])
                if params.get('rooms'):
                    units = units.filter(room_count=params['rooms'])

                best_unit = units.order_by('price').first()
                if best_unit:
                    if bi_category == 'commercial':
                        results.append(self._map_bi_commercial_to_dto(best_unit, comp))
                    else:
                        results.append(self._map_bi_to_dto(best_unit, comp))

                # Если набрали лимит, останавливаемся
                if len(results) >= limit:
                    break

        # --- 3. ПОИСК ВТОРИЧКИ ---
        if source in ['secondary', 'mixed'] and len(results) < limit:
            sec_props = SecondaryProperty.objects.filter(is_active=True)

            if lat is not None and lon is not None:
                sec_props = sec_props.filter(
                    latitude__range=(lat - lat_delta, lat + lat_delta),
                    longitude__range=(lon - lon_delta, lon + lon_delta)
                )

            if params.get('min_price'): sec_props = sec_props.filter(price__gte=params['min_price'])
            if params.get('max_price'): sec_props = sec_props.filter(price__lte=params['max_price'])
            if params.get('rooms'): sec_props = sec_props.filter(rooms=params['rooms'])

            # Вектор
            if query_vector:
                sec_props = sec_props.alias(distance=CosineDistance('embedding', query_vector)).order_by('distance')
            else:
                sec_props = sec_props.order_by('-created_at')

            # Добираем вторичкой остаток лимита (с учетом offset для вторички можно сделать отдельную логику, но пока упростим)
            sec_limit = limit - len(results)
            sec_results = sec_props[offset: offset + sec_limit]

            for item in sec_results:
                results.append(self._map_secondary_to_dto(item))

        # Сортировка смешанной выдачи
        if source == 'mixed':
            results.sort(key=lambda x: (0 if x.source == 'bi_group' else 1, x.price))

        return results

    @staticmethod
    def _normalize_coords(coords):
        if not coords:
            return None, None
        if isinstance(coords, dict):
            lat = coords.get('lat')
            lon = coords.get('lon')
            return lat, lon
        if isinstance(coords, (list, tuple)) and len(coords) >= 2:
            return coords[0], coords[1]
        return None, None

    def _map_bi_to_dto(self, unit: BIUnit, comp: BIComplex) -> PropertyDTO:
        # Формируем богатое описание из тегов AI
        side = "Левый" if comp.features.get('side') == 'Left' else "Правый"
        district = comp.features.get('district_name', '')
        tags_list = comp.features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"📍 {side} берег | {district}\n✨ {tags}\nСрок: {unit.deadline}"

        return PropertyDTO(
            source="bi_group",
            property_kind="residential",
            title=f"ЖК {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            description=desc,
            url=comp.url,
            image_url=comp.image_url,
            latitude=comp.latitude,
            longitude=comp.longitude,
        )

    def _map_bi_commercial_to_dto(self, unit: BICommercialUnit, comp: BICommercialComplex) -> PropertyDTO:
        side = "Левый" if comp.features.get('side') == 'Left' else "Правый"
        district = comp.features.get('district_name', '')
        tags_list = comp.features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"📍 {side} берег | {district}\n✨ {tags}\nСрок: {unit.deadline}"

        return PropertyDTO(
            source="bi_group",
            property_kind="commercial",
            title=f"Коммерция {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            description=desc,
            url=comp.url,
            image_url=comp.image_url,
            latitude=comp.latitude,
            longitude=comp.longitude,
        )

    def _map_secondary_to_dto(self, item: SecondaryProperty) -> PropertyDTO:
        return PropertyDTO(
            source="secondary",
            title=item.title,
            address=item.address,
            price=float(item.price),
            rooms=item.rooms,
            area=item.area,
            floor=item.floor,
            total_floors=item.total_floors,
            description=item.description,
            image_url=item.image.url if item.image else "",
            latitude=item.latitude,
            longitude=item.longitude,
        )