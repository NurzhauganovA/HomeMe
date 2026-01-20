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

    # Выход
    path('logout/', LogoutView.as_view(next_page='/admin/login/'), name='logout'),
]
