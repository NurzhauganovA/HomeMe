# Squashed migrations 0002–0019 (один файл для Docker/сервера)
# Если таблицы уже есть: python manage.py migrate telegram_bot 0002_squashed_schema --fake

import secrets

import django.db.models.deletion
import pgvector.django.vector
import uuid
from django.contrib.postgres.operations import CreateExtension
from django.db import migrations, models


def fill_referral_codes(apps, schema_editor):
    BotUser = apps.get_model('telegram_bot', 'BotUser')
    for u in BotUser.objects.all():
        if u.referral_code:
            continue
        for _ in range(30):
            code = secrets.token_hex(4).upper()
            if not BotUser.objects.filter(referral_code=code).exists():
                u.referral_code = code
                u.save(update_fields=['referral_code'])
                break


class Migration(migrations.Migration):

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
        ('dashboard', '0002_permission_role'),
    ]

    operations = [
        # --- 0002_bicomplex_biunit.py ---
        migrations.CreateModel(
            name='BIComplex',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('bi_uuid', models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID из API')),
                ('name', models.CharField(max_length=255, verbose_name='Название ЖК')),
                ('address', models.CharField(blank=True, max_length=500, verbose_name='Адрес')),
                ('city_uuid', models.CharField(db_index=True, max_length=100, verbose_name='UUID Города')),
                ('latitude', models.FloatField(blank=True, null=True, verbose_name='Широта')),
                ('longitude', models.FloatField(blank=True, null=True, verbose_name='Долгота')),
                ('class_name', models.CharField(blank=True, max_length=100, verbose_name='Класс жилья')),
                ('deadline', models.CharField(blank=True, max_length=50, verbose_name='Срок сдачи')),
                ('min_price', models.DecimalField(decimal_places=2, max_digits=15, null=True, verbose_name='Цена от')),
                ('website', models.URLField(blank=True)),
                ('image_url', models.URLField(blank=True, verbose_name='Фото 400px')),
                ('features', models.JSONField(default=dict, verbose_name='AI Теги')),
                ('embedding', pgvector.django.vector.VectorField(blank=True, dimensions=768, null=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'ЖК',
                'verbose_name_plural': 'ЖК',
                'db_table': 'bi_complexes',
            },
        ),
        migrations.CreateModel(
            name='BIUnit',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('bi_uuid', models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID Квартиры')),
                ('room_count', models.IntegerField(db_index=True, verbose_name='Комнат')),
                ('floor', models.IntegerField(verbose_name='Этаж')),
                ('max_floor', models.IntegerField(null=True, verbose_name='Всего этажей')),
                ('area', models.FloatField(verbose_name='Площадь')),
                ('price', models.DecimalField(decimal_places=2, max_digits=15, verbose_name='Базовая цена')),
                ('price_discount', models.DecimalField(decimal_places=2, max_digits=15, null=True, verbose_name='Цена со скидкой')),
                ('block_name', models.CharField(blank=True, max_length=100, verbose_name='Блок/Секция')),
                ('deadline', models.CharField(blank=True, max_length=50, verbose_name='Срок сдачи секции')),
                ('is_active', models.BooleanField(default=True)),
                ('complex', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='units', to='telegram_bot.bicomplex')),
            ],
            options={
                'verbose_name': 'Квартира в ЖК',
                'verbose_name_plural': 'Квартиры в ЖК',
                'db_table': 'bi_units',
                'indexes': [models.Index(fields=['price_discount', 'room_count'], name='bi_units_price_d_3c0521_idx'), models.Index(fields=['area'], name='bi_units_area_f1eed0_idx')],
            },
        ),
        # --- 0003_enable_pgvector.py ---
        CreateExtension('vector'),
        # --- 0005_rename_website_bicomplex_url_bicomplex_description_and_more.py ---
        migrations.RenameField(
            model_name='bicomplex',
            old_name='website',
            new_name='url',
        ),
        migrations.AddField(
            model_name='bicomplex',
            name='description',
            field=models.TextField(blank=True),
        ),
        migrations.AddField(
            model_name='usersession',
            name='state',
            field=models.CharField(default='START', max_length=50),
        ),
        # --- 0006_bicommercialcomplex_bicommercialunit.py ---
        migrations.CreateModel(
            name='BICommercialComplex',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('bi_uuid', models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID из API')),
                ('name', models.CharField(max_length=255, verbose_name='Название объекта')),
                ('address', models.CharField(blank=True, max_length=500, verbose_name='Адрес')),
                ('description', models.TextField(blank=True)),
                ('latitude', models.FloatField(blank=True, null=True, verbose_name='Широта')),
                ('longitude', models.FloatField(blank=True, null=True, verbose_name='Долгота')),
                ('city_uuid', models.CharField(db_index=True, max_length=100, verbose_name='UUID Города')),
                ('class_name', models.CharField(blank=True, max_length=100, verbose_name='Класс')),
                ('deadline', models.CharField(blank=True, max_length=50, verbose_name='Срок сдачи')),
                ('min_price', models.DecimalField(decimal_places=2, max_digits=15, null=True, verbose_name='Цена от')),
                ('url', models.URLField(blank=True)),
                ('image_url', models.URLField(blank=True, verbose_name='Фото 400px')),
                ('features', models.JSONField(default=dict, verbose_name='AI Теги')),
                ('embedding', pgvector.django.vector.VectorField(blank=True, dimensions=768, null=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Коммерческий объект',
                'verbose_name_plural': 'Коммерческие объекты',
                'db_table': 'bi_commercial_complexes',
            },
        ),
        migrations.CreateModel(
            name='BICommercialUnit',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('bi_uuid', models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID объекта')),
                ('room_count', models.IntegerField(db_index=True, verbose_name='Комнат')),
                ('floor', models.IntegerField(verbose_name='Этаж')),
                ('max_floor', models.IntegerField(null=True, verbose_name='Всего этажей')),
                ('area', models.FloatField(verbose_name='Площадь')),
                ('price', models.DecimalField(decimal_places=2, max_digits=15, verbose_name='Базовая цена')),
                ('price_discount', models.DecimalField(decimal_places=2, max_digits=15, null=True, verbose_name='Цена со скидкой')),
                ('block_name', models.CharField(blank=True, max_length=100, verbose_name='Блок/Секция')),
                ('deadline', models.CharField(blank=True, max_length=50, verbose_name='Срок сдачи секции')),
                ('is_active', models.BooleanField(default=True)),
                ('complex', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='units', to='telegram_bot.bicommercialcomplex')),
            ],
            options={
                'verbose_name': 'Коммерческое помещение',
                'verbose_name_plural': 'Коммерческие помещения',
                'db_table': 'bi_commercial_units',
                'indexes': [
                    models.Index(fields=['price_discount', 'room_count'], name='bi_commercial_units_price_d_9c4f1e_idx'),
                    models.Index(fields=['area'], name='bi_commercial_units_area_9f8cd5_idx'),
                ],
            },
        ),
        # --- 0007_rename_bi_commercial_units_price_d_9c4f1e_idx_bi_commerci_price_d_227ae2_idx_and_more.py ---
        migrations.RenameIndex(
            model_name='bicommercialunit',
            new_name='bi_commerci_price_d_227ae2_idx',
            old_name='bi_commercial_units_price_d_9c4f1e_idx',
        ),
        migrations.RenameIndex(
            model_name='bicommercialunit',
            new_name='bi_commerci_area_c15c5d_idx',
            old_name='bi_commercial_units_area_9f8cd5_idx',
        ),
        # --- 0008_alter_bicommercialunit_options_and_more.py ---
        migrations.AlterModelOptions(
            name='bicommercialunit',
            options={'verbose_name': 'Офис/Помещение', 'verbose_name_plural': 'Офисы/Помещения'},
        ),
        migrations.AlterModelOptions(
            name='bicomplex',
            options={'verbose_name': 'ЖК (Жилой)', 'verbose_name_plural': 'ЖК (Жилые)'},
        ),
        migrations.AlterModelOptions(
            name='biunit',
            options={'verbose_name': 'Квартира', 'verbose_name_plural': 'Квартиры'},
        ),
        migrations.AlterField(
            model_name='bicommercialcomplex',
            name='image_url',
            field=models.URLField(blank=True, verbose_name='Фото'),
        ),
        migrations.AlterField(
            model_name='bicommercialcomplex',
            name='name',
            field=models.CharField(max_length=255, verbose_name='Название'),
        ),
        migrations.AlterField(
            model_name='bicommercialunit',
            name='bi_uuid',
            field=models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID Юнита'),
        ),
        migrations.AlterField(
            model_name='bicommercialunit',
            name='room_count',
            field=models.IntegerField(db_index=True, verbose_name='Комнат/Помещений'),
        ),
        migrations.AlterField(
            model_name='bicomplex',
            name='class_name',
            field=models.CharField(blank=True, max_length=100, verbose_name='Класс'),
        ),
        migrations.AlterField(
            model_name='bicomplex',
            name='image_url',
            field=models.URLField(blank=True, verbose_name='Фото'),
        ),
        migrations.AlterField(
            model_name='bicomplex',
            name='name',
            field=models.CharField(max_length=255, verbose_name='Название'),
        ),
        migrations.AlterField(
            model_name='biunit',
            name='bi_uuid',
            field=models.CharField(db_index=True, max_length=100, unique=True, verbose_name='UUID Юнита'),
        ),
        migrations.AlterField(
            model_name='biunit',
            name='room_count',
            field=models.IntegerField(db_index=True, verbose_name='Комнат/Помещений'),
        ),
        # --- 0009_add_bi_complex_area_fields.py ---
        migrations.AddField(
            model_name='bicomplex',
            name='min_area',
            field=models.FloatField(blank=True, null=True, verbose_name='Площадь от'),
        ),
        migrations.AddField(
            model_name='bicomplex',
            name='max_area',
            field=models.FloatField(blank=True, null=True, verbose_name='Площадь до'),
        ),
        migrations.AddField(
            model_name='bicommercialcomplex',
            name='min_area',
            field=models.FloatField(blank=True, null=True, verbose_name='Площадь от'),
        ),
        migrations.AddField(
            model_name='bicommercialcomplex',
            name='max_area',
            field=models.FloatField(blank=True, null=True, verbose_name='Площадь до'),
        ),
        # --- 0010_add_photos_to_bi_units.py ---
        migrations.AddField(
            model_name='biunit',
            name='photos',
            field=models.JSONField(blank=True, default=list, verbose_name='Фотографии'),
        ),
        migrations.AddField(
            model_name='bicommercialunit',
            name='photos',
            field=models.JSONField(blank=True, default=list, verbose_name='Фотографии'),
        ),
        # --- 0011_add_favorite_property.py ---
        migrations.CreateModel(
            name='FavoriteProperty',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('source', models.CharField(db_index=True, max_length=20)),
                ('object_kind', models.CharField(db_index=True, max_length=20)),
                ('object_id', models.CharField(db_index=True, max_length=100)),
                ('data', models.JSONField(default=dict)),
                ('created_at', models.DateTimeField(auto_now_add=True, db_index=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='favorites', to='telegram_bot.botuser')),
            ],
            options={
                'verbose_name': 'Избранный объект',
                'verbose_name_plural': 'Избранные объекты',
            },
        ),
        migrations.AddIndex(
            model_name='favoriteproperty',
            index=models.Index(fields=['user', 'source'], name='telegram_bo_user_id_0e55ad_idx'),
        ),
        migrations.AddIndex(
            model_name='favoriteproperty',
            index=models.Index(fields=['object_kind', 'object_id'], name='telegram_bo_object__f0fdb5_idx'),
        ),
        migrations.AddConstraint(
            model_name='favoriteproperty',
            constraint=models.UniqueConstraint(fields=('user', 'object_kind', 'object_id'), name='unique_favorite_object'),
        ),
        # --- 0012_add_secondary_property_external_fields.py ---
        migrations.AddField(
            model_name='secondaryproperty',
            name='external_uuid',
            field=models.CharField(blank=True, db_index=True, max_length=100, null=True, unique=True, verbose_name='Внешний UUID'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='external_id',
            field=models.BigIntegerField(blank=True, db_index=True, null=True, verbose_name='Внешний ID'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='property_type',
            field=models.CharField(blank=True, db_index=True, max_length=50, null=True, verbose_name='Тип объекта'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='deal_type',
            field=models.CharField(blank=True, db_index=True, max_length=50, null=True, verbose_name='Тип сделки'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='condition',
            field=models.CharField(blank=True, max_length=50, null=True, verbose_name='Состояние'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='repair',
            field=models.CharField(blank=True, max_length=50, null=True, verbose_name='Ремонт'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='construction_year',
            field=models.IntegerField(blank=True, null=True, verbose_name='Год постройки'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='material',
            field=models.JSONField(blank=True, default=list, verbose_name='Материал'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='address_note',
            field=models.CharField(blank=True, max_length=500, null=True, verbose_name='Адрес (текст)'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='source_url',
            field=models.URLField(blank=True, verbose_name='Источник'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='photos',
            field=models.JSONField(blank=True, default=list, verbose_name='Фотографии'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='raw_data',
            field=models.JSONField(blank=True, default=dict, verbose_name='Raw данные'),
        ),
        # --- 0013_rename_telegram_bo_user_id_0e55ad_idx_telegram_bo_user_id_8abea6_idx_and_more.py ---
        migrations.RenameIndex(
            model_name='favoriteproperty',
            new_name='telegram_bo_user_id_8abea6_idx',
            old_name='telegram_bo_user_id_0e55ad_idx',
        ),
        migrations.RenameIndex(
            model_name='favoriteproperty',
            new_name='telegram_bo_object__14e271_idx',
            old_name='telegram_bo_object__f0fdb5_idx',
        ),
        # --- 0014_secondaryproperty_area_kitchen_and_more.py ---
        migrations.AddField(
            model_name='secondaryproperty',
            name='area_kitchen',
            field=models.FloatField(blank=True, null=True, verbose_name='Площадь кухни'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='area_living',
            field=models.FloatField(blank=True, null=True, verbose_name='Жилая площадь'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='ceiling_height',
            field=models.FloatField(blank=True, null=True, verbose_name='Высота потолка'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='city_micro_district',
            field=models.CharField(blank=True, max_length=100, null=True, verbose_name='Микрорайон'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='currency',
            field=models.CharField(blank=True, max_length=10, null=True, verbose_name='Валюта'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='coordinates_source',
            field=models.CharField(blank=True, max_length=20, null=True, verbose_name='Источник координат'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='prices',
            field=models.JSONField(blank=True, default=dict, verbose_name='Цены по валютам'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='prices_m2',
            field=models.JSONField(blank=True, default=dict, verbose_name='Цена за м² по валютам'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='rent_type',
            field=models.CharField(blank=True, max_length=50, null=True, verbose_name='Тип аренды'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='rooms_total',
            field=models.IntegerField(blank=True, null=True, verbose_name='Всего комнат (источник)'),
        ),
        migrations.AddField(
            model_name='secondaryproperty',
            name='subtype',
            field=models.CharField(blank=True, max_length=100, null=True, verbose_name='Подтип объекта'),
        ),
        # --- 0015_botuser_role_botuser_username.py ---
        migrations.AddField(
            model_name='botuser',
            name='role',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='bot_users', to='dashboard.role', verbose_name='Роль'),
        ),
        migrations.AddField(
            model_name='botuser',
            name='username',
            field=models.CharField(blank=True, db_index=True, help_text='Telegram @username без символа @', max_length=100, null=True, verbose_name='Username'),
        ),
        # --- 0016_dailyusagelog.py ---
        migrations.CreateModel(
            name='DailyUsageLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField(db_index=True, verbose_name='Дата')),
                ('objects_shown', models.IntegerField(default=0, verbose_name='Объектов показано (итого)')),
                ('apartments_shown', models.IntegerField(default=0, verbose_name='Квартир показано')),
                ('commercial_shown', models.IntegerField(default=0, verbose_name='Коммерческих показано')),
                ('primary_shown', models.IntegerField(default=0, verbose_name='Первичного рынка показано')),
                ('secondary_shown', models.IntegerField(default=0, verbose_name='Вторичного рынка показано')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='daily_usage', to='telegram_bot.botuser', verbose_name='Пользователь')),
            ],
            options={
                'verbose_name': 'Суточная статистика выдачи',
                'verbose_name_plural': 'Суточная статистика выдачи',
                'ordering': ['-date'],
                'indexes': [models.Index(fields=['user', 'date'], name='telegram_bo_user_id_fa600b_idx')],
                'unique_together': {('user', 'date')},
            },
        ),
        # --- 0017_dailyusagelog_bonus_limit_daily.py ---
        migrations.AddField(
            model_name='dailyusagelog',
            name='bonus_limit_daily',
            field=models.IntegerField(default=0, verbose_name='Бонус к суточному лимиту'),
        ),
        # --- 0018_botproductevent_lead_analytics_referral.py ---
        migrations.AddField(
            model_name='botuser',
            name='referral_code',
            field=models.CharField(
                blank=True, db_index=True, help_text='Уникальный код для ссылки t.me/bot?start=ref_CODE',
                max_length=32, null=True, unique=True, verbose_name='Реферальный код',
            ),
        ),
        migrations.AddField(
            model_name='botuser',
            name='invited_by',
            field=models.ForeignKey(
                blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL,
                related_name='referrals', to='telegram_bot.botuser', verbose_name='Пригласивший',
            ),
        ),
        migrations.AddField(
            model_name='lead',
            name='budget_display',
            field=models.CharField(blank=True, max_length=160, verbose_name='Бюджет (текст)'),
        ),
        migrations.AddField(
            model_name='lead',
            name='developer',
            field=models.CharField(blank=True, max_length=120, verbose_name='Застройщик'),
        ),
        migrations.AddField(
            model_name='lead',
            name='district',
            field=models.CharField(blank=True, max_length=120, verbose_name='Район'),
        ),
        migrations.AddField(
            model_name='lead',
            name='lead_source',
            field=models.CharField(
                blank=True, db_index=True, help_text='expert_request, bi_primary_contact и т.п.',
                max_length=40, verbose_name='Источник лида',
            ),
        ),
        migrations.AddField(
            model_name='lead',
            name='market_type_label',
            field=models.CharField(blank=True, max_length=80, verbose_name='Тип рынка'),
        ),
        migrations.AddField(
            model_name='lead',
            name='property_type_label',
            field=models.CharField(blank=True, max_length=80, verbose_name='Тип недвижимости'),
        ),
        migrations.AddField(
            model_name='lead',
            name='residential_complex',
            field=models.CharField(blank=True, max_length=255, verbose_name='ЖК / объект'),
        ),
        migrations.CreateModel(
            name='BotProductEvent',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('event_type', models.CharField(db_index=True, max_length=40, verbose_name='Тип события')),
                ('payload', models.JSONField(blank=True, default=dict, verbose_name='Данные')),
                ('property_type', models.CharField(
                    blank=True, db_index=True, help_text='apartments / commercial / mixed',
                    max_length=32, verbose_name='Тип недвижимости',
                )),
                ('market_type', models.CharField(
                    blank=True, db_index=True, help_text='primary / secondary / mixed',
                    max_length=32, verbose_name='Тип рынка',
                )),
                ('created_at', models.DateTimeField(auto_now_add=True, db_index=True)),
                ('user', models.ForeignKey(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='product_events', to='telegram_bot.botuser', verbose_name='Пользователь',
                )),
            ],
            options={
                'verbose_name': 'Событие аналитики',
                'verbose_name_plural': 'События аналитики',
                'ordering': ['-created_at'],
            },
        ),
        migrations.AddIndex(
            model_name='botproductevent',
            index=models.Index(fields=['event_type', '-created_at'], name='telegram_bo_event_t_idx'),
        ),
        migrations.AddIndex(
            model_name='botproductevent',
            index=models.Index(fields=['user', '-created_at'], name='telegram_bo_pe_user_dt_idx'),
        ),
        migrations.RunPython(fill_referral_codes, migrations.RunPython.noop),
        # --- 0019_secondaryproperty_public_description.py ---
        migrations.AddField(
            model_name='secondaryproperty',
            name='public_description',
            field=models.TextField(
                blank=True,
                help_text='Публичный текст для ILVO (public_description); может быть пустым',
                verbose_name='Описание для рекламы',
            ),
        ),
        migrations.AlterField(
            model_name='secondaryproperty',
            name='description',
            field=models.TextField(
                blank=True,
                help_text='Для сотрудников; в API ILVO уходит как description',
                verbose_name='Внутреннее описание',
            ),
        )
    ]
