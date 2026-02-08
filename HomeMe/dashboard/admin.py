from django.contrib import admin
from .models import ApiAccessToken


@admin.register(ApiAccessToken)
class ApiAccessTokenAdmin(admin.ModelAdmin):
    list_display = ("name", "is_active", "expires_at", "created_at")
    search_fields = ("name", "token")
    list_filter = ("is_active",)
