import secrets
from datetime import timedelta

from django.core.management.base import BaseCommand
from django.utils import timezone

from dashboard.models import ApiAccessToken


class Command(BaseCommand):
    help = 'Создает API токен для импорта вторички'

    def add_arguments(self, parser):
        parser.add_argument('--name', type=str, default='Secondary Client', help='Название клиента')
        parser.add_argument('--days', type=int, default=365, help='Срок действия токена (в днях)')

    def handle(self, *args, **options):
        name = options['name']
        days = options['days']
        token = secrets.token_urlsafe(32)
        expires_at = timezone.now() + timedelta(days=days)

        ApiAccessToken.objects.create(
            name=name,
            token=token,
            expires_at=expires_at,
            is_active=True
        )

        self.stdout.write(self.style.SUCCESS(
            f"✅ Token created: {token}\nExpires at: {expires_at.isoformat()}"
        ))
