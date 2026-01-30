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
    title = models.CharField("Заголовок", max_length=200, db_index=True)
    description = models.TextField("Описание")
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

    def get_full_text(self) -> str:
        """Возвращает полный текст для векторизации"""
        return f"{self.title}. {self.description}. Адрес: {self.address}. {self.city or ''}. {self.district or ''}"


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


class BIComplex(models.Model):
    """
    ЖК или очередь (realEstate из API)
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID из API", max_length=100, unique=True, db_index=True)

    # Основные данные
    name = models.CharField("Название ЖК", max_length=255)
    address = models.CharField("Адрес", max_length=500, blank=True)
    description = models.TextField(blank=True)

    # Геолокация (из API realEstateList)
    latitude = models.FloatField("Широта", null=True, blank=True)
    longitude = models.FloatField("Долгота", null=True, blank=True)
    city_uuid = models.CharField("UUID Города", max_length=100, db_index=True)

    # Характеристики ЖК
    class_name = models.CharField("Класс жилья", max_length=100, blank=True)  # Комфорт, Бизнес...
    deadline = models.CharField("Срок сдачи", max_length=50, blank=True)
    min_price = models.DecimalField("Цена от", max_digits=15, decimal_places=2, null=True)

    # Медиа
    url = models.URLField(blank=True)
    image_url = models.URLField("Фото 400px", blank=True)

    # === AI Brain ===
    # Сюда пишем теги после анализа описания и локации (quiet, park, center)
    features = models.JSONField("AI Теги", default=dict)
    # Сюда пишем векторное представление ЖК для умного поиска
    embedding = VectorField(dimensions=768, null=True, blank=True)

    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name}"

    def get_text_for_embedding(self):
        """Формирует текст для векторизации"""
        # Можно добавить сюда названия ближайших парков (если есть свой гео-сервис)
        return f"ЖК {self.name}. Класс: {self.class_name}. Адрес: {self.address}. Теги: {', '.join(self.features.keys())}"

    class Meta:
        db_table = 'bi_complexes'
        verbose_name = "ЖК"
        verbose_name_plural = "ЖК"


class BIUnit(models.Model):
    """
    Конкретная квартира (Placement из API).
    Хранит точные параметры для фильтрации.
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID Квартиры", max_length=100, unique=True, db_index=True)
    complex = models.ForeignKey(BIComplex, on_delete=models.CASCADE, related_name='units')

    # Параметры квартиры
    room_count = models.IntegerField("Комнат", db_index=True)
    floor = models.IntegerField("Этаж")
    max_floor = models.IntegerField("Всего этажей", null=True)
    area = models.FloatField("Площадь")

    # Цена
    price = models.DecimalField("Базовая цена", max_digits=15, decimal_places=2)
    price_discount = models.DecimalField("Цена со скидкой", max_digits=15, decimal_places=2, null=True)

    # Дополнительно
    block_name = models.CharField("Блок/Секция", max_length=100, blank=True)
    deadline = models.CharField("Срок сдачи секции", max_length=50, blank=True)
    is_active = models.BooleanField(default=True)  # Если пропала из API -> False

    class Meta:
        indexes = [
            models.Index(fields=['price_discount', 'room_count']),
            models.Index(fields=['area']),
        ]
        db_table = 'bi_units'
        verbose_name = "Квартира в ЖК"
        verbose_name_plural = "Квартиры в ЖК"

    def __str__(self):
        return f"{self.room_count}-комн, {self.area}м2 в {self.complex.name}"

    @property
    def current_price(self):
        return self.price_discount if self.price_discount else self.price


class BICommercialComplex(models.Model):
    """
    Коммерческий объект/очередь (realEstate из API)
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID из API", max_length=100, unique=True, db_index=True)

    # Основные данные
    name = models.CharField("Название объекта", max_length=255)
    address = models.CharField("Адрес", max_length=500, blank=True)
    description = models.TextField(blank=True)

    # Геолокация (из API realEstateList)
    latitude = models.FloatField("Широта", null=True, blank=True)
    longitude = models.FloatField("Долгота", null=True, blank=True)
    city_uuid = models.CharField("UUID Города", max_length=100, db_index=True)

    # Характеристики
    class_name = models.CharField("Класс", max_length=100, blank=True)
    deadline = models.CharField("Срок сдачи", max_length=50, blank=True)
    min_price = models.DecimalField("Цена от", max_digits=15, decimal_places=2, null=True)

    # Медиа
    url = models.URLField(blank=True)
    image_url = models.URLField("Фото 400px", blank=True)

    # === AI Brain ===
    features = models.JSONField("AI Теги", default=dict)
    embedding = VectorField(dimensions=768, null=True, blank=True)

    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.name}"

    def get_text_for_embedding(self):
        """Формирует текст для векторизации"""
        return (
            f"Коммерческий объект {self.name}. Класс: {self.class_name}. "
            f"Адрес: {self.address}. Теги: {', '.join(self.features.keys())}"
        )

    class Meta:
        db_table = 'bi_commercial_complexes'
        verbose_name = "Коммерческий объект"
        verbose_name_plural = "Коммерческие объекты"


class BICommercialUnit(models.Model):
    """
    Конкретный коммерческий объект (Placement из API).
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    bi_uuid = models.CharField("UUID объекта", max_length=100, unique=True, db_index=True)
    complex = models.ForeignKey(BICommercialComplex, on_delete=models.CASCADE, related_name='units')

    # Параметры
    room_count = models.IntegerField("Комнат", db_index=True)
    floor = models.IntegerField("Этаж")
    max_floor = models.IntegerField("Всего этажей", null=True)
    area = models.FloatField("Площадь")

    # Цена
    price = models.DecimalField("Базовая цена", max_digits=15, decimal_places=2)
    price_discount = models.DecimalField("Цена со скидкой", max_digits=15, decimal_places=2, null=True)

    # Дополнительно
    block_name = models.CharField("Блок/Секция", max_length=100, blank=True)
    deadline = models.CharField("Срок сдачи секции", max_length=50, blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        indexes = [
            models.Index(fields=['price_discount', 'room_count']),
            models.Index(fields=['area']),
        ]
        db_table = 'bi_commercial_units'
        verbose_name = "Коммерческое помещение"
        verbose_name_plural = "Коммерческие помещения"

    def __str__(self):
        return f"{self.area}м2 в {self.complex.name}"

    @property
    def current_price(self):
        return self.price_discount if self.price_discount else self.price