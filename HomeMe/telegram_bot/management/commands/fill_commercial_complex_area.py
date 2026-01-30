from django.core.management.base import BaseCommand
from django.db.models import Min, Max

from telegram_bot.models import BICommercialComplex, BICommercialUnit


class Command(BaseCommand):
    help = "Заполняет min_area/max_area у BICommercialComplex из BICommercialUnit"

    def handle(self, *args, **options):
        stats = BICommercialUnit.objects.values('complex_id').annotate(
            min_area=Min('area'),
            max_area=Max('area'),
        )

        updated = 0
        skipped = 0
        for row in stats:
            complex_id = row['complex_id']
            if not complex_id:
                skipped += 1
                continue

            BICommercialComplex.objects.filter(id=complex_id).update(
                min_area=row['min_area'],
                max_area=row['max_area'],
            )
            updated += 1

        self.stdout.write(self.style.SUCCESS(
            f"✅ Готово. Обновлено: {updated}, пропущено: {skipped}"
        ))
