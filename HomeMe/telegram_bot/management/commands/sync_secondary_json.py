import json
from django.core.management.base import BaseCommand

from core.services.secondary_importer import SecondaryImporter


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

        with open(file_path, "r", encoding="utf-8") as f:
            items = json.load(f)

        if limit:
            items = items[:limit]

        importer = SecondaryImporter(do_geocode=do_geocode, do_embed=do_embed)
        stats = importer.import_items(items)

        self.stdout.write(self.style.SUCCESS(
            f"✅ Import done. Created: {stats['created']}, Updated: {stats['updated']}, Skipped: {stats['skipped']}"
        ))
