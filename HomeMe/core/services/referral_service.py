"""
Реферальная система (ТЗ п.10) — код приглашения и привязка пригласившего.
"""
from __future__ import annotations

import logging
import re
import secrets
from typing import Optional

import requests
from django.conf import settings
from django.core.cache import cache

from telegram_bot.models import BotUser

logger = logging.getLogger(__name__)

BOT_USERNAME_CACHE_KEY = "homeme:telegram_bot_username"
BOT_USERNAME_CACHE_TTL = 86400


def generate_referral_code() -> str:
    return secrets.token_hex(4).upper()


def ensure_referral_code(user: BotUser) -> str:
    if user.referral_code:
        return user.referral_code
    for _ in range(20):
        code = generate_referral_code()
        if not BotUser.objects.filter(referral_code=code).exclude(pk=user.pk).exists():
            user.referral_code = code
            user.save(update_fields=["referral_code"])
            return code
    user.referral_code = f"U{user.pk.hex[:12].upper()}"
    user.save(update_fields=["referral_code"])
    return user.referral_code


def parse_start_argument(text: str) -> Optional[str]:
    t = (text or "").strip()
    if not t.lower().startswith("/start"):
        return None
    parts = t.split(maxsplit=1)
    if len(parts) < 2:
        return None
    return parts[1].strip() or None


def try_attach_referrer(invitee: BotUser, start_arg: Optional[str]) -> bool:
    """
    Если start_arg вида ref_XXXXX — привязываем invited_by (один раз).
    Возвращает True, если привязка выполнена в этом вызове.
    """
    if not start_arg or invitee.invited_by_id:
        return False
    m = re.match(r"^ref_([A-Za-z0-9]+)$", start_arg.strip(), re.I)
    if not m:
        return False
    code = m.group(1).upper()
    referrer = BotUser.objects.filter(referral_code__iexact=code).exclude(pk=invitee.pk).first()
    if not referrer:
        return False
    invitee.invited_by = referrer
    invitee.save(update_fields=["invited_by"])
    return True


def cache_telegram_bot_username(username: str) -> None:
    """Сохраняет @username бота в кэш (вызывается при старте Telegram-бота)."""
    normalized = (username or "").lstrip("@").strip()
    if normalized:
        cache.set(BOT_USERNAME_CACHE_KEY, normalized, timeout=BOT_USERNAME_CACHE_TTL)


def _fetch_bot_username_from_api() -> Optional[str]:
    token = getattr(settings, "TELEGRAM_BOT_TOKEN", None)
    if not token:
        return None
    try:
        response = requests.get(
            f"https://api.telegram.org/bot{token}/getMe",
            timeout=5,
        )
        response.raise_for_status()
        payload = response.json()
        if payload.get("ok"):
            username = (payload.get("result") or {}).get("username")
            if username:
                return str(username).lstrip("@")
    except Exception as exc:
        logger.warning("Не удалось получить username бота через getMe: %s", exc)
    return None


def resolve_telegram_bot_username() -> Optional[str]:
    """
    Username бота для ссылок t.me/{username}.
    Порядок: кэш → TELEGRAM_BOT_USERNAME в .env → getMe API.
    """
    cached = cache.get(BOT_USERNAME_CACHE_KEY)
    if cached:
        return str(cached).lstrip("@")

    configured = getattr(settings, "TELEGRAM_BOT_USERNAME", None) or ""
    configured = str(configured).lstrip("@").strip()
    if configured:
        cache_telegram_bot_username(configured)
        return configured

    from_api = _fetch_bot_username_from_api()
    if from_api:
        cache_telegram_bot_username(from_api)
        return from_api

    return None


def build_telegram_referral_link(code: str) -> Optional[str]:
    """
    Возвращает рабочую ссылку t.me или None, если username бота неизвестен.
    """
    username = resolve_telegram_bot_username()
    if not username:
        return None
    return f"https://t.me/{username}?start=ref_{code}"


def build_referral_share_text(code: str) -> str:
    """
    Текст для пользователя: ссылка или запасной вариант /start ref_CODE.
    """
    link = build_telegram_referral_link(code)
    if link:
        return link
    return f"/start ref_{code}"
