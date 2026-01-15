from django.db.models.signals import pre_save
from django.dispatch import receiver
from telegram_bot.models import SecondaryProperty
from core.services.ai_service import AIService


@receiver(pre_save, sender=SecondaryProperty)
def generate_property_embedding(sender, instance, **kwargs):
    """
    Автоматически создает вектор при сохранении квартиры,
    если описание изменилось или вектора нет.
    """
    if instance.description and not instance.embedding:
        ai = AIService()
        # Генерируем вектор из текста: "Заголовок + Описание + Адрес"
        full_text = f"{instance.title}. {instance.description}. Адрес: {instance.address}"
        embedding = ai.get_embedding(full_text)
        if embedding:
            instance.embedding = embedding
