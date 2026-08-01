from django.contrib import admin
from .models import (
    ApiAccessToken, Permission, Role, BotText,
    FeedbackSurvey, FeedbackSurveyQuestion,
    FeedbackSurveySubmission, FeedbackSurveyAnswer,
    BIGroupLeadLog, ReferralLink,
)


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


@admin.register(ReferralLink)
class ReferralLinkAdmin(admin.ModelAdmin):
    list_display = ("name", "code", "role", "is_active", "get_registrations_count", "created_at")
    list_filter = ("is_active", "role")
    search_fields = ("name", "code", "notes")
    readonly_fields = ("created_at", "updated_at")

    @admin.display(description="Регистраций")
    def get_registrations_count(self, obj):
        return obj.get_registrations_count()


@admin.register(BotText)
class BotTextAdmin(admin.ModelAdmin):
    list_display = ("key", "channel", "locale", "is_active", "updated_at")
    list_filter = ("channel", "locale", "is_active")
    search_fields = ("key", "description", "text")
    ordering = ("key", "channel", "locale")


class FeedbackSurveyQuestionInline(admin.TabularInline):
    model = FeedbackSurveyQuestion
    extra = 1
    fields = ("order", "text", "question_type", "options", "is_required", "is_active")
    ordering = ("order",)


@admin.register(FeedbackSurvey)
class FeedbackSurveyAdmin(admin.ModelAdmin):
    list_display = (
        "title", "trigger_type", "trigger_search_count",
        "trigger_objects_count", "bonus_extra_limit", "is_active", "updated_at"
    )
    list_filter = ("trigger_type", "is_active")
    search_fields = ("title", "description", "motivation_text")
    inlines = [FeedbackSurveyQuestionInline]
    fieldsets = (
        ("Основное", {"fields": ("title", "description", "is_active")}),
        ("Момент показа анкеты", {"fields": ("trigger_type", "trigger_search_count", "trigger_objects_count")}),
        ("Мотивация и бонус", {"fields": ("motivation_text", "bonus_extra_limit")}),
    )


class FeedbackSurveyAnswerInline(admin.TabularInline):
    model = FeedbackSurveyAnswer
    extra = 0
    fields = ("question", "answer_text", "answer_rating", "answer_options", "created_at")
    readonly_fields = ("question", "answer_text", "answer_rating", "answer_options", "created_at")
    can_delete = False


@admin.register(FeedbackSurveySubmission)
class FeedbackSurveySubmissionAdmin(admin.ModelAdmin):
    list_display = ("survey", "user", "status", "bonus_applied", "created_at", "completed_at")
    list_filter = ("status", "bonus_applied", "survey")
    search_fields = ("user__name", "user__user_id", "survey__title")
    readonly_fields = ("survey", "user", "status", "bonus_applied", "created_at", "completed_at")
    inlines = [FeedbackSurveyAnswerInline]
    ordering = ("-created_at",)


@admin.register(FeedbackSurveyAnswer)
class FeedbackSurveyAnswerAdmin(admin.ModelAdmin):
    list_display = ("submission", "question", "answer_rating", "created_at")
    list_filter = ("question__survey", "question__question_type")
    search_fields = ("answer_text", "submission__user__name")


@admin.register(BIGroupLeadLog)
class BIGroupLeadLogAdmin(admin.ModelAdmin):
    list_display = ("created_at", "name", "phone", "complex_name", "success", "error_message_short")
    list_filter = ("success", "created_at")
    search_fields = ("name", "phone", "complex_name", "complex_uuid")
    readonly_fields = (
        "phone", "name", "complex_uuid", "complex_name", "source",
        "comment", "meta", "success", "error_message", "response_data", "created_at",
    )
    ordering = ("-created_at",)

    @admin.display(description="Ошибка")
    def error_message_short(self, obj):
        return obj.error_message[:80] if obj.error_message else "—"
