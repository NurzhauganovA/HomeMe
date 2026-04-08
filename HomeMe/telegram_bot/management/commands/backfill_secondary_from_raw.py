from django.core.management.base import BaseCommand

from telegram_bot.models import SecondaryProperty


class Command(BaseCommand):
    help = "Backfill SecondaryProperty fields from raw_data."

    def add_arguments(self, parser):
        parser.add_argument("--overwrite", action="store_true", help="Overwrite existing non-empty values.")
        parser.add_argument("--limit", type=int, default=0, help="Limit processed rows (0 = all).")

    def handle(self, *args, **options):
        overwrite = options["overwrite"]
        limit = options["limit"] or None

        qs = SecondaryProperty.objects.exclude(raw_data={}).order_by("created_at")
        if limit:
            qs = qs[:limit]

        updated = 0
        skipped = 0

        for obj in qs:
            payload = obj.raw_data or {}
            if not isinstance(payload, dict):
                skipped += 1
                continue

            updates = self._build_updates(obj, payload, overwrite=overwrite)
            if not updates:
                skipped += 1
                continue

            for field_name, value in updates.items():
                setattr(obj, field_name, value)
            obj.save(update_fields=list(updates.keys()))
            updated += 1

        self.stdout.write(
            self.style.SUCCESS(
                f"Backfill completed: updated={updated}, skipped={skipped}, overwrite={int(overwrite)}"
            )
        )

    def _build_updates(self, obj: SecondaryProperty, payload: dict, overwrite: bool) -> dict:
        updates = {}

        def put(field_name, value):
            if value is None:
                return
            current = getattr(obj, field_name)
            empty_now = current in (None, "", [], {})
            if overwrite or empty_now:
                updates[field_name] = value

        put("subtype", payload.get("subtype"))
        put("rent_type", payload.get("rent_type"))
        put("currency", payload.get("currency"))
        put("ceiling_height", self._to_float(payload.get("ceiling_height")))
        put("rooms_total", self._to_int(payload.get("rooms_total")))
        put("area_living", self._to_float(payload.get("area_living")))
        put("area_kitchen", self._to_float(payload.get("area_kitchen")))
        put("city_micro_district", payload.get("city_micro_district"))
        put("source_url", payload.get("source_url") or payload.get("external_link"))

        prices = payload.get("prices")
        if isinstance(prices, dict) and (overwrite or not obj.prices):
            updates["prices"] = prices

        prices_m2 = payload.get("prices_m2")
        if isinstance(prices_m2, dict) and (overwrite or not obj.prices_m2):
            updates["prices_m2"] = prices_m2

        photos = payload.get("photos")
        if photos is None:
            photos = payload.get("_photos")
        if isinstance(photos, list):
            photos = [p for p in photos if isinstance(p, str) and p.strip()]
            if photos and (overwrite or not obj.photos):
                updates["photos"] = photos

        owner_phone, owner_name = self._extract_contact(payload)
        if owner_phone and (overwrite or obj.owner_phone in ("", "-", None)):
            updates["owner_phone"] = owner_phone
        if owner_name and (overwrite or obj.owner_name in ("", "Не указано", None)):
            updates["owner_name"] = owner_name

        lat = self._to_float(payload.get("latitude"))
        lon = self._to_float(payload.get("longitude"))
        if lat is not None and lon is not None:
            if overwrite or obj.latitude is None or obj.longitude is None:
                updates["latitude"] = lat
                updates["longitude"] = lon
                updates["coordinates_source"] = "payload"

        return updates

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

    @staticmethod
    def _extract_contact(payload):
        owner_phone = ""
        owner_name = ""

        phones = payload.get("phones")
        if isinstance(phones, list) and phones:
            first = phones[0]
            if isinstance(first, dict):
                owner_phone = str(first.get("number") or "").strip()
                owner_name = str(first.get("name") or "").strip()
            elif isinstance(first, str):
                owner_phone = first.strip()

        responsible = payload.get("responsible")
        if isinstance(responsible, dict):
            if not owner_name:
                first_name = str(responsible.get("first_name") or "").strip()
                last_name = str(responsible.get("last_name") or "").strip()
                owner_name = " ".join([p for p in [first_name, last_name] if p]).strip()

            if not owner_phone:
                resp_phones = responsible.get("phones")
                if isinstance(resp_phones, list) and resp_phones:
                    first_phone = resp_phones[0]
                    if isinstance(first_phone, str):
                        owner_phone = first_phone.strip()
                    elif isinstance(first_phone, dict):
                        owner_phone = str(first_phone.get("number") or "").strip()

        if owner_phone:
            owner_phone = owner_phone.replace(" ", "")[:20]
        if owner_name:
            owner_name = owner_name[:100]

        return owner_phone, owner_name
