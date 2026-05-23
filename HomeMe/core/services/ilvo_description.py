"""
Разделение описаний ILVO: внутреннее (description) и рекламное (public_description).
"""

from django.conf import settings


def _clean(text) -> str:
    if text is None:
        return ""
    return str(text).strip()


def descriptions_from_payload(payload: dict) -> tuple[str, str]:
    """
    Из payload ILVO: (внутреннее, рекламное).
    Оба поля могут приходить; рекламное необязательно.
    """
    internal = _clean(payload.get("description"))
    public = _clean(payload.get("public_description"))
    return internal, public


def public_description_for_ilvo_export(internal: str, public: str) -> str:
    """
    Значение поля public_description в ответе API для ILVO.
    По умолчанию пустое, если рекламного нет (рекомендация ILVO).
    """
    if public:
        return public
    if getattr(settings, "ILVO_EXPORT_PUBLIC_DESCRIPTION_FALLBACK", False):
        return internal
    return ""


def display_description(internal: str, public: str) -> str:
    """Текст для бота и показа пользователю: рекламный, иначе внутренний."""
    if public:
        return public
    return internal
