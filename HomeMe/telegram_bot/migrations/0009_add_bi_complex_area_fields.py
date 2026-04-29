from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0008_alter_bicommercialunit_options_and_more'),
    ]

    operations = [
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
    ]
