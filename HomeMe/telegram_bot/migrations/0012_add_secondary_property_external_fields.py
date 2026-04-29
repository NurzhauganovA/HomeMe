from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0011_add_favorite_property'),
    ]

    operations = [
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
    ]
