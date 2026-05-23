# ILVO: разделение внутреннего и рекламного описания

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0018_botproductevent_lead_analytics_referral'),
    ]

    operations = [
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
        ),
    ]
