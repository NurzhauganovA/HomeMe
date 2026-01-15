"""
Enhanced Django Signals
Автоматическая генерация эмбеддингов, логирование и хуки для моделей.
"""

from django.db.models.signals import pre_save, post_save, post_delete
from django.dispatch import receiver
from django.utils import timezone
from telegram_bot.models import SecondaryProperty, BotUser, Lead, SearchLog
import logging

logger = logging.getLogger(__name__)


# =============== EMBEDDINGS AUTO-GENERATION ===============

@receiver(pre_save, sender=SecondaryProperty)
def generate_property_embedding(sender, instance, **kwargs):
    """
    Автоматически генерирует вектор для SecondaryProperty при сохранении.
    Срабатывает только если:
    1. Описание изменилось
    2. Или вектора еще нет
    """
    # Проверяем, нужно ли генерировать эмбеддинг
    should_generate = False

    if instance.pk:
        # Объект существует - проверяем изменения
        try:
            old_instance = SecondaryProperty.objects.get(pk=instance.pk)
            if old_instance.description != instance.description:
                should_generate = True
                logger.info(f"📝 Description changed for property {instance.pk}, will regenerate embedding")
        except SecondaryProperty.DoesNotExist:
            should_generate = True
    else:
        # Новый объект
        should_generate = True

    # Генерируем эмбеддинг если нужно
    if should_generate and instance.description:
        try:
            from core.services.ai_service import EnhancedAIService

            ai = EnhancedAIService()
            full_text = instance.get_full_text()

            logger.info(f"🧠 Generating embedding for property: {instance.title[:30]}...")
            embedding = ai.get_embedding(full_text)

            if embedding:
                instance.embedding = embedding
                logger.info(f"✅ Embedding generated successfully (dim: {len(embedding)})")
            else:
                logger.warning(f"⚠️ Failed to generate embedding for property {instance.pk}")

        except Exception as e:
            logger.error(f"❌ Error generating embedding: {e}")
            # Не прерываем сохранение объекта


# =============== USER ACTIVITY TRACKING ===============

@receiver(post_save, sender=BotUser)
def log_user_creation(sender, instance, created, **kwargs):
    """Логирует создание нового пользователя"""
    if created:
        logger.info(f"👤 New user registered: {instance.name} ({instance.platform}) - ID: {instance.user_id}")


@receiver(post_save, sender=Lead)
def log_lead_creation(sender, instance, created, **kwargs):
    """
    Логирует создание лида и отправляет уведомление.
    В будущем можно интегрировать с Bitrix24 здесь.
    """
    if created:
        logger.info(f"📋 New lead created: #{instance.id} from {instance.user.name}")
        logger.info(f"   Request: {instance.request_text[:100]}")
        logger.info(f"   Params: {instance.search_params}")

        # TODO: Интеграция с Bitrix24 CRM
        # send_to_bitrix24(instance)

        # TODO: Уведомление менеджерам в Telegram
        # notify_managers(instance)


@receiver(post_save, sender=Lead)
def log_lead_status_change(sender, instance, created, **kwargs):
    """Логирует изменение статуса лида"""
    if not created:
        logger.info(f"🔄 Lead #{instance.id} status changed to: {instance.status}")

        # Автоматически заполняем временные метки
        if instance.status == 'contacted' and not instance.contacted_at:
            instance.contacted_at = timezone.now()
            instance.save(update_fields=['contacted_at'])

        if instance.status == 'closed' and not instance.closed_at:
            instance.closed_at = timezone.now()
            instance.save(update_fields=['closed_at'])


# =============== SEARCH ANALYTICS ===============

@receiver(post_save, sender=SearchLog)
def analyze_search_patterns(sender, instance, created, **kwargs):
    """
    Анализирует паттерны поиска для улучшения AI.
    Можно использовать для обучения или A/B тестирования.
    """
    if created:
        # Логируем поисковые запросы с низкой уверенностью AI
        if instance.ai_confidence < 0.5:
            logger.warning(
                f"⚠️ Low AI confidence ({instance.ai_confidence:.2f}) for query: "
                f"{instance.query_text[:50]}"
            )

        # Логируем поиски без результатов
        if instance.results_count == 0:
            logger.warning(
                f"🔍 No results for query: {instance.query_text[:50]} "
                f"(city={instance.detected_city}, district={instance.detected_district})"
            )


# =============== DATA INTEGRITY & VALIDATION ===============

@receiver(pre_save, sender=SecondaryProperty)
def validate_property_data(sender, instance, **kwargs):
    """Валидация данных перед сохранением"""

    # Проверяем, что этаж не больше общего количества
    if instance.floor > instance.total_floors:
        logger.warning(
            f"⚠️ Invalid floor data: floor={instance.floor} > total_floors={instance.total_floors}. "
            f"Auto-correcting..."
        )
        instance.floor = instance.total_floors

    # Проверяем адекватность цены
    if instance.price < 1_000_000:
        logger.warning(f"⚠️ Suspiciously low price: {instance.price} ₸")

    if instance.price > 1_000_000_000:
        logger.warning(f"⚠️ Suspiciously high price: {instance.price} ₸")

    # Проверяем площадь
    if instance.area < 10:
        logger.warning(f"⚠️ Suspiciously small area: {instance.area} m²")

    if instance.area > 1000:
        logger.warning(f"⚠️ Suspiciously large area: {instance.area} m²")


# =============== CACHE INVALIDATION ===============

@receiver(post_save, sender=SecondaryProperty)
@receiver(post_delete, sender=SecondaryProperty)
def invalidate_search_cache(sender, instance, **kwargs):
    """
    Инвалидирует кэш поиска при изменении недвижимости.
    """
    # TODO: Если используется Redis/Memcached, очищаем кэш здесь
    logger.info(f"🗑 Cache invalidated due to property change: {instance.id}")


# =============== STATISTICS & METRICS ===============

@receiver(post_save, sender=SearchLog)
def update_search_statistics(sender, instance, created, **kwargs):
    """
    Обновляет статистику поисков пользователя.
    """
    if created and instance.user:
        instance.user.increment_searches()


# =============== BACKUP & AUDIT ===============

@receiver(pre_save, sender=Lead)
def audit_lead_changes(sender, instance, **kwargs):
    """
    Аудит изменений лида (для compliance).
    """
    if instance.pk:
        try:
            old_instance = Lead.objects.get(pk=instance.pk)

            # Логируем изменения статуса
            if old_instance.status != instance.status:
                logger.info(
                    f"📊 Lead #{instance.id} status: "
                    f"{old_instance.status} → {instance.status}"
                )

            # Логируем назначение менеджера
            if old_instance.assigned_to != instance.assigned_to:
                logger.info(
                    f"👤 Lead #{instance.id} assigned: "
                    f"{old_instance.assigned_to or 'None'} → {instance.assigned_to or 'None'}"
                )

        except Lead.DoesNotExist:
            pass


# =============== NOTIFICATION SYSTEM ===============

def send_telegram_notification(message: str):
    """
    Отправляет уведомление администраторам в Telegram.
    TODO: Реализовать отправку через Bot API
    """
    logger.info(f"📱 Notification: {message}")
    # Здесь будет код отправки уведомления


@receiver(post_save, sender=Lead)
def notify_on_urgent_lead(sender, instance, created, **kwargs):
    """
    Отправляет уведомление при создании срочного лида.
    """
    if created and instance.priority >= 4:
        message = (
            f"🚨 СРОЧНЫЙ ЛИД!\n"
            f"ID: {instance.id}\n"
            f"От: {instance.user.name}\n"
            f"Запрос: {instance.request_text[:100]}\n"
            f"Приоритет: {instance.priority}"
        )
        send_telegram_notification(message)


# =============== CLEANUP & MAINTENANCE ===============

from django.db.models.signals import post_migrate


@receiver(post_migrate)
def cleanup_old_sessions(sender, **kwargs):
    """
    Очищает устаревшие сессии при миграции.
    """
    from telegram_bot.models import UserSession
    from datetime import timedelta

    # Удаляем сессии старше 30 дней
    threshold = timezone.now() - timedelta(days=30)
    deleted_count, _ = UserSession.objects.filter(updated_at__lt=threshold).delete()

    if deleted_count > 0:
        logger.info(f"🗑 Cleaned up {deleted_count} old sessions")


# =============== PERFORMANCE MONITORING ===============

@receiver(post_save, sender=SearchLog)
def monitor_search_performance(sender, instance, created, **kwargs):
    """
    Мониторит производительность поиска.
    """
    if created:
        duration_ms = instance.search_duration_ms

        # Логируем медленные запросы
        if duration_ms > 5000:  # 5 секунд
            logger.warning(
                f"🐌 Slow search detected: {duration_ms}ms for query: "
                f"{instance.query_text[:50]}"
            )

        # Логируем очень быстрые (кэш?)
        if duration_ms < 100:
            logger.debug(f"⚡ Fast search: {duration_ms}ms (likely cached)")


# =============== DATA ENRICHMENT ===============

@receiver(pre_save, sender=SecondaryProperty)
def enrich_property_data(sender, instance, **kwargs):
    """
    Автоматически обогащает данные объекта.
    Например, определяет город по адресу.
    """
    if not instance.city and instance.address:
        address_lower = instance.address.lower()

        # Простая эвристика определения города
        if any(word in address_lower for word in ['астана', 'astana', 'нурсултан']):
            instance.city = 'Astana'
            logger.info(f"🏙 Auto-detected city: Astana")

        elif any(word in address_lower for word in ['алматы', 'almaty']):
            instance.city = 'Almaty'
            logger.info(f"🏙 Auto-detected city: Almaty")

        elif any(word in address_lower for word in ['шымкент', 'shymkent']):
            instance.city = 'Shymkent'
            logger.info(f"🏙 Auto-detected city: Shymkent")