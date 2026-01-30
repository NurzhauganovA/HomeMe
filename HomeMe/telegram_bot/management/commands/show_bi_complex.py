import json
import uuid
from decimal import Decimal

from django.core.management.base import BaseCommand, CommandError

from telegram_bot.models import (
    BIComplex,
    BIUnit,
    BICommercialComplex,
    BICommercialUnit,
)


class Command(BaseCommand):
    help = "Показывает данные комплекса и всех его юнитов по ID"

    def add_arguments(self, parser):
        parser.add_argument(
            "complex_id",
            type=str,
            help="UUID комплекса (pk из БД)",
        )
        parser.add_argument(
            "--type",
            dest="complex_type",
            choices=["residential", "commercial"],
            default="commercial",
            help="Тип комплекса: residential или commercial (по умолчанию commercial)",
        )

    def handle(self, *args, **options):
        complex_id = options["complex_id"]
        complex_type = options["complex_type"]

        if complex_type == "residential":
            complex_model = BIComplex
            unit_model = BIUnit
        else:
            complex_model = BICommercialComplex
            unit_model = BICommercialUnit

        complex_data = complex_model.objects.filter(id=complex_id).values().first()
        if not complex_data:
            raise CommandError(f"Комплекс не найден: {complex_id}")

        units_data = list(
            unit_model.objects.filter(complex_id=complex_id).values()
        )

        payload = self._normalize_payload({
            "complex_type": complex_type,
            "complex": complex_data,
            "units": units_data,
            "units_count": len(units_data),
        })

        self.stdout.write(json.dumps(payload, ensure_ascii=False, indent=2))

    @staticmethod
    def _normalize_payload(payload):
        def normalize_value(value):
            if hasattr(value, "tolist"):
                return value.tolist()
            if isinstance(value, uuid.UUID):
                return str(value)
            if isinstance(value, Decimal):
                return float(value)
            if hasattr(value, "isoformat"):
                return value.isoformat()
            if isinstance(value, dict):
                return {k: normalize_value(v) for k, v in value.items()}
            if isinstance(value, list):
                return [normalize_value(v) for v in value]
            return value

        return normalize_value(payload)
