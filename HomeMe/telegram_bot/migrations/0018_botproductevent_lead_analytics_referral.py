# Generated manually for TZ HomeMe (analytics, leads, referrals)

import secrets

from django.db import migrations, models
import django.db.models.deletion


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

    dependencies = [
        ('telegram_bot', '0017_dailyusagelog_bonus_limit_daily'),
    ]

    operations = [
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
    ]
