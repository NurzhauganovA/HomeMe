"""
Продуктовая аналитика (ТЗ п.4) — события поведения пользователя в боте.
"""
from __future__ import annotations

from typing import Any, Dict, Optional

from telegram_bot.models import BotUser, BotProductEvent


def _classify_search_params(params: Optional[dict]) -> tuple[str, str]:
    """Возвращает (property_type, market_type) для фильтров дашборда."""
    if not params:
        return "", ""
    source = (params.get("source") or "").lower()
    if source in ("bi", "bi_group"):
        market = "primary"
        cat = params.get("bi_category")
        prop = "commercial" if cat == "commercial" else "apartments"
        return prop, market
    if source == "secondary":
        market = "secondary"
        sc = params.get("secondary_category")
        prop = "commercial" if sc == "commercial" else "apartments"
        return prop, market
    if source == "mixed":
        return "mixed", "mixed"
    return "", ""


class ProductAnalyticsService:
    """Запись событий аналитики (синхронно; вызывать через sync_to_async из бота)."""

    @staticmethod
    def record(
        user: BotUser,
        event_type: str,
        *,
        payload: Optional[Dict[str, Any]] = None,
        search_params: Optional[dict] = None,
    ) -> None:
        p = payload or {}
        prop, mkt = _classify_search_params(search_params)
        BotProductEvent.objects.create(
            user=user,
            event_type=event_type,
            payload=p,
            property_type=prop or "",
            market_type=mkt or "",
        )

    @staticmethod
    def snapshot_budget_note(params: Optional[dict]) -> str:
        if not params:
            return ""
        parts = []
        if params.get("min_price"):
            parts.append(f"от {params['min_price']}")
        if params.get("max_price"):
            parts.append(f"до {params['max_price']}")
        return " ".join(parts) if parts else ""
