"""
Реферальная система (ТЗ п.10) — код приглашения, привязка пригласившего, роли.
"""
from __future__ import annotations

import logging
import re
import secrets
from dataclasses import dataclass
from typing import Optional

import requests
from django.conf import settings
from django.core.cache import cache

from telegram_bot.models import BotUser

logger = logging.getLogger(__name__)

BOT_USERNAME_CACHE_KEY = "homeme:telegram_bot_username"
BOT_USERNAME_CACHE_TTL = 86400

DEFAULT_ROLE_NAME = "Базовый"
REFERRAL_ROLE_NAME = "Реферал"

REF_CODE_PATTERN = re.compile(r"^ref_([A-Za-z0-9]+)$", re.I)


@dataclass
class ReferralProcessResult:
    """Результат обработки /start ref_CODE."""

    consumed: bool = False
    source: Optional[str] = None  # 'user' | 'campaign'
    role_assigned: bool = False
    role_name: Optional[str] = None


def generate_referral_code() -> str:
    return secrets.token_hex(4).upper()


def _code_exists(code: str, exclude_user_pk=None) -> bool:
    from dashboard.models import ReferralLink

    if BotUser.objects.filter(referral_code__iexact=code).exclude(pk=exclude_user_pk).exists():
        return True
    if ReferralLink.objects.filter(code__iexact=code).exists():
        return True
    return False


def ensure_referral_code(user: BotUser) -> str:
    if user.referral_code:
        return user.referral_code
    for _ in range(20):
        code = generate_referral_code()
        if not _code_exists(code, exclude_user_pk=user.pk):
            user.referral_code = code
            user.save(update_fields=["referral_code"])
            return code
    user.referral_code = f"U{user.pk.hex[:12].upper()}"
    user.save(update_fields=["referral_code"])
    return user.referral_code


def generate_campaign_code() -> str:
    """Уникальный код для админской реферальной ссылки."""
    for _ in range(30):
        code = secrets.token_hex(5).upper()
        if not _code_exists(code):
            return code
    return secrets.token_hex(8).upper()


def parse_start_argument(text: str) -> Optional[str]:
    t = (text or "").strip()
    if not t.lower().startswith("/start"):
        return None
    parts = t.split(maxsplit=1)
    if len(parts) < 2:
        return None
    return parts[1].strip() or None


def _get_role_by_name(name: str):
    from dashboard.models import Role

    return Role.objects.filter(name=name, is_active=True).first()


def _assign_role_if_needed(user: BotUser, role) -> bool:
    if not role or user.role_id:
        return False
    user.role = role
    user.save(update_fields=["role"])
    return True


def ensure_default_role(user: BotUser) -> bool:
    """Назначает роль «Базовый», если у пользователя ещё нет роли."""
    if user.role_id:
        return False
    role = _get_role_by_name(DEFAULT_ROLE_NAME)
    if not role:
        logger.warning("Роль «%s» не найдена — пользователь %s останется без роли", DEFAULT_ROLE_NAME, user.pk)
        return False
    user.role = role
    user.save(update_fields=["role"])
    return True


def process_referral_start(invitee: BotUser, start_arg: Optional[str]) -> ReferralProcessResult:
    """
    Обрабатывает /start ref_CODE:
    - админская ссылка (ReferralLink) → роль из ссылки;
    - пользовательская ссылка → invited_by + роль «Реферал».
    """
    result = ReferralProcessResult()
    if not start_arg:
        return result

    m = REF_CODE_PATTERN.match(start_arg.strip())
    if not m:
        return result

    code = m.group(1).upper()

    from dashboard.models import ReferralLink

    campaign = (
        ReferralLink.objects.filter(code__iexact=code, is_active=True)
        .select_related("role")
        .first()
    )
    if campaign:
        if not invitee.referral_link_id:
            invitee.referral_link = campaign
            invitee.save(update_fields=["referral_link"])
        if _assign_role_if_needed(invitee, campaign.role):
            result.role_assigned = True
            result.role_name = campaign.role.name
        result.consumed = True
        result.source = "campaign"
        return result

    if invitee.invited_by_id:
        return result

    referrer = BotUser.objects.filter(referral_code__iexact=code).exclude(pk=invitee.pk).first()
    if not referrer:
        return result

    invitee.invited_by = referrer
    invitee.save(update_fields=["invited_by"])

    referral_role = _get_role_by_name(REFERRAL_ROLE_NAME)
    if _assign_role_if_needed(invitee, referral_role):
        result.role_assigned = True
        result.role_name = REFERRAL_ROLE_NAME

    result.consumed = True
    result.source = "user"
    return result


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
    Порядок: TELEGRAM_BOT_USERNAME в .env → кэш (getMe при старте) → getMe API.
    """
    configured = getattr(settings, "TELEGRAM_BOT_USERNAME", None) or ""
    configured = str(configured).lstrip("@").strip()
    if configured:
        return configured

    cached = cache.get(BOT_USERNAME_CACHE_KEY)
    if cached:
        return str(cached).lstrip("@")

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
