from django.urls import path
from django.contrib.auth.views import LogoutView
from . import views

app_name = 'dashboard'

urlpatterns = [
    # Главная страница дашборда
    path('', views.DashboardIndexView.as_view(), name='index'),

    # Лиды (CRM)
    path('leads/', views.LeadListView.as_view(), name='lead_list'),
    path('leads/<int:pk>/', views.LeadDetailView.as_view(), name='lead_detail'),
    path('leads/<int:pk>/update/', views.LeadUpdateView.as_view(), name='lead_update'),
    path('leads/<int:pk>/status/', views.LeadStatusUpdateView.as_view(), name='lead_status_update'),

    # Вторичная недвижимость
    path('secondary/', views.SecondaryPropertyListView.as_view(), name='secondary_list'),
    path('secondary/create/', views.SecondaryPropertyCreateView.as_view(), name='secondary_create'),
    path('secondary/<uuid:pk>/', views.SecondaryPropertyDetailView.as_view(), name='secondary_detail'),
    path('secondary/<uuid:pk>/update/', views.SecondaryPropertyUpdateView.as_view(), name='secondary_update'),
    path('secondary/<uuid:pk>/delete/', views.SecondaryPropertyDeleteView.as_view(), name='secondary_delete'),

    # BI Group
    path('bi-complexes/', views.BIComplexListView.as_view(), name='bi_complex_list'),
    path('bi-complexes/<uuid:pk>/', views.BIComplexDetailView.as_view(), name='bi_complex_detail'),
    path('bi-complexes/sync/', views.BISyncView.as_view(), name='bi_sync'),

    # Пользователи
    path('users/', views.BotUserListView.as_view(), name='user_list'),
    path('users/<uuid:pk>/', views.BotUserDetailView.as_view(), name='user_detail'),
    path('users/<uuid:pk>/assign-role/', views.AssignRoleView.as_view(), name='user_assign_role'),

    # Роли
    path('roles/', views.RoleListView.as_view(), name='role_list'),
    path('roles/create/', views.RoleCreateView.as_view(), name='role_create'),
    path('roles/<int:pk>/edit/', views.RoleUpdateView.as_view(), name='role_update'),
    path('roles/<int:pk>/delete/', views.RoleDeleteView.as_view(), name='role_delete'),

    # Разрешения
    path('permissions/', views.PermissionListView.as_view(), name='permission_list'),

    # Анкеты (UI-конструктор)
    path('surveys/', views.SurveyListView.as_view(), name='survey_list'),
    path('surveys/create/', views.SurveyCreateView.as_view(), name='survey_create'),
    path('surveys/<int:pk>/', views.SurveyDetailView.as_view(), name='survey_detail'),
    path('surveys/<int:pk>/edit/', views.SurveyEditView.as_view(), name='survey_edit'),
    path('surveys/<int:pk>/delete/', views.SurveyDeleteView.as_view(), name='survey_delete'),
    path('surveys/<int:pk>/toggle/', views.SurveyToggleView.as_view(), name='survey_toggle'),
    path('surveys/<int:survey_pk>/questions/add/', views.QuestionCreateView.as_view(), name='question_create'),
    path('surveys/<int:survey_pk>/questions/<int:pk>/edit/', views.QuestionEditView.as_view(), name='question_edit'),
    path('surveys/<int:survey_pk>/questions/<int:pk>/delete/', views.QuestionDeleteView.as_view(), name='question_delete'),
    path('surveys/<int:survey_pk>/questions/reorder/', views.QuestionReorderView.as_view(), name='question_reorder'),

    # Аналитика анкет
    path('survey-analytics/', views.SurveyAnalyticsView.as_view(), name='survey_analytics'),

    # Тексты бота
    path('bot-texts/', views.BotTextListView.as_view(), name='bot_text_list'),
    path('bot-texts/<int:pk>/edit/', views.BotTextEditView.as_view(), name='bot_text_edit'),

    # Аналитика (ТЗ)
    path('analytics/leads/', views.LeadAnalyticsView.as_view(), name='lead_analytics'),
    path('analytics/referrals/', views.ReferralAnalyticsView.as_view(), name='referral_analytics'),

    # Логи BI Group CRM
    path('bigroup-leads/', views.BIGroupLeadLogView.as_view(), name='bigroup_lead_log'),

    # Выход
    path('logout/', LogoutView.as_view(next_page='/admin/login/'), name='logout'),
]
