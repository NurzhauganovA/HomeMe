from __future__ import annotations

from django.core.cache import cache

from dashboard.models import BotText


class BotTextService:
    CACHE_TTL_SECONDS = 300

    @staticmethod
    def _cache_key(key: str, channel: str, locale: str) -> str:
        return f"bot_text:{key}:{channel}:{locale}"

    @staticmethod
    def get(
        key: str,
        *,
        locale: str = "ru",
        channel: str = "telegram",
        fallback: str = "",
        **fmt,
    ) -> str:
        """
        Получает текст из БД с fallback и форматированием.
        Приоритет:
        1) key+channel+locale
        2) key+all+locale
        3) key+channel+ru
        4) key+all+ru
        """
        cache_key = BotTextService._cache_key(key, channel, locale)
        cached = cache.get(cache_key)
        if cached is not None:
            return BotTextService._format(cached, fallback, **fmt)

        text_obj = (
            BotText.objects.filter(key=key, channel=channel, locale=locale, is_active=True).first()
            or BotText.objects.filter(key=key, channel='all', locale=locale, is_active=True).first()
            or BotText.objects.filter(key=key, channel=channel, locale='ru', is_active=True).first()
            or BotText.objects.filter(key=key, channel='all', locale='ru', is_active=True).first()
        )
        text = text_obj.text if text_obj else fallback
        cache.set(cache_key, text, BotTextService.CACHE_TTL_SECONDS)
        return BotTextService._format(text, fallback, **fmt)

    @staticmethod
    def _format(text: str, fallback: str, **fmt) -> str:
        if not fmt:
            return text
        try:
            return text.format(**fmt)
        except Exception:
            return fallback
