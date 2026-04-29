from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0009_add_bi_complex_area_fields'),
    ]

    operations = [
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
    ]
