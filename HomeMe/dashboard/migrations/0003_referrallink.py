import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0002_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='ReferralLink',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, verbose_name='Название')),
                ('code', models.CharField(db_index=True, help_text='Используется в t.me/bot?start=ref_CODE', max_length=32, unique=True, verbose_name='Код ссылки')),
                ('is_active', models.BooleanField(db_index=True, default=True, verbose_name='Активна')),
                ('notes', models.TextField(blank=True, verbose_name='Заметки')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('role', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='referral_links', to='dashboard.role', verbose_name='Роль (пакет)')),
            ],
            options={
                'verbose_name': 'Реферальная ссылка',
                'verbose_name_plural': 'Реферальные ссылки',
                'ordering': ['-created_at'],
            },
        ),
    ]
