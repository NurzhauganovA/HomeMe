from django.core.management.base import BaseCommand
from core.services.bi_syncer import BISyncService
import time


class Command(BaseCommand):
    help = 'Запуск полной синхронизации с BI Group API (ЖК + коммерция)'

    def handle(self, *args, **options):
        self.stdout.write("⏳ Начинаю синхронизацию...")
        start_time = time.time()

        syncer = BISyncService()
        syncer.run_full_sync()

        duration = time.time() - start_time
        self.stdout.write(self.style.SUCCESS(f"✅ Готово! Заняло {duration:.1f} сек."))