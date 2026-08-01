import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0002_initial'),
        ('dashboard', '0003_referrallink'),
    ]

    operations = [
        migrations.AddField(
            model_name='botuser',
            name='referral_link',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='registered_users', to='dashboard.referrallink', verbose_name='Реферальная ссылка (кампания)'),
        ),
    ]
