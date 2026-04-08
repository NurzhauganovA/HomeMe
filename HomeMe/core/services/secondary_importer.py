import json
from decimal import Decimal, InvalidOperation

from telegram_bot.models import SecondaryProperty
from core.location_resolver import DynamicLocationResolver
from core.services.ai_service import EnhancedAIService


class SecondaryImporter:
    def __init__(self, do_geocode: bool = True, do_embed: bool = True):
        self.do_geocode = do_geocode
        self.do_embed = do_embed
        self.ai_service = EnhancedAIService() if (do_geocode or do_embed) else None
        self.location_resolver = DynamicLocationResolver(self.ai_service) if do_geocode else None
        self.geo_cache = {}

    def import_items(self, items):
        items = self._normalize_items(items)
        created = 0
        updated = 0
        skipped = 0

        for item in items:
            if not isinstance(item, dict):
                skipped += 1
                continue

            action = item.get("action")
            if not action and isinstance(item.get("data"), dict):
                action = item.get("data", {}).get("action")
            payload = self._extract_payload(item)
            if not payload:
                skipped += 1
                continue

            if not action and isinstance(payload, dict):
                action = payload.get("action")

            ext_uuid = payload.get("uuid")
            if not ext_uuid:
                skipped += 1
                continue

            if action == "archive" or action == "delete":
                obj = SecondaryProperty.objects.filter(external_uuid=ext_uuid).first()
                if not obj:
                    skipped += 1
                    continue
                if obj.is_active:
                    obj.is_active = False
                    obj.save(update_fields=["is_active"])
                updated += 1
                continue

            if action == "restore":
                obj = SecondaryProperty.objects.filter(external_uuid=ext_uuid).first()
                if not obj:
                    skipped += 1
                    continue
                if not obj.is_active:
                    obj.is_active = True
                    obj.save(update_fields=["is_active"])
                updated += 1
                continue

            price = self._to_decimal(payload.get("price"))
            if price is None:
                skipped += 1
                continue

            area = payload.get("area") or 0
            rooms = payload.get("rooms") or 0
            floor = payload.get("floor") or 0
            floors_total = payload.get("floors_total") or 0

            title = self._build_title(payload)
            address = payload.get("address_note") or self._build_address(payload)

            owner_phone, owner_name = self._extract_contact(payload)

            facilities = payload.get("facilities") or []
            has_parking = "covered_parking" in facilities or "parking" in facilities
            has_balcony = bool(payload.get("balcony"))
            has_renovation = bool(payload.get("repair"))

            photos = self._extract_photos(payload)
            payload_latitude = self._to_float(payload.get("latitude"))
            payload_longitude = self._to_float(payload.get("longitude"))
            has_payload_coordinates = payload_latitude is not None and payload_longitude is not None

            defaults = {
                "title": title,
                "description": payload.get("description") or "",
                "address": address,
                "price": price,
                "rooms": rooms,
                "area": area,
                "floor": floor,
                "total_floors": floors_total or 1,
                "city": payload.get("city"),
                "district": payload.get("city_district") or payload.get("district"),
                "owner_phone": owner_phone or "-",
                "owner_name": owner_name or "Не указано",
                "has_parking": has_parking,
                "has_balcony": has_balcony,
                "has_renovation": has_renovation,
                "latitude": payload_latitude,
                "longitude": payload_longitude,
                "coordinates_source": "payload" if has_payload_coordinates else None,
                "external_uuid": ext_uuid,
                "external_id": payload.get("id"),
                "property_type": payload.get("type"),
                "subtype": payload.get("subtype"),
                "deal_type": payload.get("category"),
                "rent_type": payload.get("rent_type"),
                "currency": payload.get("currency"),
                "condition": payload.get("condition"),
                "repair": payload.get("repair"),
                "construction_year": payload.get("construction_year"),
                "ceiling_height": self._to_float(payload.get("ceiling_height")),
                "material": payload.get("material") or [],
                "address_note": payload.get("address_note"),
                "source_url": payload.get("source_url") or payload.get("external_link") or "",
                "prices": payload.get("prices") if isinstance(payload.get("prices"), dict) else {},
                "prices_m2": payload.get("prices_m2") if isinstance(payload.get("prices_m2"), dict) else {},
                "rooms_total": self._to_int(payload.get("rooms_total")),
                "area_living": self._to_float(payload.get("area_living")),
                "area_kitchen": self._to_float(payload.get("area_kitchen")),
                "city_micro_district": payload.get("city_micro_district"),
                "photos": photos,
                "raw_data": payload,
                "is_active": True,
            }

            obj, was_created = SecondaryProperty.objects.update_or_create(
                external_uuid=ext_uuid,
                defaults=defaults
            )

            if self.do_geocode and (obj.latitude is None or obj.longitude is None):
                if address:
                    coords = self._resolve_coordinates(address, obj.city)
                    if coords:
                        obj.latitude = coords[0]
                        obj.longitude = coords[1]
                        obj.coordinates_source = "geocoded"
                        obj.save(update_fields=["latitude", "longitude", "coordinates_source"])

            if self.do_embed and obj.embedding is None and self.ai_service:
                text = obj.get_full_text()
                embedding = self.ai_service.get_embedding(text)
                if embedding:
                    obj.embedding = embedding
                    obj.save(update_fields=["embedding"])

            if was_created:
                created += 1
            else:
                updated += 1

        return {"created": created, "updated": updated, "skipped": skipped}

    @staticmethod
    def _extract_payload(item):
        if not isinstance(item, dict):
            return {}
        # Accept both "data": {...} and "data": {"data": {...}} formats
        data = item.get("data")
        if isinstance(data, dict) and "data" in data and isinstance(data.get("data"), dict):
            return data.get("data") or {}
        if isinstance(data, dict):
            return data
        # Fallback: treat item itself as payload if it has uuid/price keys
        if item.get("uuid") or item.get("price"):
            return item
        return {}

    @staticmethod
    def _normalize_items(items):
        if isinstance(items, str):
            items = json.loads(items)
        if isinstance(items, dict):
            return [items]
        return items or []

    @staticmethod
    def _to_decimal(value):
        if value is None:
            return None
        try:
            return Decimal(str(value))
        except (InvalidOperation, ValueError):
            return None

    @staticmethod
    def _build_address(payload):
        parts = [
            payload.get("city"),
            payload.get("city_district") or payload.get("district"),
            payload.get("street"),
            payload.get("building"),
        ]
        return ", ".join([p for p in parts if p])

    @staticmethod
    def _build_title(payload):
        prop_type = payload.get("type") or "object"
        rooms = payload.get("rooms")
        area = payload.get("area")
        city = payload.get("city") or ""

        if prop_type == "apartment" and rooms:
            return f"{rooms}-комн, {area} м², {city}"
        if prop_type == "commercial":
            raw_subtype = (payload.get("subtype") or "").strip()

            # Маппинг технических/англ. значений на понятные русские названия
            subtype_map = {
                "free_appointment": "Коммерческое помещение",  # свободная планировка
                "office": "Офис",
                "store": "Магазин",
                "shop": "Магазин",
            }
            # Приводим к нижнему регистру для сравнения, но показываем уже человеко‑читаемое
            key = raw_subtype.lower()
            subtype_label = subtype_map.get(key) or (raw_subtype or "Коммерческое помещение")

            return f"{subtype_label} {area} м², {city}".strip()
        return f"{prop_type} {area} м², {city}".strip()

    @staticmethod
    def _extract_photos(payload):
        """
        ILVO может присылать фото как `photos`, а старые источники как `_photos`.
        Поддерживаем оба формата и сохраняем только непустые URL.
        """
        photos = payload.get("photos")
        if photos is None:
            photos = payload.get("_photos")
        if not isinstance(photos, list):
            return []
        return [p for p in photos if isinstance(p, str) and p.strip()]

    @staticmethod
    def _extract_contact(payload):
        """
        Поддержка нескольких форматов контактов:
        1) phones: [{"number": "...", "name": "..."}]
        2) phones: ["7700..."]
        3) responsible: {"first_name": "...", "last_name": "...", "phones": ["7700..."]}
        """
        owner_phone = ""
        owner_name = ""

        phones = payload.get("phones")
        if isinstance(phones, list) and phones:
            first_phone = phones[0]
            if isinstance(first_phone, dict):
                owner_phone = str(first_phone.get("number") or "").strip()
                owner_name = str(first_phone.get("name") or "").strip()
            elif isinstance(first_phone, str):
                owner_phone = first_phone.strip()

        responsible = payload.get("responsible")
        if isinstance(responsible, dict):
            if not owner_name:
                first_name = str(responsible.get("first_name") or "").strip()
                last_name = str(responsible.get("last_name") or "").strip()
                owner_name = " ".join([p for p in [first_name, last_name] if p]).strip()

            if not owner_phone:
                resp_phones = responsible.get("phones")
                if isinstance(resp_phones, list) and resp_phones:
                    first_resp_phone = resp_phones[0]
                    if isinstance(first_resp_phone, str):
                        owner_phone = first_resp_phone.strip()
                    elif isinstance(first_resp_phone, dict):
                        owner_phone = str(first_resp_phone.get("number") or "").strip()

        if owner_phone:
            owner_phone = owner_phone.replace(" ", "")[:20]
        if owner_name:
            owner_name = owner_name[:100]

        return owner_phone, owner_name

    @staticmethod
    def _to_float(value):
        if value is None or value == "":
            return None
        try:
            return float(value)
        except (ValueError, TypeError):
            return None

    @staticmethod
    def _to_int(value):
        if value is None or value == "":
            return None
        try:
            return int(value)
        except (ValueError, TypeError):
            return None

    def _resolve_coordinates(self, address: str, city_hint: str = None):
        if not self.location_resolver:
            return None
        if address in self.geo_cache:
            return self.geo_cache[address]
        try:
            location_data = self.location_resolver.resolve_any_location(address, city_hint=city_hint or "Astana")
            center = location_data.get("center_coordinates") if location_data else None
            if center and len(center) >= 2:
                coords = (center[0], center[1])
                self.geo_cache[address] = coords
                return coords
        except Exception:
            return None
        return None
