"""
PermissionService — централизованные проверки role-permissions для бота.

Политика:
- Если у пользователя нет активной роли, доступ запрещается.
- Если у роли нет нужного permission, действие блокируется.
- Проверки выполняются в рантайме перед критичными действиями.
"""

from __future__ import annotations

from typing import Tuple


class PermissionService:
    @staticmethod
    def has_permission(user, codename: str) -> bool:
        role = getattr(user, "role", None)
        if not role or not getattr(role, "is_active", False):
            return False

        return role.permissions.filter(codename=codename).exists()

    @staticmethod
    def denied_message(codename: str) -> str:
        human_action = {
            "use_bot": "использование бота",
            "search_properties": "поиск объектов",
            "manage_favorites": "управление избранным",
            "request_consultation": "запрос консультации",
            "view_contacts": "просмотр контактов",
        }.get(codename, "это действие")
        return (
            f"⛔ У вас нет доступа на {human_action}.\n\n"
            "Обратитесь к администратору, чтобы он выдал нужные разрешения для вашей роли."
        )

    @staticmethod
    def assert_permission(user, codename: str) -> Tuple[bool, str]:
        if PermissionService.has_permission(user, codename):
            return True, ""
        return False, PermissionService.denied_message(codename)
