"""
Enhanced Database Models
Профессиональные модели Django с оптимизацией, индексами и валидацией.
"""

from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
from pgvector.django import VectorField
import uuid


class BotUser(models.Model):
    """
    Унифицированный пользователь для всех платформ (Telegram, WhatsApp).
    Хранит базовую информацию и настройки.
    """

    PLATFORM_CHOICES = [
        ('whatsapp', 'WhatsApp'),
        ('telegram', 'Telegram'),
    ]

    # Основные поля
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    platform = models.CharField(max_length=20, choices=PLATFORM_CHOICES, db_index=True)
    user_id = models.CharField(
        max_length=50,
        unique=True,
        db_index=True,
        help_text="Phone for WhatsApp, ID for Telegram"
    )
    name = models.CharField(max_length=100, null=True, blank=True)

    # Метаданные
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)
    last_active_at = models.DateTimeField(auto_now=True)

    # Статистика
    total_searches = models.IntegerField(default=0)
    total_messages = models.IntegerField(default=0)

    # Telegram username (без @)
    username = models.CharField(
        "Username",
        max_length=100,
        null=True,
        blank=True,
        db_index=True,
        help_text="Telegram @username без символа @"
    )

    # Роль пользователя (система доступа)
    role = models.ForeignKey(
        'dashboard.Role',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='bot_users',
        verbose_name="Роль"
    )

    # Реферальная система (ТЗ п.10)
    referral_code = models.CharField(
        "Реферальный код",
        max_length=32,
        unique=True,
        null=True,
        blank=True,
        db_index=True,
        help_text="Уникальный код для ссылки t.me/bot?start=ref_CODE",
    )
    invited_by = models.ForeignKey(
        "self",
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="referrals",
        verbose_name="Пригласивший",
    )
    referral_link = models.ForeignKey(
        'dashboard.ReferralLink',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name='registered_users',
        verbose_name="Реферальная ссылка (кампания)",
    )

    # Настройки
    is_active = models.BooleanField(default=True)
    language = models.CharField(
        max_length=5,
        default='ru',
        choices=[('ru', 'Русский'), ('kk', 'Қазақ'), ('en', 'English')]
    )

    class Meta:
        verbose_name = "Пользователь бота"
        verbose_name_plural = "Пользователи бота"
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['platform', 'user_id']),
            models.Index(fields=['created_at']),
            models.Index(fields=['last_active_at']),
        ]

    def __str__(self):
        return f"{self.name or 'Anonymous'} ({self.platform})"

    def increment_searches(self):
        """Увеличивает счетчик поисков"""
        self.total_searches += 1
        self.save(update_fields=['total_searches'])

    def increment_messages(self):
        """Увеличивает счетчик сообщений"""
        self.total_messages += 1
        self.last_active_at = timezone.now()
        self.save(update_fields=['total_messages', 'last_active_at'])


class UserSession(models.Model):
    """
    Сессия пользователя - хранит контекст диалога и параметры поиска.
    """

    user = models.OneToOneField(
        BotUser,
        on_delete=models.CASCADE,
        related_name='session'
    )

    # Текущее состояние диалога
    current_intent = models.CharField(
        max_length=50,
        default='greeting',
        help_text="Текущее намерение: greeting, search_objects, consult_location и т.д."
    )

    # Параметры поиска (JSON)
    search_params = models.JSONField(
        default=dict,
        blank=True,
        help_text="Накопленные параметры поиска: rooms, price, city, district и т.д."
    )

    # История диалога (последние 10 сообщений)
    conversation_history = models.JSONField(
        default=list,
        blank=True,
        help_text="История сообщений для контекста"
    )

    # Метаданные
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    expires_at = models.DateTimeField(
        null=True,
        blank=True,
        help_text="Время истечения сессии (опционально)"
    )
    state = models.CharField(max_length=50, default='START')

    class Meta:
        verbose_name = "Сессия пользователя"
        verbose_name_plural = "Сессии пользователей"

    def __str__(self):
        return f"Session of {self.user.name} ({self.current_intent})"

    def add_message_to_history(self, role: str, content: str):
        """Добавляет сообщение в историю (максимум 10)"""
        if not isinstance(self.conversation_history, list):
            self.conversation_history = []

        self.conversation_history.append({
            "role": role,
            "content": content,
            "timestamp": timezone.now().isoformat()
        })

        # Оставляем только последние 10
        if len(self.conversation_history) > 10:
            self.conversation_history = self.conversation_history[-10:]

        self.save(update_fields=['conversation_history', 'updated_at'])

    def clear_search_params(self):
        """Очищает параметры поиска"""
        self.search_params = {}
        self.save(update_fields=['search_params', 'updated_at'])

    def update_search_params(self, **kwargs):
        """Обновляет параметры поиска"""
        if not isinstance(self.search_params, dict):
            self.search_params = {}

        self.search_params.update(kwargs)
        self.save(update_fields=['search_params', 'updated_at'])


class Lead(models.Model):
    """
    Лид - запрос на связь с экспертом.
    """

    STATUS_CHOICES = [
        ('new', 'Новый'),
        ('in_progress', 'В работе'),
        ('contacted', 'Связались'),
        ('closed', 'Закрыт'),
        ('cancelled', 'Отменен'),
    ]

    # Связь с пользователем
    user = models.ForeignKey(BotUser, on_delete=models.CASCADE, related_name='leads')

    # Данные лида
    request_text = models.TextField(
        verbose_name="Текст запроса",
        help_text="Что хочет пользователь"
    )

    search_params = models.JSONField(
        default=dict,
        blank=True,
        help_text="Параметры поиска на момент создания лида"
    )

    # Статус
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='new',
        db_index=True
    )

    # Назначение
    assigned_to = models.CharField(
        max_length=100,
        null=True,
        blank=True,
        help_text="Имя менеджера"
    )

    # Комментарии менеджера
    manager_notes = models.TextField(blank=True, default="")

    # Метаданные
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)
    contacted_at = models.DateTimeField(null=True, blank=True)
    closed_at = models.DateTimeField(null=True, blank=True)

    # Приоритет
    priority = models.IntegerField(
        default=0,
        validators=[MinValueValidator(0), MaxValueValidator(5)],
        help_text="0 = обычный, 5 = срочный"
    )

    # Журнал для аналитики лидов (ТЗ п.6.1) — денормализация для отчётов
    lead_source = models.CharField(
        "Источник лида",
        max_length=40,
        blank=True,
        db_index=True,
        help_text="expert_request, bi_primary_contact и т.п.",
    )
    developer = models.CharField("Застройщик", max_length=120, blank=True)
    residential_complex = models.CharField("ЖК / объект", max_length=255, blank=True)
    district = models.CharField("Район", max_length=120, blank=True)
    property_type_label = models.CharField("Тип недвижимости", max_length=80, blank=True)
    market_type_label = models.CharField("Тип рынка", max_length=80, blank=True)
    budget_display = models.CharField("Бюджет (текст)", max_length=160, blank=True)

    class Meta:
        verbose_name = "Лид"
        verbose_name_plural = "Лиды"
        ordering = ['-priority', '-created_at']
        indexes = [
            models.Index(fields=['status', '-created_at']),
            models.Index(fields=['-priority', '-created_at']),
        ]

    def __str__(self):
        return f"Lead #{self.id} from {self.user.name} ({self.status})"

    def mark_as_contacted(self, manager_name: str = None):
        """Отмечает лид как обработанный"""
        self.status = 'contacted'
        self.contacted_at = timezone.now()
        if manager_name:
            self.assigned_to = manager_name
        self.save()

    def close(self, notes: str = ""):
        """Закрывает лид"""
        self.status = 'closed'
        self.closed_at = timezone.now()
        if notes:
            self.manager_notes = notes
        self.save()


class SecondaryProperty(models.Model):
    """
    Объект вторичной недвижимости с поддержкой векторного поиска.
    """

    # Основная информация
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    external_uuid = models.CharField("Внешний UUID", max_length=100, unique=True, null=True, blank=True, db_index=True)
    external_id = models.BigIntegerField("Внешний ID", null=True, blank=True, db_index=True)
    property_type = models.CharField("Тип объекта", max_length=50, null=True, blank=True, db_index=True)
    subtype = models.CharField("Подтип объекта", max_length=100, null=True, blank=True)
    deal_type = models.CharField("Тип сделки", max_length=50, null=True, blank=True, db_index=True)
    rent_type = models.CharField("Тип аренды", max_length=50, null=True, blank=True)
    currency = models.CharField("Валюта", max_length=10, null=True, blank=True)
    condition = models.CharField("Состояние", max_length=50, null=True, blank=True)
    repair = models.CharField("Ремонт", max_length=50, null=True, blank=True)
    construction_year = models.IntegerField("Год постройки", null=True, blank=True)
    ceiling_height = models.FloatField("Высота потолка", null=True, blank=True)
    rooms_total = models.IntegerField("Всего комнат (источник)", null=True, blank=True)
    area_living = models.FloatField("Жилая площадь", null=True, blank=True)
    area_kitchen = models.FloatField("Площадь кухни", null=True, blank=True)
    material = models.JSONField("Материал", default=list, blank=True)
    prices = models.JSONField("Цены по валютам", default=dict, blank=True)
    prices_m2 = models.JSONField("Цена за м² по валютам", default=dict, blank=True)
    address_note = models.CharField("Адрес (текст)", max_length=500, null=True, blank=True)
    city_micro_district = models.CharField("Микрорайон", max_length=100, null=True, blank=True)
    source_url = models.URLField("Источник", blank=True)
    photos = models.JSONField("Фотографии", default=list, blank=True)
    raw_data = models.JSONField("Raw данные", default=dict, blank=True)
    title = models.CharField("Заголовок", max_length=200, db_index=True)
    description = models.TextField(
        "Внутреннее описание",
        blank=True,
        help_text="Для сотрудников; в API ILVO уходит как description",
    )
    public_description = models.TextField(
        "Описание для рекламы",
        blank=True,
        help_text="Публичный текст для ILVO (public_description); может быть пустым",
    )
    address = models.CharField("Адрес", max_length=255, db_index=True)

    # Параметры
    price = models.DecimalField(
        "Цена (₸)",
        max_digits=12,
        decimal_places=0,
        validators=[MinValueValidator(0)]
    )
    rooms = models.IntegerField(
        "Количество комнат",
        validators=[MinValueValidator(0), MaxValueValidator(10)],
        db_index=True
    )
    area = models.FloatField(
        "Площадь (м²)",
        validators=[MinValueValidator(0)]
    )
    floor = models.IntegerField(
        "Этаж",
        validators=[MinValueValidator(0)]
    )
    total_floors = models.IntegerField(
        "Всего этажей",
        validators=[MinValueValidator(1)]
    )

    # Геолокация
    city = models.CharField(
        "Город",
        max_length=50,
        null=True,
        blank=True,
        db_index=True
    )
    district = models.CharField(
        "Район",
        max_length=100,
        null=True,
        blank=True,
        db_index=True
    )
    latitude = models.FloatField("Широта", null=True, blank=True)
    longitude = models.FloatField("Долгота", null=True, blank=True)
    coordinates_source = models.CharField("Источник координат", max_length=20, null=True, blank=True)

    # Контакты владельца (скрытые)
    owner_phone = models.CharField("Телефон владельца", max_length=20)
    owner_name = models.CharField("Имя владельца", max_length=100)

    # Дополнительные удобства
    has_parking = models.BooleanField("Парковка", default=False)
    has_balcony = models.BooleanField("Балкон", default=False)
    has_renovation = models.BooleanField("С ремонтом", default=False)

    # Медиа
    image = models.ImageField(
        "Фото",
        upload_to='properties/%Y/%m/',
        blank=True,
        null=True
    )

    # Статус
    is_active = models.BooleanField("Активно", default=True, db_index=True)
    is_verified = models.BooleanField("Проверено", default=False)

    # Метаданные
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)
    views_count = models.IntegerField("Просмотры", default=0)

    # Векторное представление (для AI поиска)
    embedding = VectorField(
        dimensions=768,
        null=True,
        blank=True,
        help_text="Векторное представление описания для семантического поиска"
    )

    class Meta:
        verbose_name = "Вторичная недвижимость"
        verbose_name_plural = "Вторичная недвижимость"
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['city', 'rooms', 'price']),
            models.Index(fields=['is_active', '-created_at']),
            models.Index(fields=['district', '-created_at']),
        ]

    def __str__(self):
        return f"{self.title} - {self.price:,.0f} ₸"

    @property
    def price_per_sqm(self) -> float:
        """Цена за квадратный метр"""
        if self.area > 0:
            return float(self.price) / self.area
        return 0.0

    def increment_views(self):
        """Увеличивает счетчик просмотров"""
        self.views_count += 1
        self.save(update_fields=['views_count'])

    def get_display_description(self) -> str:
        """Рекламное описание для бота; если пусто — внутреннее."""
        from core.services.ilvo_description import display_description

        return display_description(self.description, self.public_description)

    def get_public_description_for_ilvo(self) -> str:
        """Рекламное поле для выгрузки в API ILVO."""
        from core.services.ilvo_description import public_description_for_ilvo_export

        return public_description_for_ilvo_export(self.description, self.public_description)

    def get_full_text(self) -> str:
        """Возвращает полный текст для векторизации"""
        desc = self.get_display_description()
        return f"{self.title}. {desc}. Адрес: {self.address}. {self.city or ''}. {self.district or ''}"


class BotProductEvent(models.Model):
    """
    Продуктовая аналитика (ТЗ п.4) — события в боте.
    """

    EVENT_BOT_START = "bot_start"
    EVENT_SEARCH = "search"
    EVENT_SHOW_MORE = "show_more"
    EVENT_NO_RESULTS = "no_results"
    EVENT_OBJECT_CARD = "object_card"
    EVENT_FAVORITE_ADD = "favorite_add"
    EVENT_FAVORITE_REMOVE = "favorite_remove"
    EVENT_LEAD_BI_CONTACT = "lead_bi_contact"

    user = models.ForeignKey(
        BotUser,
        on_delete=models.CASCADE,
        related_name="product_events",
        verbose_name="Пользователь",
    )
    event_type = models.CharField("Тип события", max_length=40, db_index=True)
    payload = models.JSONField("Данные", default=dict, blank=True)
    property_type = models.CharField(
        "Тип недвижимости",
        max_length=32,
        blank=True,
        db_index=True,
        help_text="apartments / commercial / mixed",
    )
    market_type = models.CharField(
        "Тип рынка",
        max_length=32,
        blank=True,
        db_index=True,
        help_text="primary / secondary / mixed",
    )
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "Событие аналитики"
        verbose_name_plural = "События аналитики"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["event_type", "-created_at"]),
            models.Index(fields=["user", "-created_at"]),
        ]

    def __str__(self):
        return f"{self.event_type} @ {self.created_at:%Y-%m-%d %H:%M}"


class SearchLog(models.Model):
    """
    Лог поисковых запросов для аналитики и улучшения AI.
    """

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        BotUser,
        on_delete=models.SET_NULL,
        null=True,
        related_name='search_logs'
    )

    # Запрос пользователя
    query_text = models.TextField("Текст запроса")

    # AI анализ
    detected_intent = models.CharField("Обнаруженное намерение", max_length=50)
    detected_city = models.CharField("Город", max_length=50, null=True, blank=True)
    detected_district = models.CharField("Район", max_length=100, null=True, blank=True)
    lifestyle_tags = models.JSONField("Lifestyle теги", default=list)
    ai_confidence = models.FloatField("Уверенность AI", default=0.0)

    # Результаты
    results_count = models.IntegerField("Количество результатов", default=0)
    bi_group_count = models.IntegerField("BI Group", default=0)
    secondary_count = models.IntegerField("Вторичка", default=0)

    # Производительность
    search_duration_ms = models.IntegerField("Время поиска (мс)", default=0)

    # Метаданные
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "Лог поиска"
        verbose_name_plural = "Логи поиска"
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['-created_at']),
            models.Index(fields=['detected_city', '-created_at']),
        ]

    def __str__(self):
        return f"Search: {self.query_text[:50]} ({self.results_count} results)"


class UserFeedback(models.Model):
    """
    Обратная связь от пользователей.
    """

    FEEDBACK_TYPE_CHOICES = [
        ('property', 'По объекту'),
        ('bot', 'По работе бота'),
        ('search', 'По поиску'),
        ('other', 'Другое'),
    ]

    user = models.ForeignKey(
        BotUser,
        on_delete=models.CASCADE,
        related_name='feedbacks'
    )

    feedback_type = models.CharField(
        "Тип",
        max_length=20,
        choices=FEEDBACK_TYPE_CHOICES
    )

    rating = models.IntegerField(
        "Оценка",
        validators=[MinValueValidator(1), MaxValueValidator(5)],
        null=True,
        blank=True
    )

    comment = models.TextField("Комментарий", blank=True)

    # Связь с объектом (если отзыв по объекту)
    property_id = models.CharField(
        "ID объекта",
        max_length=100,
        null=True,
        blank=True
    )

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Отзыв"
        verbose_name_plural = "Отзывы"
        ordering = ['-created_at']

    def __str__(self):
        return f"Feedback from {self.user.name}: {self.rating}⭐"


class FavoriteProperty(models.Model):
    """
    Избранные объекты пользователя (снимок карточки).
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(BotUser, on_delete=models.CASCADE, related_name='favorites')
    source = models.CharField(max_length=20, db_index=True)
    object_kind = models.CharField(max_length=20, db_index=True)
    object_id = models.CharField(max_length=100, db_index=True)
    data = models.JSONField(default=dict)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "Избранный объект"
        verbose_name_plural = "Избранные объекты"
        indexes = [
            models.Index(fields=['user', 'source']),
            models.Index(fields=['object_kind', 'object_id']),
        ]
        constraints = [
            models.UniqueConstraint(fields=['user', 'object_kind', 'object_id'], name='unique_favorite_object'),
        ]

    def __str__(self):
        return f"Favorite {self.object_kind}:{self.object_id} ({self.user.name})"


class BaseBIComplex(models.Model):
    """Базовый класс для ЖК и БЦ"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID из API", max_length=100, unique=True, db_index=True)

    name = models.CharField("Название", max_length=255)
    address = models.CharField("Адрес", max_length=500, blank=True)
    description = models.TextField(blank=True)

    latitude = models.FloatField("Широта", null=True, blank=True)
    longitude = models.FloatField("Долгота", null=True, blank=True)
    city_uuid = models.CharField("UUID Города", max_length=100, db_index=True)

    class_name = models.CharField("Класс", max_length=100, blank=True)
    deadline = models.CharField("Срок сдачи", max_length=50, blank=True)
    min_price = models.DecimalField("Цена от", max_digits=15, decimal_places=2, null=True)
    min_area = models.FloatField("Площадь от", null=True, blank=True)
    max_area = models.FloatField("Площадь до", null=True, blank=True)

    url = models.URLField(blank=True)
    image_url = models.URLField("Фото", blank=True)

    features = models.JSONField("AI Теги", default=dict)
    embedding = VectorField(dimensions=768, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True  # Таблица не создается, только для наследования

    def __str__(self):
        return self.name


class BaseBIUnit(models.Model):
    """Базовый класс для Квартир и Офисов"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID Юнита", max_length=100, unique=True, db_index=True)

    room_count = models.IntegerField("Комнат/Помещений", db_index=True)
    floor = models.IntegerField("Этаж")
    max_floor = models.IntegerField("Всего этажей", null=True)
    area = models.FloatField("Площадь")

    price = models.DecimalField("Базовая цена", max_digits=15, decimal_places=2)
    price_discount = models.DecimalField("Цена со скидкой", max_digits=15, decimal_places=2, null=True)

    block_name = models.CharField("Блок/Секция", max_length=100, blank=True)
    deadline = models.CharField("Срок сдачи секции", max_length=50, blank=True)
    is_active = models.BooleanField(default=True)
    photos = models.JSONField("Фотографии", default=list, blank=True)

    class Meta:
        abstract = True
        indexes = [
            models.Index(fields=['price_discount', 'room_count']),
            models.Index(fields=['area']),
        ]

    @property
    def current_price(self):
        return self.price_discount if self.price_discount else self.price


# --- Реальные модели (создадут таблицы) ---

class BIComplex(BaseBIComplex):
    """Жилые Комплексы"""

    def get_text_for_embedding(self):
        # Акцент на жизнь, комфорт, детей
        return f"ЖК {self.name}. Класс: {self.class_name}. Адрес: {self.address}. Описание: {self.description[:200]}. Теги: {', '.join(self.features.keys())}"

    class Meta:
        verbose_name = "ЖК (Жилой)"
        verbose_name_plural = "ЖК (Жилые)"
        db_table = 'bi_complexes'


class BIUnit(BaseBIUnit):
    """Квартиры"""
    complex = models.ForeignKey(BIComplex, on_delete=models.CASCADE, related_name='units')

    class Meta(BaseBIUnit.Meta):
        verbose_name = "Квартира"
        verbose_name_plural = "Квартиры"
        db_table = 'bi_units'


class BICommercialComplex(BaseBIComplex):
    """Бизнес Центры и Коммерция"""

    def get_text_for_embedding(self):
        # Акцент на бизнес, проходимость, этажность
        return f"Коммерческий объект {self.name}. Класс: {self.class_name}. Адрес: {self.address}. Описание: {self.description[:200]}. Подходит для бизнеса. Теги: {', '.join(self.features.keys())}"

    class Meta:
        verbose_name = "Коммерческий объект"
        verbose_name_plural = "Коммерческие объекты"
        db_table = 'bi_commercial_complexes'


class BICommercialUnit(BaseBIUnit):
    """Офисы и помещения"""
    complex = models.ForeignKey(BICommercialComplex, on_delete=models.CASCADE, related_name='units')

    class Meta(BaseBIUnit.Meta):
        verbose_name = "Офис/Помещение"
        verbose_name_plural = "Офисы/Помещения"
        db_table = 'bi_commercial_units'


class DailyUsageLog(models.Model):
    """
    Суточный счётчик показанных объектов для каждого пользователя.
    Используется для применения лимитов роли.
    """
    user = models.ForeignKey(
        BotUser,
        on_delete=models.CASCADE,
        related_name='daily_usage',
        verbose_name="Пользователь"
    )
    date = models.DateField("Дата", db_index=True)

    # Общий счётчик (главный)
    objects_shown = models.IntegerField("Объектов показано (итого)", default=0)
    bonus_limit_daily = models.IntegerField("Бонус к суточному лимиту", default=0)

    # Счётчики по категориям
    apartments_shown = models.IntegerField("Квартир показано", default=0)
    commercial_shown = models.IntegerField("Коммерческих показано", default=0)
    primary_shown = models.IntegerField("Первичного рынка показано", default=0)
    secondary_shown = models.IntegerField("Вторичного рынка показано", default=0)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Суточная статистика выдачи"
        verbose_name_plural = "Суточная статистика выдачи"
        unique_together = [('user', 'date')]
        ordering = ['-date']
        indexes = [
            models.Index(fields=['user', 'date']),
        ]

    def __str__(self):
        return f"{self.user} — {self.date}: {self.objects_shown} объектов"