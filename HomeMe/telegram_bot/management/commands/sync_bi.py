from django.core.management.base import BaseCommand
from core.services.bi_syncer import BISyncService
import time
import logging


logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Запуск полной синхронизации с BI Group API (ЖК + коммерция)'

    def add_arguments(self, parser):
        parser.add_argument(
            '--loop',
            action='store_true',
            help='Запускать синхронизацию в бесконечном цикле с интервалом (по умолчанию 10 мин).',
        )
        parser.add_argument(
            '--interval',
            type=int,
            default=600,
            help='Интервал в секундах между синхронизациями (по умолчанию 600 = 10 минут).',
        )

    def handle(self, *args, **options):
        loop = options.get('loop', False)
        interval = int(options.get('interval') or 600)

        # Одна синхронизация (старое поведение)
        if not loop:
            self._run_single_sync()
            return

        self.stdout.write(self.style.WARNING(
            f"🔁 Запускаю непрерывную синхронизацию каждые {interval} сек "
            f"(пауза считается после завершения предыдущей синхронизации)."
        ))

        syncer = BISyncService()

        try:
            while True:
                self.stdout.write("⏳ Начинаю синхронизацию...")
                start_time = time.time()

                syncer.run_full_sync()

                duration = time.time() - start_time
                self.stdout.write(self.style.SUCCESS(f"✅ Готово! Заняло {duration:.1f} сек."))
                logger.info(f"BI sync finished in {duration:.1f}s, sleeping for {interval}s")

                # Спим ПОСЛЕ завершения, как просили: T0 -> sync -> sleep(interval) -> следующая sync
                time.sleep(interval)
        except KeyboardInterrupt:
            self.stdout.write(self.style.WARNING("⏹ Остановлено пользователем (Ctrl+C)."))

    def _run_single_sync(self):
        """Одиночная синхронизация (режим по умолчанию, как раньше)."""
        self.stdout.write("⏳ Начинаю синхронизацию...")
        start_time = time.time()

        syncer = BISyncService()
        syncer.run_full_sync()

        duration = time.time() - start_time
        self.stdout.write(self.style.SUCCESS(f"✅ Готово! Заняло {duration:.1f} сек."))