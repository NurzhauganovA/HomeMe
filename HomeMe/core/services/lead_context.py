"""Контекст лида для CRM и аналитики (ТЗ п.6.1)."""
from __future__ import annotations

from typing import Any, Dict, Optional


def budget_note_from_params(params: Optional[dict]) -> str:
    if not params:
        return ""
    parts = []
    for key, label in (("min_price", "от"), ("max_price", "до")):
        v = params.get(key)
        if v is not None and v != "":
            parts.append(f"{label} {v}")
    return " ".join(parts)


def labels_from_params(params: Optional[dict]) -> tuple[str, str]:
    """property_type_label, market_type_label на русском для отчётов."""
    if not params:
        return "", ""
    src = (params.get("source") or "").lower()
    if src == "bi":
        mkt = "Первичный рынок"
        if params.get("bi_category") == "commercial":
            return "Коммерческая недвижимость", mkt
        return "Квартиры", mkt
    if src == "secondary":
        mkt = "Вторичный рынок"
        if params.get("secondary_category") == "commercial":
            return "Коммерческая недвижимость", mkt
        return "Квартиры", mkt
    if src == "mixed":
        return "Смешанный запрос", "Смешанный рынок"
    return "", ""


def district_from_params(params: Optional[dict]) -> str:
    if not params:
        return ""
    return str(params.get("district") or params.get("embedding_text") or "")[:120]


def snapshot_for_expert_lead(params: Optional[dict]) -> Dict[str, Any]:
    prop, mkt = labels_from_params(params)
    return {
        "lead_source": "expert_request",
        "developer": "",
        "residential_complex": "",
        "district": district_from_params(params),
        "property_type_label": prop,
        "market_type_label": mkt,
        "budget_display": budget_note_from_params(params)[:160],
    }


def snapshot_for_bi_contact(params: Optional[dict], property_data: Dict[str, Any]) -> Dict[str, Any]:
    merged = dict(params or {})
    merged.setdefault("source", "bi")
    prop, _ = labels_from_params(merged)
    return {
        "lead_source": "bi_primary_contact",
        "developer": "BI Group",
        "residential_complex": str(property_data.get("title") or "")[:255],
        "district": str(property_data.get("district") or district_from_params(params))[:120],
        "property_type_label": prop or "Квартиры / коммерция (BI)",
        "market_type_label": "Первичный рынок",
        "budget_display": budget_note_from_params(params)[:160],
    }
