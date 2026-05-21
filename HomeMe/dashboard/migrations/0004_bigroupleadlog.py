from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0003_feedbacksurvey_bottext_feedbacksurveyquestion_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='BIGroupLeadLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phone', models.CharField(blank=True, db_index=True, max_length=30, verbose_name='Телефон')),
                ('name', models.CharField(blank=True, max_length=150, verbose_name='Имя')),
                ('complex_uuid', models.CharField(blank=True, db_index=True, max_length=100, verbose_name='UUID ЖК')),
                ('complex_name', models.CharField(blank=True, max_length=255, verbose_name='Название ЖК')),
                ('source', models.CharField(blank=True, max_length=50, verbose_name='Источник')),
                ('comment', models.TextField(blank=True, verbose_name='Комментарий')),
                ('meta', models.JSONField(blank=True, default=dict, verbose_name='Мета (TG username/ID)')),
                ('success', models.BooleanField(db_index=True, default=False, verbose_name='Успешно')),
                ('error_message', models.TextField(blank=True, verbose_name='Ошибка')),
                ('response_data', models.JSONField(blank=True, default=dict, verbose_name='Ответ API')),
                ('created_at', models.DateTimeField(auto_now_add=True, db_index=True)),
            ],
            options={
                'verbose_name': 'Лог лидов BI Group CRM',
                'verbose_name_plural': 'Логи лидов BI Group CRM',
                'ordering': ['-created_at'],
            },
        ),
        migrations.AddIndex(
            model_name='bigroupleadlog',
            index=models.Index(fields=['success', '-created_at'], name='dashboard_b_success_idx'),
        ),
    ]
