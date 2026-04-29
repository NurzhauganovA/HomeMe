# telegram_bot/migrations/0003_enable_pgvector.py
from django.contrib.postgres.operations import CreateExtension
from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ('telegram_bot', '0001_initial'),
    ]

    operations = [
        CreateExtension('vector'),
    ]