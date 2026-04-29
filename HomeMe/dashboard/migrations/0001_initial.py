from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name='ApiAccessToken',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=100)),
                ('token', models.CharField(db_index=True, max_length=255, unique=True)),
                ('is_active', models.BooleanField(default=True)),
                ('expires_at', models.DateTimeField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'verbose_name': 'API токен',
                'verbose_name_plural': 'API токены',
                'ordering': ['-created_at'],
            },
        ),
    ]
