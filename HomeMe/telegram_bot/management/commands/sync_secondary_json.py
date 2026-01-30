import json
import time
from decimal import Decimal, InvalidOperation
from django.core.management.base import BaseCommand

from telegram_bot.models import SecondaryProperty
from core.location_resolver import DynamicLocationResolver
from core.services.ai_service import EnhancedAIService


class Command(BaseCommand):
    help = 'Импорт вторички из JSON (create.json)'

    def add_arguments(self, parser):
        parser.add_argument(
            "file_path",
            type=str,
            help="Путь к JSON файлу (create.json)"
        )
        parser.add_argument(
            "--limit",
            type=int,
            default=0,
            help="Лимит записей (0 = без лимита)"
        )
        parser.add_argument(
            "--no-geocode",
            action="store_true",
            help="Не запрашивать координаты по адресу"
        )
        parser.add_argument(
            "--no-embed",
            action="store_true",
            help="Не генерировать embedding"
        )

    def handle(self, *args, **options):
        file_path = options["file_path"]
        limit = options["limit"]
        do_geocode = not options["no_geocode"]
        do_embed = not options["no_embed"]

        ai_service = EnhancedAIService() if (do_geocode or do_embed) else None
        location_resolver = DynamicLocationResolver(ai_service) if do_geocode else None
        geo_cache = {}

        with open(file_path, "r", encoding="utf-8") as f:
            items = json.load(f)

        created = 0
        updated = 0
        skipped = 0

        for idx, item in enumerate(items, start=1):
            if limit and idx > limit:
                break

            payload = (item or {}).get("data", {}).get("data", {})
            if not payload:
                skipped += 1
                continue

            ext_uuid = payload.get("uuid")
            if not ext_uuid:
                skipped += 1
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
            }

            obj, was_created = SecondaryProperty.objects.update_or_create(
                external_uuid=ext_uuid,
                defaults=defaults
            )

            # # Геокодирование по адресу (если нет координат)
            # if do_geocode and (obj.latitude is None or obj.longitude is None):
            #     if address:
            #         if address in geo_cache:
            #             coords = geo_cache[address]
            #         else:
            #             coords = self._resolve_coordinates(location_resolver, address, obj.city)
            #             geo_cache[address] = coords
            #
            #         if coords:
            #             obj.latitude = coords[0]
            #             obj.longitude = coords[1]
            #             obj.save(update_fields=["latitude", "longitude"])
            #
            # # Эмбеддинг (если отсутствует)
            # if do_embed and obj.embedding is None:
            #     text = obj.get_full_text()
            #     embedding = ai_service.get_embedding(text) if ai_service else None
            #     if embedding:
            #         obj.embedding = embedding
            #         obj.save(update_fields=["embedding"])

            if was_created:
                created += 1
            else:
                updated += 1

        self.stdout.write(self.style.SUCCESS(
            f"✅ Import done. Created: {created}, Updated: {updated}, Skipped: {skipped}"
        ))

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

    @staticmethod
    def _resolve_coordinates(location_resolver, address: str, city_hint: str = None):
        if not location_resolver:
            return None
        try:
            location_data = location_resolver.resolve_any_location(address, city_hint=city_hint or "Astana")
            center = location_data.get("center_coordinates") if location_data else None
            if center and len(center) >= 2:
                return center[0], center[1]
        except Exception:
            return None
        return None
