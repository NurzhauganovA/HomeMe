from django.contrib import admin
from .models import ApiAccessToken, Permission, Role


@admin.register(ApiAccessToken)
class ApiAccessTokenAdmin(admin.ModelAdmin):
    list_display = ("name", "is_active", "expires_at", "created_at")
    search_fields = ("name", "token")
    list_filter = ("is_active",)


@admin.register(Permission)
class PermissionAdmin(admin.ModelAdmin):
    list_display = ("name", "codename", "category")
    list_filter = ("category",)
    search_fields = ("name", "codename", "description")
    ordering = ("category", "name")


@admin.register(Role)
class RoleAdmin(admin.ModelAdmin):
    list_display = (
        "name", "is_active",
        "limit_total_daily", "limit_apartments_daily",
        "limit_commercial_daily", "get_users_count", "created_at"
    )
    list_filter = ("is_active",)
    search_fields = ("name", "description")
    filter_horizontal = ("permissions",)
    readonly_fields = ("created_at", "updated_at")

    fieldsets = (
        ("Основное", {"fields": ("name", "description", "is_active")}),
        ("Разрешения", {"fields": ("permissions",)}),
        ("Лимиты выдачи объектов в сутки", {
            "fields": (
                "limit_total_daily",
                "limit_apartments_daily",
                "limit_commercial_daily",
                "limit_primary_daily",
                "limit_secondary_daily",
            )
        }),
        ("Метаданные", {"fields": ("created_at", "updated_at"), "classes": ("collapse",)}),
    )

    def get_users_count(self, obj):
        return obj.bot_users.count()
    get_users_count.short_description = "Пользователей"
