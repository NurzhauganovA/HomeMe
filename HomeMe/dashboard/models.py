from django.db import models
from django.utils import timezone
import uuid


class ApiAccessToken(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100)
    token = models.CharField(max_length=255, unique=True, db_index=True)
    is_active = models.BooleanField(default=True)
    expires_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "API токен"
        verbose_name_plural = "API токены"
        ordering = ['-created_at']

    def is_valid(self) -> bool:
        return self.is_active and self.expires_at > timezone.now()


class Permission(models.Model):
    """Разрешения системы - хранятся в БД и назначаются ролям."""

    CATEGORY_CHOICES = [
        ('properties', 'Объекты недвижимости'),
        ('market', 'Тип рынка'),
        ('bot', 'Функции бота'),
        ('contacts', 'Контакты'),
        ('data', 'Данные и аналитика'),
    ]

    codename = models.CharField("Кодовое имя", max_length=100, unique=True)
    name = models.CharField("Название", max_length=200)
    description = models.TextField("Описание", blank=True)
    category = models.CharField(
        "Категория", max_length=50, choices=CATEGORY_CHOICES, default='bot', db_index=True
    )

    class Meta:
        verbose_name = "Разрешение"
        verbose_name_plural = "Разрешения"
        ordering = ['category', 'name']

    def __str__(self):
        return f"{self.name} ({self.codename})"

    def get_category_display_label(self):
        return dict(self.CATEGORY_CHOICES).get(self.category, self.category)


class Role(models.Model):
    """Роль пользователя бота — набор разрешений + лимиты выдачи объектов."""

    name = models.CharField("Название роли", max_length=100, unique=True)
    description = models.TextField("Описание", blank=True)
    permissions = models.ManyToManyField(
        Permission,
        blank=True,
        verbose_name="Разрешения",
        related_name='roles'
    )

    # Лимиты выдачи объектов в сутки
    limit_apartments_daily = models.IntegerField(
        "Лимит квартир/сутки", default=10,
        help_text="Максимальное количество квартир, выдаваемых боту в сутки"
    )
    limit_commercial_daily = models.IntegerField(
        "Лимит коммерческой недвижимости/сутки", default=10,
        help_text="Максимальное количество коммерческих объектов в сутки"
    )
    limit_primary_daily = models.IntegerField(
        "Лимит первичного рынка/сутки", default=10,
        help_text="Максимальное количество объектов первичного рынка в сутки"
    )
    limit_secondary_daily = models.IntegerField(
        "Лимит вторичного рынка/сутки", default=10,
        help_text="Максимальное количество объектов вторичного рынка в сутки"
    )
    limit_total_daily = models.IntegerField(
        "Общий лимит объектов/сутки", default=20,
        help_text="Общий суточный лимит выдачи всех объектов"
    )

    is_active = models.BooleanField("Активна", default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Роль"
        verbose_name_plural = "Роли"
        ordering = ['name']

    def __str__(self):
        return self.name

    def get_users_count(self):
        return self.bot_users.count()
