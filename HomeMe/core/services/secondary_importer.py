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
            action = item.get("action") if isinstance(item, dict) else None
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

            if action == "archive":
                obj = SecondaryProperty.objects.filter(external_uuid=ext_uuid).first()
                if not obj:
                    skipped += 1
                    continue
                if obj.is_active:
                    obj.is_active = False
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

            phones = payload.get("phones") or []
            owner_phone = str(phones[0].get("number")) if phones else ""
            owner_name = phones[0].get("name") if phones else ""

            facilities = payload.get("facilities") or []
            has_parking = "covered_parking" in facilities or "parking" in facilities
            has_balcony = bool(payload.get("balcony"))
            has_renovation = bool(payload.get("repair"))

            photos = payload.get("_photos") or []
            photos = [p for p in photos if p]

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
                "external_uuid": ext_uuid,
                "external_id": payload.get("id"),
                "property_type": payload.get("type"),
                "deal_type": payload.get("category"),
                "condition": payload.get("condition"),
                "repair": payload.get("repair"),
                "construction_year": payload.get("construction_year"),
                "material": payload.get("material") or [],
                "address_note": payload.get("address_note"),
                "source_url": payload.get("source_url") or "",
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
                        obj.save(update_fields=["latitude", "longitude"])

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
            subtype = payload.get("subtype") or "коммерция"
            return f"{subtype} {area} м², {city}".strip()
        return f"{prop_type} {area} м², {city}".strip()

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
