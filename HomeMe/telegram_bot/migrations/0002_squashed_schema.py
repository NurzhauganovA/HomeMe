# Схема telegram_bot в PostgreSQL (pgAdmin), не через migrate.
# Модели с managed=False. Здесь только пометка в django_migrations и данные.

import secrets

from django.db import migrations


def fill_referral_codes(apps, schema_editor):
    with schema_editor.connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'telegram_bot_botuser'
              AND column_name = 'referral_code'
            """
        )
        if not cursor.fetchone():
            return

    BotUser = apps.get_model('telegram_bot', 'BotUser')
    for u in BotUser.objects.all():
        if getattr(u, 'referral_code', None):
            continue
        for _ in range(30):
            code = secrets.token_hex(4).upper()
            if not BotUser.objects.filter(referral_code=code).exists():
                u.referral_code = code
                u.save(update_fields=['referral_code'])
                break


class Migration(migrations.Migration):
    """
    Заменяет 0002–0019. Не создаёт таблицы (см. scripts/sql/telegram_bot_pgadmin.sql).
    """

    replaces = [
        ('telegram_bot', '0002_bicomplex_biunit'),
        ('telegram_bot', '0003_enable_pgvector'),
        ('telegram_bot', '0005_rename_website_bicomplex_url_bicomplex_description_and_more'),
        ('telegram_bot', '0006_bicommercialcomplex_bicommercialunit'),
        ('telegram_bot', '0007_rename_bi_commercial_units_price_d_9c4f1e_idx_bi_commerci_price_d_227ae2_idx_and_more'),
        ('telegram_bot', '0008_alter_bicommercialunit_options_and_more'),
        ('telegram_bot', '0009_add_bi_complex_area_fields'),
        ('telegram_bot', '0010_add_photos_to_bi_units'),
        ('telegram_bot', '0011_add_favorite_property'),
        ('telegram_bot', '0012_add_secondary_property_external_fields'),
        ('telegram_bot', '0013_rename_telegram_bo_user_id_0e55ad_idx_telegram_bo_user_id_8abea6_idx_and_more'),
        ('telegram_bot', '0014_secondaryproperty_area_kitchen_and_more'),
        ('telegram_bot', '0015_botuser_role_botuser_username'),
        ('telegram_bot', '0016_dailyusagelog'),
        ('telegram_bot', '0017_dailyusagelog_bonus_limit_daily'),
        ('telegram_bot', '0018_botproductevent_lead_analytics_referral'),
        ('telegram_bot', '0019_secondaryproperty_public_description'),
    ]

    dependencies = [
        ('telegram_bot', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(name='botuser', options={'managed': False}),
        migrations.AlterModelOptions(name='usersession', options={'managed': False}),
        migrations.AlterModelOptions(name='lead', options={'managed': False}),
        migrations.AlterModelOptions(name='secondaryproperty', options={'managed': False}),
        migrations.AlterModelOptions(name='searchlog', options={'managed': False}),
        migrations.AlterModelOptions(name='userfeedback', options={'managed': False}),
        migrations.RunPython(fill_referral_codes, migrations.RunPython.noop),
    ]
