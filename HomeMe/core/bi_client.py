"""
Enhanced BI Group API Client
Профессиональная интеграция с API BI Group с интеллектуальной фильтрацией,
обработкой ошибок, retry-логикой и геопоиском.
"""

import requests
import logging
import time
from typing import List, Optional, Dict, Tuple
from django.conf import settings
from core.dto import PropertyDTO
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

logger = logging.getLogger(__name__)


class BIGroupAPIError(Exception):
    """Кастомное исключение для ошибок BI Group API"""
    pass


class EnhancedBIGroupClient:
    """
    Профессиональный клиент для работы с BI Group API.
    Поддерживает: retry, timeout, геофильтрацию, кэширование.
    """

    # Константы API
    COMPANY_IDS = ["4a9425ed-8abd-11ee-ab79-001dd8b7289a"]
    PROPERTY_TYPES = [
        "5990a172-812a-4fee-b4f5-c860cca824d7",
        "b6e20785-9b33-46a9-86b5-707fdbffe314",
        "a6deff39-99d2-4a4c-982c-b245b7e43037",
        "b3be088f-52d2-47af-93d5-0667312547c9",
        "8f72b6b1-0453-4938-9775-0f2f3a836ccd",
        "1429f97b-e73f-4bd4-8b59-a4c779b4db34"
    ]
    COMMERCIAL_PROPERTY_TYPES = [
        "f25589d6-e6f4-43b9-beac-d6698f86b0a3",
        "e8f04293-b2d7-46a7-8ccb-ea022a151c94"
    ]

    # UUID городов
    CITY_MAP = {
        "Astana": "4c0fe725-4b6f-11e8-80cf-bb580b2abfef",
        "Almaty": "6ba77338-4db7-11e8-80cf-bb580b2abfef",
        "Shymkent": "cf5ad35a-9bc1-11e8-80d7-00155da7893d",
        "Atyrau": "038dfc7d-8153-11e9-80e3-001dd8b726aa"
    }

    # Reverse mapping для логирования
    CITY_UUID_TO_NAME = {v: k for k, v in CITY_MAP.items()}

    def __init__(self):
        self.api_url = getattr(
            settings,
            'BI_GROUP_API_URL',
            "https://apigw.bi.group/sales-picker/microfe-v3/realEstateList"
        )

        # Настройка сессии с retry
        self.session = self._create_session_with_retry()

        # Кэш для результатов (TTL: 5 минут)
        self._cache = {}
        self._cache_ttl = 300  # секунды
        self._last_cache_clear = time.time()

    def _create_session_with_retry(self) -> requests.Session:
        """Создает HTTP сессию с автоматическими retry"""
        session = requests.Session()

        # Настройка retry стратегии
        retry_strategy = Retry(
            total=3,  # 3 попытки
            backoff_factor=1,  # 1s, 2s, 4s между попытками
            status_forcelist=[429, 500, 502, 503, 504],
            allowed_methods=["POST", "GET"]
        )

        adapter = HTTPAdapter(max_retries=retry_strategy)
        session.mount("https://", adapter)
        session.mount("http://", adapter)

        return session

    def _get_headers(self) -> Dict[str, str]:
        """Возвращает заголовки для запроса"""
        return {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
            "Accept": "application/json, text/plain, */*",
            "Content-Type": "application/json",
            "Origin": "https://bi.group",
            "Referer": "https://bi.group/"
        }

    def _clear_expired_cache(self):
        """Очищает устаревший кэш"""
        current_time = time.time()
        if current_time - self._last_cache_clear > self._cache_ttl:
            self._cache.clear()
            self._last_cache_clear = current_time
            logger.info("🗑 Cache cleared (TTL expired)")

    def _generate_cache_key(self, **kwargs) -> str:
        """Генерирует ключ кэша из параметров"""
        sorted_items = sorted(kwargs.items())
        return "|".join(f"{k}:{v}" for k, v in sorted_items if v is not None)

    def search_properties(
            self,
            rooms: Optional[List[int]] = None,  # Поддержка множественного выбора комнат
            max_price: Optional[float] = None,
            min_price: Optional[float] = None,
            min_area: Optional[float] = None,
            max_area: Optional[float] = None,
            city: Optional[str] = None,
            district: Optional[str] = None,
            geo_center: Optional[Tuple[float, float]] = None,
            geo_radius_km: Optional[float] = None,
            location_keywords: Optional[List[str]] = None,
            limit: int = 10
    ) -> List[PropertyDTO]:
        """
        Главный метод поиска недвижимости в BI Group.

        Args:
            rooms: Количество комнат
            max_price: Максимальная цена в тенге
            min_price: Минимальная цена в тенге
            min_area: Минимальная площадь в м²
            max_area: Максимальная площадь в м²
            city: Название города ("Astana", "Almaty", etc.)
            district: Название района
            geo_center: Координаты центра (lat, lon)
            geo_radius_km: Радиус поиска в км
            location_keywords: Ключевые слова для текстового поиска
            limit: Максимальное количество результатов

        Returns:
            Список PropertyDTO объектов
        """
        self._clear_expired_cache()

        # Проверяем кэш
        cache_key = self._generate_cache_key(
            rooms=rooms,
            max_price=max_price,
            min_price=min_price,
            city=city,
            district=district,
            limit=limit
        )

        if cache_key in self._cache:
            logger.info(f"📦 BI Group cache hit: {cache_key[:50]}...")
            return self._cache[cache_key]

        logger.info(f"🔍 BI Group search: city={city}, rooms={rooms}, "
                    f"price={min_price}-{max_price}, district={district}")

        try:
            # Получаем сырые данные из API
            raw_data = self._fetch_from_api()

            # Фильтруем и преобразуем
            results = self._filter_and_parse(
                raw_data=raw_data,
                rooms=rooms,
                max_price=max_price,
                min_price=min_price,
                min_area=min_area,
                max_area=max_area,
                city=city,
                district=district,
                geo_center=geo_center,
                geo_radius_km=geo_radius_km,
                location_keywords=location_keywords
            )

            # Сортируем по приоритету продаж
            results = self._sort_by_priority(results)

            # Ограничиваем количество
            results = results[:limit]

            # Кэшируем результат
            self._cache[cache_key] = results

            logger.info(f"✅ BI Group: found {len(results)} properties")
            return results

        except Exception as e:
            logger.error(f"❌ BI Group API error: {e}")
            return []

    def _fetch_from_api(self) -> Dict:
        """Выполняет запрос к API BI Group"""
        payload = {
            "companyIds": self.COMPANY_IDS,
            "propertyTypes": self.PROPERTY_TYPES,
            "pageNo": 1,
            "pageSize": 200  # Максимум для фильтрации
        }

        try:
            response = self.session.post(
                self.api_url,
                json=payload,
                headers=self._get_headers(),
                timeout=10
            )
            response.raise_for_status()
            return response.json()

        except requests.exceptions.Timeout:
            logger.error("⏱ BI Group API timeout")
            raise BIGroupAPIError("API timeout")
        except requests.exceptions.HTTPError as e:
            logger.error(f"🔴 BI Group HTTP error: {e}")
            raise BIGroupAPIError(f"HTTP error: {e}")
        except requests.exceptions.RequestException as e:
            logger.error(f"🔴 BI Group request error: {e}")
            raise BIGroupAPIError(f"Request error: {e}")

    def _filter_and_parse(
            self,
            raw_data: Dict,
            rooms: Optional[int],
            max_price: Optional[float],
            min_price: Optional[float],
            min_area: Optional[float],
            max_area: Optional[float],
            city: Optional[str],
            district: Optional[str],
            geo_center: Optional[Tuple[float, float]],
            geo_radius_km: Optional[float],
            location_keywords: Optional[List[str]]
    ) -> List[PropertyDTO]:
        """
        Фильтрует и парсит результаты API.
        Применяет все фильтры последовательно.
        """
        results = []
        real_estates = raw_data.get("realEstates", [])

        if not real_estates:
            logger.warning("⚠️ BI Group API returned no results")
            return []

        logger.info(f"📊 Processing {len(real_estates)} raw properties from API")

        # Получаем UUID города
        target_city_uuid = self.CITY_MAP.get(city) if city else None

        for item in real_estates:
            # Применяем фильтры
            if not self._apply_filters(
                    item=item,
                    target_city_uuid=target_city_uuid,
                    rooms=rooms,
                    max_price=max_price,
                    min_price=min_price,
                    min_area=min_area,
                    max_area=max_area,
                    district=district,
                    geo_center=geo_center,
                    geo_radius_km=geo_radius_km,
                    location_keywords=location_keywords
            ):
                continue

            # Конвертируем в DTO
            dto = self._convert_to_dto(item)
            if dto:
                results.append(dto)

        logger.info(f"✅ After filtering: {len(results)} properties")
        return results

    def _apply_filters(
            self,
            item: Dict,
            target_city_uuid: Optional[str],
            rooms: Optional[int],
            max_price: Optional[float],
            min_price: Optional[float],
            min_area: Optional[float],
            max_area: Optional[float],
            district: Optional[str],
            geo_center: Optional[Tuple[float, float]],
            geo_radius_km: Optional[float],
            location_keywords: Optional[List[str]]
    ) -> bool:
        """
        Применяет все фильтры к одному объекту.
        Возвращает True если объект прошел все фильтры.
        """

        # Фильтр 1: Город
        if target_city_uuid:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != target_city_uuid:
                return False

        # Фильтр 2: Цена
        price = float(item.get("minTotalPrice", 0))
        if max_price and price > max_price:
            return False
        if min_price and price < min_price:
            return False

        # Фильтр 3: Комнаты (с поддержкой множественного выбора)
        item_rooms_list = item.get("roomCounts", [])
        if rooms:
            # Если rooms - список, проверяем пересечение
            if isinstance(rooms, list):
                if not any(r in item_rooms_list for r in rooms):
                    return False
            else:
                # Если rooms - одно число
                if rooms not in item_rooms_list:
                    return False

        # Фильтр 4: Площадь
        square_min = item.get("squareMin", 0)
        square_max = item.get("squareMax", 0)

        if min_area and square_max < min_area:
            return False
        if max_area and square_min > max_area:
            return False

        # Фильтр 5: Геолокация (радиус)
        if geo_center and geo_radius_km:
            lat = item.get("latitude")
            lon = item.get("longitude")

            if lat and lon:
                if not self._is_within_radius(lat, lon, geo_center, geo_radius_km):
                    return False

        # Фильтр 6: Текстовый поиск (район, ключевые слова)
        if district or location_keywords:
            title = item.get("name", "").lower()
            address = item.get("address", "").lower()
            combined_text = f"{title} {address}"

            # Проверяем район
            if district and district.lower() not in combined_text:
                # Если есть location_keywords, даем второй шанс
                if not location_keywords:
                    return False

            # Проверяем ключевые слова
            if location_keywords:
                found = False
                for keyword in location_keywords:
                    if keyword and keyword.lower() in combined_text:
                        found = True
                        break
                if not found:
                    return False

        return True

    @staticmethod
    def _is_within_radius(
            lat: float,
            lon: float,
            center: Tuple[float, float],
            radius_km: float
    ) -> bool:
        """Проверяет, находится ли точка в радиусе от центра"""
        import math

        R = 6371  # Радиус Земли в км

        lat1, lon1 = math.radians(center[0]), math.radians(center[1])
        lat2, lon2 = math.radians(lat), math.radians(lon)

        dlat = lat2 - lat1
        dlon = lon2 - lon1

        a = (math.sin(dlat / 2) ** 2 +
             math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

        distance = R * c
        return distance <= radius_km

    def _convert_to_dto(self, item: Dict) -> Optional[PropertyDTO]:
        """Конвертирует API response в PropertyDTO"""
        try:
            # Извлекаем данные
            title = item.get("name", "ЖК BI Group")
            address = item.get("address", "Адрес не указан")

            price = float(item.get("minTotalPrice", 0))

            rooms_list = item.get("roomCounts", [])
            rooms = rooms_list[0] if rooms_list else 0

            area = float(item.get("squareMin", 0))
            floor = item.get("floorMin", 0)

            # Формируем описание
            deadline = item.get("deadline", "")
            property_class = item.get("propertyClassName", [])
            class_str = property_class[0] if property_class else ""

            description_parts = []
            if deadline:
                description_parts.append(f"Сдача: {deadline}")
            if class_str:
                description_parts.append(f"Класс: {class_str}")

            placement_count = item.get("placementCount", 0)
            if placement_count:
                description_parts.append(f"Доступно: {placement_count} квартир")

            description = " | ".join(description_parts)

            # URL и фото
            url = item.get("website", "")
            image_url = item.get("photoURL400", "") or item.get("photoURL", "")

            return PropertyDTO(
                source="bi_group",
                title=title,
                address=address,
                price=price,
                rooms=rooms,
                area=area,
                floor=floor,
                description=description,
                url=url,
                image_url=image_url
            )

        except Exception as e:
            logger.error(f"❌ Failed to convert item to DTO: {e}")
            return None

    def _sort_by_priority(self, results: List[PropertyDTO]) -> List[PropertyDTO]:
        """Сортирует результаты по приоритету"""
        # Сортируем по цене (дешевле - выше)
        # В будущем можно добавить приоритет продаж из API
        return sorted(results, key=lambda x: x.price)

    def get_property_by_uuid(self, uuid: str) -> Optional[PropertyDTO]:
        """
        Получает конкретный объект по UUID.
        Полезно для deep linking.
        """
        try:
            raw_data = self._fetch_from_api()
            real_estates = raw_data.get("realEstates", [])

            for item in real_estates:
                if item.get("uuid") == uuid:
                    return self._convert_to_dto(item)

            logger.warning(f"⚠️ Property with UUID {uuid} not found")
            return None

        except Exception as e:
            logger.error(f"❌ Error fetching property by UUID: {e}")
            return None

    def get_statistics(self) -> Dict:
        """
        Возвращает статистику по доступным объектам.
        Полезно для аналитики.
        """
        try:
            raw_data = self._fetch_from_api()
            real_estates = raw_data.get("realEstates", [])

            stats = {
                "total_objects": len(real_estates),
                "by_city": {},
                "price_range": {"min": float('inf'), "max": 0},
                "room_types": set()
            }

            for item in real_estates:
                # По городам
                city_uuid = item.get("cityUUID")
                city_name = self.CITY_UUID_TO_NAME.get(city_uuid, "Unknown")
                stats["by_city"][city_name] = stats["by_city"].get(city_name, 0) + 1

                # Цены
                price = float(item.get("minTotalPrice", 0))
                stats["price_range"]["min"] = min(stats["price_range"]["min"], price)
                stats["price_range"]["max"] = max(stats["price_range"]["max"], price)

                # Комнаты
                for room in item.get("roomCounts", []):
                    stats["room_types"].add(room)

            stats["room_types"] = sorted(list(stats["room_types"]))

            return stats

        except Exception as e:
            logger.error(f"❌ Error getting statistics: {e}")
            return {}

    def get_all_real_estates(self) -> List[Dict]:
        """Получает ВСЕ ЖК (обходим пагинацию)"""
        all_items = []
        page = 1
        page_size = 100  # Ставим побольше

        while True:
            payload = {
                "companyIds": self.COMPANY_IDS,
                "propertyTypes": self.PROPERTY_TYPES,
                "pageNo": page,
                "pageSize": page_size
            }
            try:
                data = self._make_request("https://apigw.bi.group/sales-picker/microfe-v3/realEstateList", payload)
                items = data.get("realEstates", [])

                if not items:
                    break

                all_items.extend(items)
                logger.info(f"📥 Fetched page {page} of RealEstates (got {len(items)})")

                if len(items) < page_size:  # Последняя страница
                    break
                page += 1

            except Exception as e:
                logger.error(f"❌ Error fetching real estates page {page}: {e}")
                break

        return all_items

    def get_all_commercial_real_estates(self) -> List[Dict]:
        """Получает ВСЕ коммерческие объекты (обходит пагинацию)"""
        all_items = []
        page = 1
        page_size = 100

        while True:
            payload = {
                "companyIds": self.COMPANY_IDS,
                "propertyTypes": self.COMMERCIAL_PROPERTY_TYPES,
                "pageNo": page,
                "pageSize": page_size
            }
            try:
                data = self._make_request("https://apigw.bi.group/sales-picker/microfe-v3/realEstateList", payload)
                items = data.get("realEstates", [])

                if not items:
                    break

                all_items.extend(items)
                logger.info(f"📥 Fetched page {page} of Commercial RealEstates (got {len(items)})")

                if len(items) < page_size:
                    break
                page += 1
            except Exception as e:
                logger.error(f"❌ Error fetching commercial real estates page {page}: {e}")
                break

        return all_items

    def get_placements_for_complex(self, complex_uuid: str) -> List[Dict]:
        """Получает ВСЕ квартиры конкретного ЖК"""
        all_placements = []
        page = 1
        page_size = 50

        while True:
            payload = {
                "companyIds": self.COMPANY_IDS,
                "propertyTypes": self.PROPERTY_TYPES,
                "realEstateUUIDs": [complex_uuid],
                "pageNo": page,
                "pageSize": page_size
            }
            try:
                data = self._make_request("https://apigw.bi.group/sales-picker/microfe-v3/placementList", payload)
                items = data.get("placements", [])

                if not items:
                    break

                all_placements.extend(items)

                if len(items) < page_size:
                    break
                page += 1

            except Exception as e:
                # Некоторые ЖК могут не иметь квартир в продаже
                break

        return all_placements

    def get_commercial_placements_for_complex(self, complex_uuid: str) -> List[Dict]:
        """Получает ВСЕ помещения конкретного коммерческого объекта"""
        all_placements = []
        page = 1
        page_size = 50

        while True:
            payload = {
                "companyIds": self.COMPANY_IDS,
                "propertyTypes": self.COMMERCIAL_PROPERTY_TYPES,
                "realEstateUUIDs": [complex_uuid],
                "pageNo": page,
                "pageSize": page_size
            }
            try:
                data = self._make_request("https://apigw.bi.group/sales-picker/microfe-v3/placementList", payload)
                items = data.get("placements", [])

                if not items:
                    break

                all_placements.extend(items)

                if len(items) < page_size:
                    break
                page += 1
            except Exception:
                break

        return all_placements

    def get_placement_details(self, placement_uuid: str) -> Dict:
        """Получает детальные данные по квартире/помещению"""
        payload = {"placementUUID": placement_uuid}
        try:
            return self._make_request(
                "https://apigw.bi.group/sales-picker/microfe-v3/placement",
                payload
            )
        except Exception as e:
            logger.error(f"❌ Error fetching placement details {placement_uuid}: {e}")
            return {}

    def _make_request(self, url: str, payload: Dict) -> Dict:
        """Вспомогательный метод для чистоты кода"""
        response = self.session.post(url, json=payload, headers=self._get_headers(), timeout=10)
        response.raise_for_status()
        return response.json()