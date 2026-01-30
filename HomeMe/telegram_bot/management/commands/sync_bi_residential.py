from django.core.management.base import BaseCommand
from core.services.bi_syncer import BISyncService
import time


class Command(BaseCommand):
    help = 'Синхронизация ЖК и квартир с BI Group API'

    def handle(self, *args, **options):
        self.stdout.write("⏳ Начинаю синхронизацию ЖК и квартир...")
        start_time = time.time()

        syncer = BISyncService()
        stats = syncer.run_residential_sync()

        duration = time.time() - start_time
        self.stdout.write(self.style.SUCCESS(
            f"✅ Готово! Synced {stats['synced']}, AI skipped {stats['ai_skipped']}. "
            f"Заняло {duration:.1f} сек."
        ))
