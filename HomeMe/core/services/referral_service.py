"""
Реферальная система (ТЗ п.10) — код приглашения и привязка пригласившего.
"""
from __future__ import annotations

import re
import secrets
from typing import Optional

from django.conf import settings

from telegram_bot.models import BotUser


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
    Возвращает True, если привязка выполнена или уже была.
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


def build_telegram_referral_link(code: str) -> str:
    username = getattr(settings, "TELEGRAM_BOT_USERNAME", None) or ""
    username = username.lstrip("@")
    if not username:
        return f"https://t.me/me?start=ref_{code}"
    return f"https://t.me/{username}?start=ref_{code}"
