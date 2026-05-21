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


class BotText(models.Model):
    """Редактируемые тексты бота по ключам."""

    CHANNEL_CHOICES = [
        ('all', 'Все каналы'),
        ('telegram', 'Telegram'),
        ('whatsapp', 'WhatsApp'),
    ]
    LOCALE_CHOICES = [
        ('ru', 'Русский'),
        ('kk', 'Қазақ'),
        ('en', 'English'),
    ]

    key = models.CharField("Ключ", max_length=120, db_index=True)
    channel = models.CharField("Канал", max_length=20, choices=CHANNEL_CHOICES, default='telegram')
    locale = models.CharField("Язык", max_length=5, choices=LOCALE_CHOICES, default='ru')
    text = models.TextField("Текст")
    description = models.CharField("Описание", max_length=255, blank=True)
    is_active = models.BooleanField("Активен", default=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Текст бота"
        verbose_name_plural = "Тексты бота"
        ordering = ['key', 'channel', 'locale']
        constraints = [
            models.UniqueConstraint(fields=['key', 'channel', 'locale'], name='unique_bot_text_key_channel_locale')
        ]

    def __str__(self):
        return f"{self.key} [{self.channel}/{self.locale}]"


class FeedbackSurvey(models.Model):
    """Анкета обратной связи."""

    TRIGGER_TYPE_CHOICES = [
        ('manual', 'Только вручную'),
        ('search_count', 'После количества поисков'),
        ('objects_count', 'После количества полученных объектов'),
    ]

    title = models.CharField("Название анкеты", max_length=150)
    description = models.TextField("Описание", blank=True)
    motivation_text = models.TextField(
        "Мотивация прохождения",
        blank=True,
        help_text="Текст бонуса/мотивации, который показывается пользователю."
    )
    bonus_extra_limit = models.IntegerField(
        "Бонус к суточному лимиту (объектов)",
        default=0,
        help_text="Сколько дополнительных объектов получает пользователь после прохождения анкеты."
    )
    trigger_type = models.CharField(
        "Момент показа анкеты",
        max_length=20,
        choices=TRIGGER_TYPE_CHOICES,
        default='manual'
    )
    trigger_search_count = models.IntegerField(
        "Показать после N поисков",
        default=0,
        help_text="Используется если trigger_type=search_count"
    )
    trigger_objects_count = models.IntegerField(
        "Показать после N полученных объектов",
        default=0,
        help_text="Используется если trigger_type=objects_count"
    )
    is_active = models.BooleanField("Активна", default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Анкета обратной связи"
        verbose_name_plural = "Анкеты обратной связи"
        ordering = ['-updated_at']

    def __str__(self):
        return self.title


class FeedbackSurveyQuestion(models.Model):
    """Вопрос анкеты."""

    QUESTION_TYPE_CHOICES = [
        ('text', 'Текстовый ответ'),
        ('single_choice', 'Один вариант'),
        ('multi_choice', 'Несколько вариантов'),
        ('rating', 'Оценка (1-5)'),
    ]

    survey = models.ForeignKey(
        FeedbackSurvey,
        on_delete=models.CASCADE,
        related_name='questions',
        verbose_name="Анкета"
    )
    text = models.TextField("Текст вопроса")
    question_type = models.CharField("Тип вопроса", max_length=20, choices=QUESTION_TYPE_CHOICES, default='text')
    options = models.JSONField(
        "Варианты ответа",
        default=list,
        blank=True,
        help_text="Список строк для single_choice/multi_choice."
    )
    order = models.PositiveIntegerField("Порядок", default=1, db_index=True)
    is_required = models.BooleanField("Обязательный", default=True)
    is_active = models.BooleanField("Активен", default=True, db_index=True)

    class Meta:
        verbose_name = "Вопрос анкеты"
        verbose_name_plural = "Вопросы анкеты"
        ordering = ['order', 'id']
        constraints = [
            models.UniqueConstraint(fields=['survey', 'order'], name='unique_question_order_per_survey')
        ]

    def __str__(self):
        return f"{self.survey.title}: {self.text[:60]}"


class FeedbackSurveySubmission(models.Model):
    """Факт прохождения анкеты пользователем."""

    STATUS_CHOICES = [
        ('started', 'Начата'),
        ('completed', 'Завершена'),
    ]

    survey = models.ForeignKey(
        FeedbackSurvey,
        on_delete=models.CASCADE,
        related_name='submissions',
        verbose_name="Анкета"
    )
    user = models.ForeignKey(
        'telegram_bot.BotUser',
        on_delete=models.CASCADE,
        related_name='survey_submissions',
        verbose_name="Пользователь"
    )
    status = models.CharField("Статус", max_length=20, choices=STATUS_CHOICES, default='started')
    bonus_applied = models.BooleanField("Бонус применен", default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        verbose_name = "Прохождение анкеты"
        verbose_name_plural = "Прохождения анкет"
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['survey', 'status']),
            models.Index(fields=['user', '-created_at']),
        ]

    def __str__(self):
        return f"{self.user} / {self.survey} / {self.status}"


class FeedbackSurveyAnswer(models.Model):
    """Ответ на отдельный вопрос анкеты."""

    submission = models.ForeignKey(
        FeedbackSurveySubmission,
        on_delete=models.CASCADE,
        related_name='answers',
        verbose_name="Прохождение"
    )
    question = models.ForeignKey(
        FeedbackSurveyQuestion,
        on_delete=models.CASCADE,
        related_name='answers',
        verbose_name="Вопрос"
    )
    answer_text = models.TextField("Ответ", blank=True)
    answer_rating = models.IntegerField("Оценка", null=True, blank=True)
    answer_options = models.JSONField("Выбранные варианты", default=list, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Ответ анкеты"
        verbose_name_plural = "Ответы анкет"
        ordering = ['created_at']
        constraints = [
            models.UniqueConstraint(fields=['submission', 'question'], name='unique_answer_per_submission_question')
        ]

    def __str__(self):
        return f"{self.submission_id}/{self.question_id}"


class BIGroupLeadLog(models.Model):
    """Лог отправок лидов в CRM BI Group."""

    phone = models.CharField("Телефон", max_length=30, blank=True, db_index=True)
    name = models.CharField("Имя", max_length=150, blank=True)
    complex_uuid = models.CharField("UUID ЖК", max_length=100, blank=True, db_index=True)
    complex_name = models.CharField("Название ЖК", max_length=255, blank=True)
    source = models.CharField("Источник", max_length=50, blank=True)
    comment = models.TextField("Комментарий", blank=True)
    meta = models.JSONField("Мета (TG username/ID)", default=dict, blank=True)

    success = models.BooleanField("Успешно", default=False, db_index=True)
    error_message = models.TextField("Ошибка", blank=True)
    response_data = models.JSONField("Ответ API", default=dict, blank=True)

    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        verbose_name = "Лог лидов BI Group CRM"
        verbose_name_plural = "Логи лидов BI Group CRM"
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['success', '-created_at']),
        ]

    def __str__(self):
        status = "✅" if self.success else "❌"
        return f"{status} {self.name} | {self.complex_name} | {self.created_at:%Y-%m-%d %H:%M}"
