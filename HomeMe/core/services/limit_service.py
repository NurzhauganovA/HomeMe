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
from core.services.bot_text_service import BotTextService

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
        remaining = max(0, (role.limit_total_daily + log.bonus_limit_daily) - log.objects_shown)
        logger.debug(
            f"[LimitService] user={user.user_id} role={role.name} "
            f"limit={role.limit_total_daily} used={log.objects_shown} remaining={remaining}"
        )
        return remaining

    @staticmethod
    def _get_remaining_breakdown(user) -> dict:
        role = getattr(user, 'role', None)
        if role is None:
            return {
                'total': _UNLIMITED,
                'apartments': _UNLIMITED,
                'commercial': _UNLIMITED,
                'primary': _UNLIMITED,
                'secondary': _UNLIMITED,
            }

        log = LimitService._get_today_log(user)
        return {
            'total': max(0, (role.limit_total_daily + log.bonus_limit_daily) - log.objects_shown),
            'apartments': max(0, role.limit_apartments_daily - log.apartments_shown),
            'commercial': max(0, role.limit_commercial_daily - log.commercial_shown),
            'primary': max(0, role.limit_primary_daily - log.primary_shown),
            'secondary': max(0, role.limit_secondary_daily - log.secondary_shown),
        }

    @staticmethod
    def _detect_categories(item, fallback_params: dict) -> dict:
        source = getattr(item, 'source', None) or fallback_params.get('source', 'mixed')
        title = (getattr(item, 'title', '') or '').lower()
        building_type = (getattr(item, 'building_type', '') or '').lower()

        is_primary = source == 'bi_group'
        is_secondary = source == 'secondary'

        if is_secondary:
            is_commercial = building_type == 'commercial'
        elif is_primary:
            is_commercial = title.startswith('бц') or 'коммер' in title
        else:
            # fallback для mixed/нестандартных результатов
            bi_category = fallback_params.get('bi_category', 'residential')
            secondary_category = fallback_params.get('secondary_category', 'apartment')
            is_commercial = bi_category == 'commercial' or secondary_category == 'commercial'

        return {
            'is_primary': is_primary,
            'is_secondary': is_secondary,
            'is_commercial': is_commercial,
            'is_apartment': not is_commercial,
        }

    @staticmethod
    def record_shown(user, count: int, params: dict, results: list | None = None):
        """Записывает, что пользователю показано `count` объектов."""
        if count <= 0:
            return

        log = LimitService._get_today_log(user)

        log.objects_shown += count
        if results:
            apartments_delta = 0
            commercial_delta = 0
            primary_delta = 0
            secondary_delta = 0
            for item in results:
                categories = LimitService._detect_categories(item, params)
                if categories['is_apartment']:
                    apartments_delta += 1
                if categories['is_commercial']:
                    commercial_delta += 1
                if categories['is_primary']:
                    primary_delta += 1
                if categories['is_secondary']:
                    secondary_delta += 1
            log.apartments_shown += apartments_delta
            log.commercial_shown += commercial_delta
            log.primary_shown += primary_delta
            log.secondary_shown += secondary_delta
        else:
            source = params.get('source', 'mixed')
            bi_category = params.get('bi_category', 'residential')
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

        remaining = LimitService._get_remaining_breakdown(user)
        if remaining['total'] <= 0:
            logger.info(f"[LimitService] BLOCKED: user={user.user_id} limit exhausted")
            return [], 0, True

        # Поштучно отбираем результаты, чтобы учитывать category limits.
        limited = []
        for item in results:
            categories = LimitService._detect_categories(item, params)
            if remaining['total'] <= 0:
                break
            if categories['is_apartment'] and remaining['apartments'] <= 0:
                continue
            if categories['is_commercial'] and remaining['commercial'] <= 0:
                continue
            if categories['is_primary'] and remaining['primary'] <= 0:
                continue
            if categories['is_secondary'] and remaining['secondary'] <= 0:
                continue

            limited.append(item)
            remaining['total'] -= 1
            if categories['is_apartment']:
                remaining['apartments'] -= 1
            if categories['is_commercial']:
                remaining['commercial'] -= 1
            if categories['is_primary']:
                remaining['primary'] -= 1
            if categories['is_secondary']:
                remaining['secondary'] -= 1

        if not limited:
            logger.info(f"[LimitService] BLOCKED: user={user.user_id} category limits exhausted")
            return [], 0, True

        LimitService.record_shown(user, len(limited), params, results=limited)
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
        return BotTextService.get(
            "limit.daily_exceeded",
            fallback=(
                "⚠️ Вы исчерпали дневной лимит объектов ({limit} шт.) для роли «{role_name}».\n\n"
                "Лимит обновится завтра. Если нужно больше — обратитесь к администратору."
            ),
            limit=limit,
            role_name=role_name,
        )
