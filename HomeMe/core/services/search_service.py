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

    @staticmethod
    def _apply_price_filters(queryset, min_price, max_price):
        if min_price and max_price:
            return queryset.filter(price__gte=min_price, price__lte=max_price)
        if min_price:
            return queryset.filter(price__gte=min_price)
        if max_price:
            return queryset.filter(Q(price__lte=max_price) | Q(price__isnull=True))
        return queryset

    def search_complexes(self, params: Dict, offset: int = 0, limit: int = 5):
        """
        Возвращает список комплексов (ЖК/БЦ) по фильтрам и следующий offset.
        Для коммерции учитывает bi_scope: unit/complex/both.
        """
        source = params.get('source', 'mixed')
        if source not in ['bi', 'mixed']:
            return [], offset

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
            logger.info(f"📍 GEO FILTER (complexes): {lat}, {lon} (+/- {radius_km}km)")

        # Фильтр по берегу (строго Left/Right)
        if params.get('side'):
            # Есильский, Нура - Левый берег
            # Сарайшык, Сарыарка, Алматинский, Байконур - Правый берег
            if params['side'] == 'Left':
                districts = ['Есильский', 'Нура', 'Нуринский']
            if params['side'] == 'Right':
                districts = ['Сарайшык', 'Сарыарка', 'Сарыаркинский', 'Алматинский', 'Байконур', 'Байконурский']

            side_filter = Q()
            for district in districts:
                side_filter |= Q(features__district_name__icontains=district)
            complex_filters &= side_filter
            logger.info(f"🏖 SIDE FILTER (complexes): {params['side']} (districts: {', '.join(districts)})")

        # Фильтр по району (icontains для ловли вариантов "Есильский" / "Есильский район")
        if params.get('district'):
            complex_filters &= Q(features__district_name__icontains=params['district'])
            logger.info(f"🏘 DISTRICT FILTER (complexes): {params['district']}")

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
        
        # Фильтр по классу жилья
        property_class = params.get('property_class')
        if property_class and property_class != 'Не важно':
            if property_class in ["Стандарт", "Комфорт lite"]:
                queryset = queryset.filter(class_name__in=["Стандарт", "Комфорт lite"])
            elif property_class in ["Комфорт", "Комфорт+"]:
                queryset = queryset.filter(class_name__in=["Комфорт", "Комфорт+"])
            elif property_class in ["Бизнес", "Бизнес+"]:
                queryset = queryset.filter(class_name__in=["Бизнес", "Бизнес+"])
            else:
                queryset = queryset.filter(class_name=params.get('property_class'))
            logger.info(f"🏘 CLASS FILTER (complexes): {params.get('property_class')}")

        logger.info(f"🔍 Total complexes after filters: {queryset.count()}")
        
        if query_vector:
            queryset = queryset.alias(
                distance=CosineDistance('embedding', query_vector)
            ).order_by('distance')

        results = []
        processed = 0
        for comp in queryset[offset: offset + limit + 10]:
            processed += 1
            if bi_category == 'commercial' and bi_scope in ['complex']:
                if self._complex_matches_filters(comp, params):
                    results.append(comp)
            else:
                units = unit_model.objects.filter(complex=comp, is_active=True)
                units = self._apply_price_filters(
                    units, params.get('min_price'), params.get('max_price')
                )
                # Фильтр по комнатам с поддержкой множественного выбора
                if params.get('rooms'):
                    rooms_list = params['rooms'] if isinstance(params['rooms'], list) else [params['rooms']]
                    units = units.filter(room_count__in=rooms_list)
                if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
                if params.get('max_area'): units = units.filter(area__lte=params['max_area'])
                if units.exists():
                    results.append(comp)

            if len(results) >= limit:
                break

        logger.info(f"✅ Complexes returned: {len(results)}")
        return results, offset + processed

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
        units = self._apply_price_filters(
            units, params.get('min_price'), params.get('max_price')
        )
        # Фильтр по комнатам с поддержкой множественного выбора
        if params.get('rooms'):
            rooms_list = params['rooms'] if isinstance(params['rooms'], list) else [params['rooms']]
            units = units.filter(room_count__in=rooms_list)
        if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
        if params.get('max_area'): units = units.filter(area__lte=params['max_area'])
        # Фильтр по классу жилья (берется из комплекса)
        property_class = params.get('property_class')
        if property_class and property_class != 'Не важно':
            if property_class in ["Стандарт", "Комфорт lite"]:
                units = units.filter(complex__class_name__in=["Стандарт", "Комфорт lite"])
            elif property_class in ["Комфорт", "Комфорт+"]:
                units = units.filter(complex__class_name__in=["Комфорт", "Комфорт+"])
            elif property_class in ["Бизнес", "Бизнес+"]:
                units = units.filter(complex__class_name__in=["Бизнес", "Бизнес+"])
            else:
                units = units.filter(complex__class_name=params.get('property_class'))

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

        logger.info(f"🔎 intelligent_search called: source={source}, district={params.get('district')}, side={params.get('side')}, offset={offset}")

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
        lat_delta = None
        lon_delta = None
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
            logger.info(f"📍 GEO FILTER ACTIVE (BI): {lat}, {lon} (+/- {radius_km}km)")

        # Фильтр по берегу (BI - через features)
        if params.get('side') == 'Left':
            complex_filters &= Q(features__side='Left')
            logger.info(f"🏖 SIDE FILTER (BI): Left")
        elif params.get('side') == 'Right':
            complex_filters &= Q(features__side='Right')
            logger.info(f"🏖 SIDE FILTER (BI): Right")

        # Фильтр по району (BI - через features.district_name)
        if params.get('district'):
            complex_filters &= Q(features__district_name__icontains=params['district'])
            logger.info(f"🏘 DISTRICT FILTER (BI): {params['district']}")

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
            
            logger.info(f"🔍 Total BI complexes after filters: {target_complexes.count()}")

            # Если есть вектор, сортируем ЖК по смысловой близости
            if query_vector:
                target_complexes = target_complexes.alias(
                    distance=CosineDistance('embedding', query_vector)
                ).order_by('distance')

            # Для пагинации с группировкой нужно взять ЖК с запасом
            # (Offset применяем к списку ЖК, а не квартир)
            complexes_list = list(target_complexes[offset: offset + limit + 5])
            
            logger.info(f"📋 BI complexes slice [{offset}:{offset + limit + 5}]: {len(complexes_list)} items")

            for comp in complexes_list:
                comp_district = comp.features.get('district_name', 'N/A') if comp.features else 'N/A'
                comp_side = comp.features.get('side', 'N/A') if comp.features else 'N/A'
                logger.info(f"🏢 Processing complex: {comp.name} | District: {comp_district} | Side: {comp_side}")
                
                if query_vector and not coords:
                    pass

                best_unit = None

                # Для коммерции можно искать юниты, комплекс или оба варианта
                if not (bi_category == 'commercial' and bi_scope == 'complex'):
                    units = unit_model.objects.filter(complex=comp, is_active=True)

                    units = self._apply_price_filters(
                        units, params.get('min_price'), params.get('max_price')
                    )
                    # Фильтр по комнатам с поддержкой множественного выбора
                    if params.get('rooms'):
                        rooms_list = params['rooms'] if isinstance(params['rooms'], list) else [params['rooms']]
                        units = units.filter(room_count__in=rooms_list)
                    if params.get('min_area'): units = units.filter(area__gte=params['min_area'])
                    if params.get('max_area'): units = units.filter(area__lte=params['max_area'])

                    # Берем ОДНУ лучшую (самую дешевую) квартиру из этого ЖК для разнообразия
                    best_unit = units.order_by('price').first()
                    if best_unit:
                        logger.info(f"  ✅ Added unit from {comp.name} (district: {comp_district})")
                        results.append(mapper(best_unit, comp))

                # Если пользователю нужен объект целиком, добавляем комплекс как отдельный результат
                if bi_category == 'commercial' and bi_scope in ['complex', 'both'] and complex_mapper:
                    if self._complex_matches_filters(comp, params):
                        results.append(complex_mapper(comp))

                # Если набрали лимит, останавливаемся
                if len(results) >= limit:
                    break
            
            logger.info(f"✅ BI results added: {len(results)}")

        # --- 3. ПОИСК ВТОРИЧКИ ---
        if source in ['secondary', 'mixed'] and len(results) < limit:
            sec_props = SecondaryProperty.objects.filter(is_active=True, deal_type='sell')

            # Фильтр по категории вторичной недвижимости (apartment / commercial)
            secondary_category = params.get('secondary_category')
            if secondary_category == 'apartment':
                sec_props = sec_props.filter(property_type='apartment')
                logger.info("🏠 SECONDARY CATEGORY FILTER: apartment")
            elif secondary_category == 'commercial':
                sec_props = sec_props.filter(property_type='commercial')
                logger.info("🏢 SECONDARY CATEGORY FILTER: commercial")

            if lat is not None and lon is not None:
                sec_props = sec_props.filter(
                    latitude__range=(lat - lat_delta, lat + lat_delta),
                    longitude__range=(lon - lon_delta, lon + lon_delta)
                )
                logger.info(f"📍 GEO FILTER (secondary): {lat}, {lon} (+/- {radius_km}km)")

            sec_props = self._apply_price_filters(
                sec_props, params.get('min_price'), params.get('max_price')
            )

            # Фильтр по комнатам (только для жилой вторички)
            if params.get('rooms') and secondary_category != 'commercial':
                rooms_list = params['rooms'] if isinstance(params['rooms'], list) else [params['rooms']]
                sec_props = sec_props.filter(rooms__in=rooms_list)
            if params.get('min_area'): sec_props = sec_props.filter(area__gte=params['min_area'])
            if params.get('max_area'): sec_props = sec_props.filter(area__lte=params['max_area'])

            # Фильтр по берегу для вторички (через районы)
            if params.get('side'):
                if params['side'] == 'Left':
                    sec_side_q = (
                        Q(district__icontains='Есильский') |
                        Q(district__icontains='Нура') |
                        Q(district__icontains='Нуринский')
                    )
                else:
                    sec_side_q = (
                        Q(district__icontains='Сарыарка') |
                        Q(district__icontains='Сарыаркинский') |
                        Q(district__icontains='Алматинский') |
                        Q(district__icontains='Байконур') |
                        Q(district__icontains='Байконурский') |
                        Q(district__icontains='Сарайшык') |
                        Q(district__icontains='Сарайшық')
                    )
                sec_props = sec_props.filter(sec_side_q)
                logger.info(f"🏖 SIDE FILTER (secondary): {params['side']}")

            # Фильтр по району с учётом вариантов написания
            if params.get('district'):
                district = params['district']
                # Для Сарыарка ищем и "Сарыарка", и "Сарыаркинский"
                if district == 'Сарыарка':
                    sec_props = sec_props.filter(
                        Q(district__icontains='Сарыарка') | Q(district__icontains='Сарыаркинский')
                    )
                # Для Нура ищем и "Нура", и "Нуринский"
                elif district == 'Нура':
                    sec_props = sec_props.filter(
                        Q(district__icontains='Нура') | Q(district__icontains='Нуринский')
                    )
                else:
                    sec_props = sec_props.filter(district__icontains=district)
                logger.info(f"🏘 DISTRICT FILTER (secondary): {district}")

            # Вектор
            if query_vector:
                sec_props = sec_props.alias(distance=CosineDistance('embedding', query_vector)).order_by('distance')
            else:
                sec_props = sec_props.order_by('-created_at')

            logger.info(f"🔍 Total secondary after filters: {sec_props.count()}")

            # Добираем вторичкой остаток лимита (с учетом offset для вторички можно сделать отдельную логику, но пока упростим)
            sec_limit = limit - len(results)
            sec_results = sec_props[offset: offset + sec_limit]

            for item in sec_results:
                logger.info(f"🏠 Secondary property: {item.title} | District: {item.district}")
                results.append(self._map_secondary_to_dto(item))
            
            logger.info(f"✅ Secondary returned: {len(sec_results)}")

        # Сортировка смешанной выдачи
        if source == 'mixed':
            results.sort(key=lambda x: (0 if x.source == 'bi_group' else 1, x.price))

        logger.info(f"📦 Total results (BI + Secondary): {len(results)}")
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
        
        logger.info(f"🔀 MIXED SEARCH: district={params.get('district')}, side={params.get('side')}, coords={params.get('coordinates')}")

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

        desc = f"📍 {side} берег | {district}\n✨ {tags}\nЗавершение строительства: {unit.deadline}"

        photos = unit.photos or []
        primary_photo = photos[0] if photos else comp.image_url

        unit_url = f"https://bi.group/ru/filter/placement/{unit.bi_uuid}"

        return PropertyDTO(
            source="bi_group",
            title=f"ЖК {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            property_class=comp.class_name,
            description=desc,
            url=unit_url,
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

        desc = f"🏢 {side} берег | {district}\n✨ {tags}\nЗавершение строительства: {unit.deadline}"

        photos = unit.photos or []
        primary_photo = photos[0] if photos else comp.image_url

        unit_url = f"https://bi.group/ru/filter/placement/{unit.bi_uuid}"

        return PropertyDTO(
            source="bi_group",
            title=f"БЦ {comp.name}",
            address=comp.address,
            price=float(unit.price),
            rooms=unit.room_count,
            area=unit.area,
            floor=unit.floor,
            total_floors=unit.max_floor,
            property_class=comp.class_name,
            description=desc,
            url=unit_url,
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
            property_class=comp.class_name,
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
            property_class=comp.class_name,
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
        is_commercial = (item.property_type or '').lower() == 'commercial'
        return PropertyDTO(
            source="secondary",
            title=item.title,
            address=item.address,
            price=float(item.price),
            rooms=item.rooms if not is_commercial else 0,
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
            building_type='commercial' if is_commercial else None,
        )