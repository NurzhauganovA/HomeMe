from django.db import migrations, models
import django.db.models.deletion
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0010_add_photos_to_bi_units'),
    ]

    operations = [
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
    ]
