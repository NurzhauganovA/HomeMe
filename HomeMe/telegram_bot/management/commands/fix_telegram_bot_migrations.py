"""
Помечает 0002_squashed_schema как применённую, если схема уже в БД (после деплоя без полного набора файлов).

  python manage.py fix_telegram_bot_migrations
  python manage.py fix_telegram_bot_migrations --dry-run
"""

from django.core.management.base import BaseCommand
from django.db import connection
from django.db.migrations.recorder import MigrationRecorder

SQUASH_NAME = "0002_squashed_schema"
INITIAL_NAME = "0001_initial"
MARKER_TABLE = "bi_complexes"


class Command(BaseCommand):
    help = "Пометить squashed-миграцию telegram_bot как применённую, если таблицы уже существуют."

    def add_arguments(self, parser):
        parser.add_argument(
            "--dry-run",
            action="store_true",
            help="Только показать, что будет сделано",
        )

    def handle(self, *args, **options):
        dry_run = options["dry_run"]
        recorder = MigrationRecorder(connection)
        applied = {m[1] for m in recorder.applied_migrations() if m[0] == "telegram_bot"}

        self.stdout.write(f"Сейчас применено telegram_bot: {sorted(applied) or '(нет)'}")

        if not self._table_exists(MARKER_TABLE):
            self.stderr.write(
                self.style.ERROR(
                    f"Таблица {MARKER_TABLE} не найдена — схема не похожа на готовую. "
                    "Запустите обычный migrate без --fake."
                )
            )
            return

        if SQUASH_NAME in applied:
            self.stdout.write(self.style.SUCCESS(f"{SQUASH_NAME} уже в django_migrations."))
            return

        stale = applied - {INITIAL_NAME, SQUASH_NAME}
        if stale:
            self.stdout.write(f"Будут удалены устаревшие записи: {sorted(stale)}")
            if not dry_run:
                with connection.cursor() as cursor:
                    for name in stale:
                        cursor.execute(
                            "DELETE FROM django_migrations WHERE app = %s AND name = %s",
                            ["telegram_bot", name],
                        )

        if INITIAL_NAME not in applied:
            self.stdout.write(f"Добавим {INITIAL_NAME}")
            if not dry_run:
                recorder.record_applied("telegram_bot", INITIAL_NAME)

        self.stdout.write(self.style.WARNING(f"Пометим {SQUASH_NAME} как применённую (--fake)"))
        if dry_run:
            return

        recorder.record_applied("telegram_bot", SQUASH_NAME)
        self.stdout.write(self.style.SUCCESS("Готово. Запустите: python manage.py migrate"))

    @staticmethod
    def _table_exists(table_name: str) -> bool:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT EXISTS (
                    SELECT 1 FROM information_schema.tables
                    WHERE table_schema = 'public' AND table_name = %s
                )
                """,
                [table_name],
            )
            return bool(cursor.fetchone()[0])
