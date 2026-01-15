import requests
import logging
from django.conf import settings
from core.dto import PropertyDTO
from core.location_resolver import (
    resolve_location,
    within_location,
    text_matches_location,
    infer_city_from_district,
)

logger = logging.getLogger(__name__)


class BIGroupClient:
    COMPANY_IDS = ["4a9425ed-8abd-11ee-ab79-001dd8b7289a"]
    PROPERTY_TYPES = [
        "5990a172-812a-4fee-b4f5-c860cca824d7",
        "b6e20785-9b33-46a9-86b5-707fdbffe314",
        "a6deff39-99d2-4a4c-982c-b245b7e43037",
        "b3be088f-52d2-47af-93d5-0667312547c9",
        "8f72b6b1-0453-4938-9775-0f2f3a836ccd",
        "1429f97b-e73f-4bd4-8b59-a4c779b4db34"
    ]

    # UUID городов из API BI Group
    CITY_MAP = {
        "Astana": "4c0fe725-4b6f-11e8-80cf-bb580b2abfef",
        "Almaty": "6ba77338-4db7-11e8-80cf-bb580b2abfef",
        "Shymkent": "cf5ad35a-9bc1-11e8-80d7-00155da7893d",
        "Atyrau": "038dfc7d-8153-11e9-80e3-001dd8b726aa"  # Примерный, лучше проверить
    }

    def __init__(self):
        # Исправленный URL
        self.api_url = getattr(settings, 'BI_GROUP_API_URL',
                               "https://apigw.bi.group/sales-picker/microfe-v3/realEstateList")

    def search_properties(self, rooms=None, max_price=None, city=None, district=None, location=None,
                          location_keywords=None, limit=10) -> list[PropertyDTO]:
        payload = {
            "companyIds": self.COMPANY_IDS,
            "propertyTypes": self.PROPERTY_TYPES,
            "pageNo": 1,
            "pageSize": 200  # Берем больше, чтобы было из чего фильтровать
        }

        # Заголовки "под браузер"
        headers = {
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            "Accept": "application/json, text/plain, */*",
            "Content-Type": "application/json",
            "Origin": "https://bi.group",
            "Referer": "https://bi.group/"
        }

        try:
            response = requests.post(self.api_url, json=payload, headers=headers, timeout=10)
            response.raise_for_status()
            data = response.json()
            # Передаем параметры фильтрации в парсер
            return self._parse_response(data, rooms, max_price, city, district, location, location_keywords)[:limit]
        except Exception as e:
            logger.error(f"BI Group API Error: {e}")
            return []

    def _parse_response(self, data, filter_rooms, filter_price, filter_city_name, filter_district,
                        filter_location, filter_keywords) -> list[PropertyDTO]:
        results = []
        real_estates = data.get("realEstates", [])

        if not filter_city_name and filter_district:
            inferred_city = infer_city_from_district(filter_district)
            if inferred_city:
                filter_city_name = inferred_city

        # Если передали готовый location, используем его. Иначе пробуем вывести из district.
        active_location = filter_location or resolve_location(filter_city_name, filter_district)

        # Получаем UUID города по имени (Astana -> uuid)
        target_city_uuid = self.CITY_MAP.get(filter_city_name) if filter_city_name else None

        for item in real_estates:
            # 1. Фильтр по Городу (UUID)
            if target_city_uuid:
                item_city_uuid = item.get("cityUUID")
                if item_city_uuid != target_city_uuid:
                    continue  # Пропускаем, если город не совпал

            # 2. Фильтр по Цене
            price = float(item.get("minTotalPrice", 0))
            if filter_price and price > filter_price:
                continue

            # 3. Фильтр по Комнатам
            rooms_list = item.get("roomCounts", [])
            rooms = rooms_list[0] if rooms_list else 0
            if filter_rooms and filter_rooms not in rooms_list:
                continue

            title = item.get("name", "")
            address = item.get("address", "")

            # 4. Фильтр по Району (District) — георадиус + текст
            if active_location:
                item_lat = item.get("latitude")
                item_lon = item.get("longitude")
                in_geo = False
                try:
                    if item_lat is not None and item_lon is not None:
                        in_geo = within_location(float(item_lat), float(item_lon), active_location)
                except (TypeError, ValueError):
                    in_geo = False

                in_text = text_matches_location(title, active_location) or text_matches_location(address, active_location)
                if filter_keywords:
                    lowered = (title or "").lower() + " " + (address or "").lower()
                    for kw in filter_keywords:
                        if kw and kw.lower() in lowered:
                            in_text = True
                            break

                if not (in_geo or in_text):
                    continue
            else:
                text_match_ok = True
                if filter_district:
                    search_text = filter_district.lower()
                    if (search_text not in title.lower()) and (search_text not in address.lower()):
                        text_match_ok = False
                if filter_keywords and text_match_ok is False:
                    lowered = (title or "").lower() + " " + (address or "").lower()
                    for kw in filter_keywords:
                        if kw and kw.lower() in lowered:
                            text_match_ok = True
                            break
                if not text_match_ok:
                    continue

            dto = PropertyDTO(
                source="bi_group",
                title=title or "ЖК BI Group",
                address=address or "Адрес не указан",
                price=price,
                rooms=rooms,
                area=float(item.get("squareMin", 0)),
                floor=item.get("floorMin", 0),
                description=f"Сдача: {item.get('deadline')}",
                url=item.get("website", ""),
                image_url=item.get("photoURL400", "")
            )
            results.append(dto)
        return results