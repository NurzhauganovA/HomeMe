"""
LimitService — проверка и учёт суточных лимитов выдачи объектов.

Логика:
  1. Если у пользователя нет роли → лимит бесконечный (не ограничен).
  2. Если роль есть → сравниваем суммарный счётчик из DailyUsageLog с limit_total_daily роли.
  3. При выдаче объектов — записываем факт показа в DailyUsageLog.
  4. При следующем запросе — обрезаем результаты до (лимит - уже_показано).
"""

import logging
from django.utils import timezone

logger = logging.getLogger(__name__)

_UNLIMITED = 999_999


class LimitService:

    @staticmethod
    def _get_today_log(user):
        """Возвращает (или создаёт) запись счётчика на сегодня."""
        from telegram_bot.models import DailyUsageLog
        today = timezone.now().date()
        log, _ = DailyUsageLog.objects.get_or_create(user=user, date=today)
        return log

    @staticmethod
    def get_remaining_total(user) -> int:
        """
        Сколько объектов пользователь ещё может получить сегодня.
        Возвращает _UNLIMITED если роли нет.
        """
        role = getattr(user, 'role', None)
        if role is None:
            return _UNLIMITED

        log = LimitService._get_today_log(user)
        remaining = max(0, role.limit_total_daily - log.objects_shown)
        logger.debug(
            f"[LimitService] user={user.user_id} role={role.name} "
            f"limit={role.limit_total_daily} used={log.objects_shown} remaining={remaining}"
        )
        return remaining

    @staticmethod
    def record_shown(user, count: int, params: dict):
        """Записывает, что пользователю показано `count` объектов."""
        if count <= 0:
            return

        log = LimitService._get_today_log(user)

        source = params.get('source', 'mixed')
        bi_category = params.get('bi_category', 'residential')

        log.objects_shown += count

        if source in ('bi', 'mixed'):
            if bi_category == 'commercial':
                log.commercial_shown += count
            else:
                log.apartments_shown += count
            log.primary_shown += count

        if source in ('secondary', 'mixed'):
            log.secondary_shown += count

        log.save(update_fields=[
            'objects_shown', 'apartments_shown', 'commercial_shown',
            'primary_shown', 'secondary_shown', 'updated_at',
        ])

        logger.info(
            f"[LimitService] recorded: user={user.user_id} +{count} objects "
            f"(total today: {log.objects_shown})"
        )

    @staticmethod
    def apply_limit(user, results: list, params: dict) -> tuple:
        """
        Обрезает список results до разрешённого суточного лимита и записывает показ.

        Returns:
            (limited_results, remaining_after, is_blocked)
            - limited_results: список объектов для показа (возможно усечённый)
            - remaining_after: сколько осталось после этой выдачи
            - is_blocked: True если лимит уже исчерпан ДО этой выдачи
        """
        if not results:
            return results, LimitService.get_remaining_total(user), False

        remaining_before = LimitService.get_remaining_total(user)

        if remaining_before <= 0:
            logger.info(f"[LimitService] BLOCKED: user={user.user_id} limit exhausted")
            return [], 0, True

        limited = results[:remaining_before]

        LimitService.record_shown(user, len(limited), params)
        remaining_after = LimitService.get_remaining_total(user)

        was_truncated = len(limited) < len(results)
        if was_truncated:
            logger.info(
                f"[LimitService] TRUNCATED: user={user.user_id} "
                f"requested={len(results)} shown={len(limited)}"
            )

        return limited, remaining_after, False

    @staticmethod
    def limit_exceeded_message(user) -> str:
        """Сообщение при исчерпании лимита."""
        role = getattr(user, 'role', None)
        role_name = role.name if role else "базовый"
        limit = role.limit_total_daily if role else 0
        return (
            f"⚠️ Вы исчерпали дневной лимит объектов ({limit} шт.) для роли «{role_name}».\n\n"
            "Лимит обновится завтра. Если нужно больше — обратитесь к администратору."
        )
