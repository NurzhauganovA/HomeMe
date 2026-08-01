"""
Назначает роль «Базовый» пользователям бота без роли.
"""
from django.core.management.base import BaseCommand

from core.services.referral_service import DEFAULT_ROLE_NAME, ensure_default_role
from dashboard.models import Role
from telegram_bot.models import BotUser


class Command(BaseCommand):
    help = 'Назначает роль «Базовый» всем пользователям бота без роли'

    def add_arguments(self, parser):
        parser.add_argument(
            '--dry-run',
            action='store_true',
            help='Только показать количество, без изменений',
        )

    def handle(self, *args, **options):
        role = Role.objects.filter(name=DEFAULT_ROLE_NAME, is_active=True).first()
        if not role:
            self.stderr.write(self.style.ERROR(f'Роль «{DEFAULT_ROLE_NAME}» не найдена. Запустите init_permissions.sql'))
            return

        qs = BotUser.objects.filter(role__isnull=True)
        count = qs.count()
        if options['dry_run']:
            self.stdout.write(f'Будет обновлено пользователей: {count}')
            return

        updated = 0
        for user in qs.iterator():
            if ensure_default_role(user):
                updated += 1

        self.stdout.write(self.style.SUCCESS(f'Назначена роль «{DEFAULT_ROLE_NAME}»: {updated} из {count}'))
