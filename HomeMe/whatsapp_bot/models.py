from django.db import models


class WhatsAppUser(models.Model):
    phone_number = models.CharField(max_length=20, unique=True, verbose_name="Номер WhatsApp")
    name = models.CharField(max_length=100, null=True, blank=True, verbose_name="Имя")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Первый контакт")
    updated_at = models.DateTimeField(auto_now=True)

    # Для будущей логики состояний (FSM)
    # state = models.CharField(...) 

    def __str__(self):
        return f"{self.name or 'Без имени'} ({self.phone_number})"

    class Meta:
        verbose_name = "Пользователь WhatsApp"
        verbose_name_plural = "Пользователи WhatsApp"