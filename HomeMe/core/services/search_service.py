import logging
import math

from typing import List, Dict
from django.db.models import Q
from pgvector.django import CosineDistance

from telegram_bot.models import (
    BIUnit,
    BIComplex,
    BICommercialComplex,
    BICommercialUnit,
    SecondaryProperty
)
from core.dto import PropertyDTO
from core.bi_client import EnhancedBIGroupClient

logger = logging.getLogger(__name__)


class EnhancedSearchService:
    def __init__(self, ai_service):
        self.ai_service = ai_service
        self.city_map = EnhancedBIGroupClient.CITY_MAP

    def search_complexes(self, params: Dict, offset: int = 0, limit: int = 5):
        """
        Возвращает список комплексов (ЖК/БЦ) по фильтрам.
        Для коммерции учитывает bi_scope: unit/complex/both.
        """
        source = params.get('source', 'mixed')
        if source not in ['bi', 'mixed']:
            return []

        bi_category = params.get('bi_category', 'residential')
        bi_scope = params.get('bi_scope', 'both')
        embedding_text = params.get('embedding_text', '').lower()

        coords = params.get('coordinates')
        radius_km = params.get('radius_km', 3.0)

        query_vector = self.ai_service.get_embedding(embedding_text) if embedding_text else None

        complex_filters = Q()
        lat, lon = self._normalize_coords(coords)
        if lat is not None and lon is not None:
            lat_delta = radius_km / 111.0
            lon_delta = radius_km / (111.0 * math.cos(math.radians(lat)))
            complex_filters &= Q(
                latitude__range=(lat - lat_delta, lat + lat_delta),
                longitude__range=(lon - lon_delta, lon + lon_delta)
            )

        if 'левый' in embedding_text or 'left' in embedding_text:
            complex_filters &= Q(features__side='Left')
        elif 'правый' in embedding_text or 'right' in embedding_text:
            complex_filters &= Q(features__side='Right')

        if params.get('city'):
            city_uuid = self.city_map.get(params['city'])
            if city_uuid:
                complex_filters &= Q(city_uuid=city_uuid)

        complex_model = BIComplex
        unit_model = BIUnit
        if bi_category == 'commercial':
            complex_model = BICommercialComplex
            unit_model = BICommercialUnit

        queryset = complex_model.objects.filter(complex_filters)
        if query_vector:
            queryset = queryset.alias(
                distance=CosineDistance('embedding', query_vector)
            ).order_by('distance')

        results = []
        for comp in queryset[offset: offset + limit + 10]:
            if bi_category == 'commercial' and bi_scope in ['complex']:
                if self._complex_matches_filters(comp, params):
                    results.append(comp)
            else:
                units = unit_model.objects.filter(complex=comp, is_active=True)
                if params.get('min_price'): units = units.filter(price__gte=params['min_price'])
                if params.get('max_price'): units = units.filter(price__lte=params['max_price'])
                if params.get('rooms'): units = units.filter(room_count=params['rooms'])
                if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
                if params.get('max_area'): units = units.filter(area__lte=params['max_area'])
                if units.exists():
                    results.append(comp)

            if len(results) >= limit:
                break

        return results

    def search_units_for_complex(self, params: Dict, complex_id: str, offset: int = 0, limit: int = 5) -> List[PropertyDTO]:
        """
        Возвращает список юнитов (квартиры/помещения) по выбранному комплексу.
        """
        bi_category = params.get('bi_category', 'residential')

        if bi_category == 'commercial':
            complex_model = BICommercialComplex
            unit_model = BICommercialUnit
            mapper = self._map_bi_commercial_to_dto
        else:
            complex_model = BIComplex
            unit_model = BIUnit
            mapper = self._map_bi_to_dto

        comp = complex_model.objects.filter(id=complex_id).first()
        if not comp:
            return []

        units = unit_model.objects.filter(complex=comp, is_active=True)
        if params.get('min_price'): units = units.filter(price__gte=params['min_price'])
        if params.get('max_price'): units = units.filter(price__lte=params['max_price'])
        if params.get('rooms'): units = units.filter(room_count=params['rooms'])
        if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
        if params.get('max_area'): units = units.filter(area__lte=params['max_area'])

        results = []
        for unit in units.order_by('price')[offset: offset + limit]:
            results.append(mapper(unit, comp))

        return results

    def map_complexes_to_dto(self, params: Dict, complexes: List) -> List[PropertyDTO]:
        bi_category = params.get('bi_category', 'residential')
        results = []

        if bi_category == 'commercial':
            for comp in complexes:
                results.append(self._map_bi_commercial_complex_to_dto(comp))
            return results

        for comp in complexes:
            results.append(self._map_bi_residential_complex_to_dto(comp))
        return results

    def intelligent_search(self, params: Dict, offset: int = 0, limit: int = 5) -> List[PropertyDTO]:
        """
        Умный поиск с фильтрацией по AI-тегам и группировкой по ЖК.
        """
        results = []
        source = params.get('source', 'mixed')
        embedding_text = params.get('embedding_text', '').lower()
        bi_category = params.get('bi_category', 'residential')
        bi_scope = params.get('bi_scope', 'both')

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
            complex_model = BIComplex
            unit_model = BIUnit
            mapper = self._map_bi_to_dto
            complex_mapper = None
            if bi_category == 'commercial':
                complex_model = BICommercialComplex
                unit_model = BICommercialUnit
                mapper = self._map_bi_commercial_to_dto
                complex_mapper = self._map_bi_commercial_complex_to_dto

            # Находим подходящие ЖК
            target_complexes = complex_model.objects.filter(complex_filters)

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

                best_unit = None

                # Для коммерции можно искать юниты, комплекс или оба варианта
                if not (bi_category == 'commercial' and bi_scope == 'complex'):
                    units = unit_model.objects.filter(complex=comp, is_active=True)

                    if params.get('min_price'): units = units.filter(price__gte=params['min_price'])
                    if params.get('max_price'): units = units.filter(price__lte=params['max_price'])
                    if params.get('rooms'): units = units.filter(room_count=params['rooms'])
                    if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
                    if params.get('max_area'): units = units.filter(area__lte=params['max_area'])

                    # Берем ОДНУ лучшую (самую дешевую) квартиру из этого ЖК для разнообразия
                    best_unit = units.order_by('price').first()
                    if best_unit:
                        results.append(mapper(best_unit, comp))

                # Если пользователю нужен объект целиком, добавляем комплекс как отдельный результат
                if bi_category == 'commercial' and bi_scope in ['complex', 'both'] and complex_mapper:
                    if self._complex_matches_filters(comp, params):
                        results.append(complex_mapper(comp))

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
            if params.get('min_area'): sec_props = sec_props.filter(area__gte=params['min_area'])
            if params.get('max_area'): sec_props = sec_props.filter(area__lte=params['max_area'])

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

    def intelligent_search_mixed(self, params: Dict, bi_offset: int = 0, secondary_offset: int = 0,
                                 limit: int = 5) -> tuple:
        """
        Смешанная выдача с фиксированным соотношением (3 BI / 2 вторички).
        Возвращает: (results, new_bi_offset, new_secondary_offset)
        """
        bi_limit = 3
        sec_limit = 2

        bi_params = dict(params)
        bi_params['source'] = 'bi'

        sec_params = dict(params)
        sec_params['source'] = 'secondary'

        bi_results = self.intelligent_search(bi_params, offset=bi_offset, limit=bi_limit)
        sec_results = self.intelligent_search(sec_params, offset=secondary_offset, limit=sec_limit)

        if len(sec_results) < sec_limit:
            extra = sec_limit - len(sec_results)
            if extra > 0:
                extra_bi = self.intelligent_search(
                    bi_params,
                    offset=bi_offset + len(bi_results),
                    limit=extra
                )
                bi_results.extend(extra_bi)

        if len(bi_results) < bi_limit:
            extra = bi_limit - len(bi_results)
            if extra > 0:
                extra_sec = self.intelligent_search(
                    sec_params,
                    offset=secondary_offset + len(sec_results),
                    limit=extra
                )
                sec_results.extend(extra_sec)

        results = bi_results + sec_results
        return results, bi_offset + len(bi_results), secondary_offset + len(sec_results)

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
        features = comp.features or {}
        side = "Левый" if features.get('side') == 'Left' else "Правый"
        district = features.get('district_name', '')
        tags_list = features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"📍 {side} берег | {district}\n✨ {tags}\nСрок: {unit.deadline}"

        photos = unit.photos or []
        primary_photo = photos[0] if photos else comp.image_url

        return PropertyDTO(
            source="bi_group",
            title=f"ЖК {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            description=desc,
            url=comp.url,
            image_url=primary_photo,
            image_urls=photos,
            latitude=comp.latitude,
            longitude=comp.longitude,
            object_id=unit.bi_uuid,
            object_kind="unit",
        )

    def _map_bi_commercial_to_dto(self, unit: BICommercialUnit, comp: BICommercialComplex) -> PropertyDTO:
        features = comp.features or {}
        side = "Левый" if features.get('side') == 'Left' else "Правый"
        district = features.get('district_name', '')
        tags_list = features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"🏢 {side} берег | {district}\n✨ {tags}\nСрок: {unit.deadline}"

        photos = unit.photos or []
        primary_photo = photos[0] if photos else comp.image_url

        return PropertyDTO(
            source="bi_group",
            title=f"БЦ {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            description=desc,
            url=comp.url,
            image_url=primary_photo,
            image_urls=photos,
            latitude=comp.latitude,
            longitude=comp.longitude,
            object_id=unit.bi_uuid,
            object_kind="unit",
        )

    def _map_bi_commercial_complex_to_dto(self, comp: BICommercialComplex) -> PropertyDTO:
        features = comp.features or {}
        side = "Левый" if features.get('side') == 'Left' else "Правый"
        district = features.get('district_name', '')
        tags_list = features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"🏢 {side} берег | {district}\n✨ {tags}\nКоммерческий объект целиком"

        price = float(comp.min_price) if comp.min_price else 0.0
        area = comp.min_area or 0.0

        return PropertyDTO(
            source="bi_group",
            title=f"БЦ {comp.name}",
            address=comp.address,
            price=price,
            rooms=0,
            area=area,
            floor=0,
            total_floors=None,
            description=desc,
            url=comp.url,
            image_url=comp.image_url,
            latitude=comp.latitude,
            longitude=comp.longitude,
            object_id=comp.bi_uuid,
            object_kind="complex",
        )

    def _map_bi_residential_complex_to_dto(self, comp: BIComplex) -> PropertyDTO:
        features = comp.features or {}
        side = "Левый" if features.get('side') == 'Left' else "Правый"
        district = features.get('district_name', '')
        tags_list = features.get('tags', [])
        tags = ", ".join(tags_list[:3]) if isinstance(tags_list, list) else ""

        desc = f"📍 {side} берег | {district}\n✨ {tags}\nЖК (комплекс)"

        price = float(comp.min_price) if comp.min_price else 0.0
        area = comp.min_area or 0.0

        return PropertyDTO(
            source="bi_group",
            title=f"ЖК {comp.name}",
            address=comp.address,
            price=price,
            rooms=0,
            area=area,
            floor=0,
            total_floors=None,
            description=desc,
            url=comp.url,
            image_url=comp.image_url,
            latitude=comp.latitude,
            longitude=comp.longitude,
            object_id=comp.bi_uuid,
            object_kind="complex",
        )

    @staticmethod
    def _complex_matches_filters(comp, params: Dict) -> bool:
        min_price = params.get('min_price')
        max_price = params.get('max_price')
        min_area = params.get('min_area')
        max_area = params.get('max_area')

        if min_price and comp.min_price is not None and comp.min_price < min_price:
            return False
        if max_price and comp.min_price is not None and comp.min_price > max_price:
            return False

        if min_area and comp.max_area is not None and comp.max_area < min_area:
            return False
        if max_area and comp.min_area is not None and comp.min_area > max_area:
            return False

        return True

    def _map_secondary_to_dto(self, item: SecondaryProperty) -> PropertyDTO:
        photos = item.photos or []
        primary_photo = photos[0] if photos else (item.image.url if item.image else "")
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
            image_url=primary_photo,
            image_urls=photos,
            url=item.source_url or "",
            latitude=item.latitude,
            longitude=item.longitude,
            owner_phone=item.owner_phone,
            owner_name=item.owner_name,
            object_id=str(item.id),
            object_kind="secondary",
        )