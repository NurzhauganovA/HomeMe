"""
Dashboard Forms
Формы для админ-панели с использованием crispy-forms
"""

import re

from django import forms
from telegram_bot.models import SecondaryProperty, Lead, BotUser
from .models import Role, Permission, ReferralLink
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Row, Column, Submit, Div, Field


class SecondaryPropertyForm(forms.ModelForm):
    """Форма для создания/редактирования объектов вторички"""

    class Meta:
        model = SecondaryProperty
        fields = [
            'title', 'description', 'public_description', 'address', 'city', 'district',
            'price', 'rooms', 'area', 'floor', 'total_floors',
            'latitude', 'longitude',
            'owner_phone', 'owner_name',
            'has_parking', 'has_balcony', 'has_renovation',
            'image', 'is_active', 'is_verified'
        ]
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4, 'placeholder': 'Внутреннее — только для сотрудников'}),
            'public_description': forms.Textarea(attrs={'rows': 4, 'placeholder': 'Для рекламы и ILVO'}),
            'address': forms.TextInput(attrs={'placeholder': 'ул. Достык, 123'}),
            'title': forms.TextInput(attrs={'placeholder': '3-комн квартира в центре'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.form_enctype = 'multipart/form-data'

        self.helper.layout = Layout(
            Div(
                Row(
                    Column('title', css_class='col-md-8'),
                    Column('city', css_class='col-md-4'),
                ),
                'description',
                'public_description',
                Row(
                    Column('address', css_class='col-md-8'),
                    Column('district', css_class='col-md-4'),
                ),
                css_class='card-body'
            ),

            Div(
                Row(
                    Column('price', css_class='col-md-3'),
                    Column('rooms', css_class='col-md-3'),
                    Column('area', css_class='col-md-3'),
                    Column('floor', css_class='col-md-3'),
                ),
                Row(
                    Column('total_floors', css_class='col-md-4'),
                    Column('latitude', css_class='col-md-4'),
                    Column('longitude', css_class='col-md-4'),
                ),
                css_class='card-body'
            ),

            Div(
                Row(
                    Column('owner_name', css_class='col-md-6'),
                    Column('owner_phone', css_class='col-md-6'),
                ),
                css_class='card-body'
            ),

            Div(
                Row(
                    Column('has_parking', css_class='col-md-4'),
                    Column('has_balcony', css_class='col-md-4'),
                    Column('has_renovation', css_class='col-md-4'),
                ),
                Row(
                    Column('is_active', css_class='col-md-6'),
                    Column('is_verified', css_class='col-md-6'),
                ),
                css_class='card-body'
            ),

            Div(
                'image',
                css_class='card-body'
            ),

            Div(
                Submit('submit', 'Сохранить', css_class='btn btn-primary btn-lg'),
                css_class='card-body text-end'
            )
        )

        # Кастомизация полей
        self.fields['price'].widget.attrs.update({'min': '0', 'step': '100000'})
        self.fields['rooms'].widget.attrs.update({'min': '0', 'max': '10'})
        self.fields['area'].widget.attrs.update({'min': '0', 'step': '0.1'})
        self.fields['floor'].widget.attrs.update({'min': '0'})
        self.fields['total_floors'].widget.attrs.update({'min': '1'})


class RoleForm(forms.ModelForm):
    """Форма создания/редактирования роли с конструктором разрешений"""

    permissions = forms.ModelMultipleChoiceField(
        queryset=Permission.objects.all().order_by('category', 'name'),
        widget=forms.CheckboxSelectMultiple,
        required=False,
        label="Разрешения"
    )

    class Meta:
        model = Role
        fields = [
            'name', 'description', 'is_active', 'permissions',
            'limit_total_daily', 'limit_apartments_daily',
            'limit_commercial_daily', 'limit_primary_daily', 'limit_secondary_daily',
        ]
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in ['limit_total_daily', 'limit_apartments_daily',
                      'limit_commercial_daily', 'limit_primary_daily', 'limit_secondary_daily']:
            self.fields[field].widget.attrs.update({'min': '0', 'class': 'form-control'})


class AssignRoleForm(forms.Form):
    """Форма назначения роли пользователю бота"""

    role = forms.ModelChoiceField(
        queryset=Role.objects.filter(is_active=True),
        required=False,
        empty_label="— Без роли —",
        label="Роль"
    )


class ReferralLinkForm(forms.ModelForm):
    """Форма создания/редактирования админской реферальной ссылки."""

    class Meta:
        model = ReferralLink
        fields = ['name', 'code', 'role', 'is_active', 'notes']
        widgets = {
            'notes': forms.Textarea(attrs={'rows': 3, 'placeholder': 'Источник, канал, комментарий...'}),
            'code': forms.TextInput(attrs={'placeholder': 'Оставьте пустым для автогенерации', 'style': 'text-transform: uppercase;'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['role'].queryset = Role.objects.filter(is_active=True).order_by('name')
        self.fields['code'].required = False
        self.fields['code'].help_text = 'Уникальный код для ссылки t.me/bot?start=ref_CODE. Если пусто — сгенерируется автоматически.'

        for name, field in self.fields.items():
            if isinstance(field.widget, forms.CheckboxInput):
                field.widget.attrs.setdefault('class', 'form-check-input')
            elif isinstance(field.widget, forms.Select):
                field.widget.attrs.setdefault('class', 'form-select')
            else:
                field.widget.attrs.setdefault('class', 'form-control')

    def clean_code(self):
        code = (self.cleaned_data.get('code') or '').strip().upper()
        if not code and not self.instance.pk:
            return code
        if not code and self.instance.pk:
            return self.instance.code
        if not re.match(r'^[A-Z0-9]{4,32}$', code):
            raise forms.ValidationError('Код: только латиница и цифры, от 4 до 32 символов.')

        qs_user = BotUser.objects.filter(referral_code__iexact=code)
        qs_link = ReferralLink.objects.filter(code__iexact=code)
        if self.instance.pk:
            qs_link = qs_link.exclude(pk=self.instance.pk)
        if qs_user.exists() or qs_link.exists():
            raise forms.ValidationError('Этот код уже используется.')
        return code

    def save(self, commit=True):
        instance = super().save(commit=False)
        if not instance.code:
            from core.services import referral_service
            instance.code = referral_service.generate_campaign_code()
        if commit:
            instance.save()
            self.save_m2m()
        return instance


class LeadUpdateForm(forms.ModelForm):
    """Форма для обновления лида"""

    class Meta:
        model = Lead
        fields = ['status', 'assigned_to', 'priority', 'manager_notes']
        widgets = {
            'manager_notes': forms.Textarea(attrs={'rows': 4}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'

        self.helper.layout = Layout(
            Row(
                Column('status', css_class='col-md-6'),
                Column('assigned_to', css_class='col-md-6'),
            ),
            Row(
                Column('priority', css_class='col-md-12'),
            ),
            'manager_notes',
            Submit('submit', 'Обновить лид', css_class='btn btn-success mt-3')
        )

        # Подсказки
        self.fields['assigned_to'].widget.attrs.update({
            'placeholder': 'Имя менеджера'
        })
        self.fields['manager_notes'].widget.attrs.update({
            'placeholder': 'Комментарии по работе с клиентом...'
        })