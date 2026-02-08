from django.db import models
from django.utils import timezone
import uuid


class ApiAccessToken(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100)
    token = models.CharField(max_length=255, unique=True, db_index=True)
    is_active = models.BooleanField(default=True)
    expires_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "API токен"
        verbose_name_plural = "API токены"
        ordering = ['-created_at']

    def is_valid(self) -> bool:
        return self.is_active and self.expires_at > timezone.now()
