from django.urls import path
from . import views

urlpatterns = [
    path('secondary/import/', views.SecondaryImportAPIView.as_view(), name='secondary_import_api'),
]
