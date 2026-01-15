from django.db import models
from pgvector.django import VectorField


class BotUser(models.Model):
    """Универсальный пользователь (и для TG, и для WA)"""
    PLATFORM_CHOICES = [
        ('whatsapp', 'WhatsApp'),
        ('telegram', 'Telegram'),
    ]
    platform = models.CharField(max_length=20, choices=PLATFORM_CHOICES)
    user_id = models.CharField(max_length=50, unique=True) # Phone for WA, ID for TG
    name = models.CharField(max_length=100, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} ({self.platform})"


class UserSession(models.Model):
    """Хранение состояния диалога (Context)"""
    user = models.OneToOneField(BotUser, on_delete=models.CASCADE, related_name='session')
    # Текущий интент (например, 'search_process', 'waiting_contact')
    current_intent = models.CharField(max_length=50, default='greeting')
    # Накопленные фильтры (JSON): {'rooms': 2, 'max_price': 50000000}
    search_params = models.JSONField(default=dict, blank=True)
    updated_at = models.DateTimeField(auto_now=True)


class Lead(models.Model):
    """Лид для менеджера"""
    user = models.ForeignKey(BotUser, on_delete=models.CASCADE)
    request_text = models.TextField("Запрос")
    created_at = models.DateTimeField(auto_now_add=True)
    is_processed = models.BooleanField(default=False)

    def __str__(self):
        return f"Lead form {self.user.name}"


# Для векторов нам понадобится pgvector в будущем, пока используем JSONField или ArrayField
# Если база SQLite (для старта), векторы пока не сохраним эффективно, но структуру заложим.

class SecondaryProperty(models.Model):
    """Объект вторичной недвижимости"""

    title = models.CharField("Заголовок", max_length=200)
    description = models.TextField("Описание")
    address = models.CharField("Адрес", max_length=255)

    price = models.DecimalField("Цена", max_digits=12, decimal_places=0)
    rooms = models.IntegerField("Кол-во комнат")
    area = models.FloatField("Площадь (м2)")
    floor = models.IntegerField("Этаж")
    total_floors = models.IntegerField("Всего этажей")

    # Контакты владельца (скрытые данные)
    owner_phone = models.CharField("Телефон владельца", max_length=20)
    owner_name = models.CharField("Имя владельца", max_length=100)

    # Метаданные
    is_active = models.BooleanField("Активно", default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    image = models.ImageField("Фото", upload_to='properties/', blank=True, null=True)

    # Векторное представление описания (для RAG поиска через Gemini)
    # Позволит искать: "Хочу светлую квартиру с ремонтом"
    embedding = VectorField(dimensions=768, null=True, blank=True)

    def __str__(self):
        return f"{self.title} - {self.price} ₸"

    class Meta:
        verbose_name = "Вторичка"
        verbose_name_plural = "Вторичная недвижимость"