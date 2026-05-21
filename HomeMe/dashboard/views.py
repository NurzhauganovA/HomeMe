from django.views.generic import TemplateView, ListView, CreateView, UpdateView, DeleteView, View, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.shortcuts import redirect, get_object_or_404
from django.contrib import messages
from django.urls import reverse_lazy
from django.db.models import Q, Count, Min, Max
from django.db.models.functions import TruncDate

from telegram_bot.models import Lead, SecondaryProperty, BIComplex, BotUser, BIUnit, BICommercialComplex, BICommercialUnit, DailyUsageLog, BotProductEvent, FavoriteProperty
from .models import ApiAccessToken, Role, Permission, FeedbackSurvey, FeedbackSurveyQuestion, BotText, BIGroupLeadLog
from datetime import timedelta
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.core.paginator import Paginator, InvalidPage
import json
import os
import time
import logging
from logging.handlers import TimedRotatingFileHandler
import uuid
import gzip
import shutil

from django.db import models

from core.services.secondary_importer import SecondaryImporter
from .forms import SecondaryPropertyForm, LeadUpdateForm, RoleForm, AssignRoleForm
from django.conf import settings
from core.services.survey_service import SurveyService

# --- Dedicated integration logger (ILVO secondary import) ---
# Помещаем логи строго в <BASE_DIR>/logs/integrations
_BASE_DIR = getattr(settings, 'BASE_DIR', os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))
_INTEGRATION_LOG_DIR = os.path.join(_BASE_DIR, 'logs', 'integrations')
os.makedirs(_INTEGRATION_LOG_DIR, exist_ok=True)

# Настройки логирования интеграции (можно переопределить в settings.py)
_LOG_MAX_BODY = int(getattr(settings, 'INTEGRATION_LOG_MAX_BODY', 64 * 1024))  # 64KB
_LOG_HEADERS = bool(getattr(settings, 'INTEGRATION_LOG_HEADERS', True))
_LOG_SUCCESS_BODY = bool(getattr(settings, 'INTEGRATION_LOG_SUCCESS_BODY', True))
_LOG_BACKUP_COUNT = int(getattr(settings, 'INTEGRATION_LOG_BACKUP_COUNT', 7))

ilvo_logger = logging.getLogger('integrations.ilvo_secondary')
if not ilvo_logger.handlers:
    ilvo_logger.setLevel(logging.INFO)
    log_file = os.path.join(_INTEGRATION_LOG_DIR, 'ilvo_secondary.log')
    handler = TimedRotatingFileHandler(log_file, when='midnight', backupCount=_LOG_BACKUP_COUNT, encoding='utf-8', utc=False)

    # Сжатие архивов в .gz после ротации
    def _gzip_namer(default_name):
        return default_name + ".gz"

    def _gzip_rotator(source, dest):
        with open(source, 'rb') as sf, gzip.open(dest, 'wb') as df:
            shutil.copyfileobj(sf, df)
        try:
            os.remove(source)
        except Exception:
            pass

    handler.namer = _gzip_namer
    handler.rotator = _gzip_rotator
    formatter = logging.Formatter(
        '%(asctime)s | %(levelname)s | %(message)s'
    )
    handler.setFormatter(formatter)
    ilvo_logger.addHandler(handler)
    ilvo_logger.propagate = False

class StaffRequiredMixin(LoginRequiredMixin, UserPassesTestMixin):
    """Миксин для проверки прав доступа (только staff)"""
    login_url = '/admin/login/'

    def test_func(self):
        return self.request.user.is_staff


class DashboardIndexView(StaffRequiredMixin, TemplateView):
    """Управленческий дашборд (ТЗ п.5) + фильтры."""

    template_name = 'dashboard/index.html'

    def _parse_date_range(self):
        today = timezone.localdate()
        default_from = today - timedelta(days=30)
        df = self.request.GET.get('date_from') or default_from.isoformat()
        dt = self.request.GET.get('date_to') or today.isoformat()
        try:
            date_from = timezone.datetime.fromisoformat(df).date()
        except ValueError:
            date_from = default_from
        try:
            date_to = timezone.datetime.fromisoformat(dt).date()
        except ValueError:
            date_to = today
        if date_from > date_to:
            date_from, date_to = date_to, date_from
        start_dt = timezone.make_aware(timezone.datetime.combine(date_from, timezone.datetime.min.time()))
        end_dt = timezone.make_aware(timezone.datetime.combine(date_to, timezone.datetime.max.time()))
        return date_from, date_to, start_dt, end_dt

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        date_from, date_to, start_dt, end_dt = self._parse_date_range()

        role_id = self.request.GET.get('role') or ''
        platform = self.request.GET.get('platform') or ''
        prop_type = self.request.GET.get('property_type') or ''
        market_type = self.request.GET.get('market_type') or ''

        users_qs = BotUser.objects.filter(created_at__lte=end_dt)
        events_qs = BotProductEvent.objects.filter(created_at__range=(start_dt, end_dt))
        leads_qs = Lead.objects.filter(created_at__range=(start_dt, end_dt))
        fav_qs = FavoriteProperty.objects.filter(created_at__range=(start_dt, end_dt))
        bi_leads_qs = BIGroupLeadLog.objects.filter(created_at__range=(start_dt, end_dt))

        if role_id.isdigit():
            users_qs = users_qs.filter(role_id=int(role_id))
            events_qs = events_qs.filter(user__role_id=int(role_id))
            leads_qs = leads_qs.filter(user__role_id=int(role_id))
            fav_qs = fav_qs.filter(user__role_id=int(role_id))
        if platform:
            users_qs = users_qs.filter(platform=platform)
            events_qs = events_qs.filter(user__platform=platform)
            leads_qs = leads_qs.filter(user__platform=platform)
            fav_qs = fav_qs.filter(user__platform=platform)
        if prop_type:
            events_qs = events_qs.filter(property_type=prop_type)
        if market_type:
            events_qs = events_qs.filter(market_type=market_type)

        new_users = users_qs.filter(created_at__range=(start_dt, end_dt)).count()
        active_users = users_qs.filter(last_active_at__range=(start_dt, end_dt)).distinct().count()

        search_events = events_qs.filter(event_type=BotProductEvent.EVENT_SEARCH).count()
        show_more = events_qs.filter(event_type=BotProductEvent.EVENT_SHOW_MORE).count()
        no_results = events_qs.filter(event_type=BotProductEvent.EVENT_NO_RESULTS).count()
        card_views = events_qs.filter(event_type=BotProductEvent.EVENT_OBJECT_CARD).count()
        favorites = events_qs.filter(event_type=BotProductEvent.EVENT_FAVORITE_ADD).count()
        starts = events_qs.filter(event_type=BotProductEvent.EVENT_BOT_START).count()
        referrals_join = events_qs.filter(event_type='referral_join').count()

        leads_crm = leads_qs.count()
        leads_bi_log = bi_leads_qs.filter(success=True).count()

        context['stats'] = {
            'new_users': new_users,
            'active_users': active_users,
            'searches': search_events,
            'show_more': show_more,
            'no_results': no_results,
            'object_views': card_views,
            'favorites': favorites,
            'bot_starts': starts,
            'referrals_join': referrals_join,
            'leads_total': leads_crm + leads_bi_log,
            'leads_crm': leads_crm,
            'leads_bi_ok': leads_bi_log,
            'new_leads_open': Lead.objects.filter(status='new').count(),
            'active_properties': SecondaryProperty.objects.filter(is_active=True).count(),
            'total_users': BotUser.objects.count(),
            'bi_complexes': BIComplex.objects.count(),
        }

        context['recent_leads'] = Lead.objects.select_related('user').order_by('-created_at')[:8]

        chart_qs = leads_qs.annotate(day=TruncDate('created_at')).values('day').annotate(c=Count('id')).order_by('day')
        context['chart_data'] = [
            {'date': row['day'].strftime('%d.%m') if row['day'] else '', 'count': row['c']}
            for row in chart_qs
        ]
        if not context['chart_data']:
            context['chart_data'] = [{'date': date_from.strftime('%d.%m'), 'count': 0}]

        context['chart_data_json'] = json.dumps(context['chart_data'], ensure_ascii=False)
        context['filter_date_to'] = date_to.isoformat()
        context['filter_role'] = role_id
        context['filter_role_id'] = int(role_id) if role_id.isdigit() else None
        context['filter_platform'] = platform
        context['filter_property_type'] = prop_type
        context['filter_market_type'] = market_type
        context['roles'] = Role.objects.filter(is_active=True).order_by('name')

        # Одноразовые vs возвращающиеся (упрощённо по числу /start за период)
        repeat_users = (
            events_qs.filter(event_type=BotProductEvent.EVENT_BOT_START)
            .values('user_id')
            .annotate(n=Count('id'))
            .filter(n__gte=2)
            .count()
        )
        context['user_behavior'] = {
            'returning_distinct': repeat_users,
        }

        return context


class LeadListView(StaffRequiredMixin, ListView):
    """Список лидов с фильтрацией"""
    model = Lead
    template_name = 'dashboard/lead_list.html'
    context_object_name = 'leads'
    paginate_by = 20

    def get_queryset(self):
        queryset = Lead.objects.select_related('user').order_by('-priority', '-created_at')

        # Фильтр по статусу
        status = self.request.GET.get('status')
        if status:
            queryset = queryset.filter(status=status)

        # Поиск
        search = self.request.GET.get('search')
        if search:
            queryset = queryset.filter(
                Q(user__name__icontains=search) |
                Q(user__user_id__icontains=search) |
                Q(request_text__icontains=search)
            )

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['status_choices'] = Lead.STATUS_CHOICES
        context['current_status'] = self.request.GET.get('status', '')
        context['search_query'] = self.request.GET.get('search', '')
        return context


class LeadDetailView(StaffRequiredMixin, DetailView):
    """Детальная страница лида"""
    model = Lead
    template_name = 'dashboard/lead_detail.html'
    context_object_name = 'lead'


class LeadUpdateView(StaffRequiredMixin, UpdateView):
    """Обновление лида"""
    model = Lead
    form_class = LeadUpdateForm
    template_name = 'dashboard/lead_update.html'
    success_url = reverse_lazy('dashboard:lead_list')

    def form_valid(self, form):
        messages.success(self.request, f'Лид #{self.object.id} успешно обновлен')
        return super().form_valid(form)


class LeadStatusUpdateView(StaffRequiredMixin, View):
    """AJAX обновление статуса лида"""

    def post(self, request, pk):
        lead = get_object_or_404(Lead, pk=pk)
        new_status = request.POST.get('status')

        if new_status in dict(Lead.STATUS_CHOICES):
            lead.status = new_status

            # Автоматические метки времени
            if new_status == 'contacted':
                lead.contacted_at = timezone.now()
            elif new_status == 'closed':
                lead.closed_at = timezone.now()

            lead.save()
            messages.success(request, f'Статус лида изменен на "{lead.get_status_display()}"')
            return JsonResponse({'success': True})

        return JsonResponse({'success': False, 'error': 'Invalid status'}, status=400)


class SecondaryPropertyListView(StaffRequiredMixin, ListView):
    """Список объектов вторички с расширенной фильтрацией"""
    model = SecondaryProperty
    template_name = 'dashboard/secondary_list.html'
    context_object_name = 'properties'
    paginate_by = 12

    def get_queryset(self):
        queryset = SecondaryProperty.objects.filter(is_active=True).order_by('-created_at')

        # Город
        city = self.request.GET.get('city')
        if city:
            queryset = queryset.filter(city=city)

        # Район
        district = self.request.GET.get('district')
        if district:
            queryset = queryset.filter(district=district)

        # Тип недвижимости (property_type из внешней системы)
        property_type = self.request.GET.get('property_type')
        if property_type:
            queryset = queryset.filter(property_type__icontains=property_type)

        # Количество комнат
        rooms = self.request.GET.get('rooms')
        if rooms:
            queryset = queryset.filter(rooms=rooms)

        # Площадь (диапазон)
        area_min = self.request.GET.get('area_min')
        area_max = self.request.GET.get('area_max')
        if area_min:
            queryset = queryset.filter(area__gte=area_min)
        if area_max:
            queryset = queryset.filter(area__lte=area_max)

        # Бюджет (диапазон цен)
        price_min = self.request.GET.get('price_min')
        price_max = self.request.GET.get('price_max')
        if price_min:
            queryset = queryset.filter(price__gte=price_min)
        if price_max:
            queryset = queryset.filter(price__lte=price_max)

        # Статус проверки
        is_verified = self.request.GET.get('is_verified')
        if is_verified == '1':
            queryset = queryset.filter(is_verified=True)
        elif is_verified == '0':
            queryset = queryset.filter(is_verified=False)

        # Поиск по тексту
        search = self.request.GET.get('search')
        if search:
            queryset = queryset.filter(
                Q(title__icontains=search) |
                Q(address__icontains=search) |
                Q(description__icontains=search) |
                Q(owner_name__icontains=search)
            )

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        base_qs = SecondaryProperty.objects.filter(is_active=True)
        context['cities'] = base_qs.values_list('city', flat=True).distinct().order_by('city')
        context['districts'] = base_qs.exclude(district__isnull=True).exclude(district='').values_list(
            'district', flat=True).distinct().order_by('district')
        context['property_types'] = base_qs.exclude(property_type__isnull=True).exclude(property_type='').values_list(
            'property_type', flat=True).distinct().order_by('property_type')
        context['rooms_choices'] = list(range(0, 7))
        agg = base_qs.aggregate(min_price=Min('price'), max_price=Max('price'),
                                min_area=Min('area'), max_area=Max('area'))
        context.update(agg)
        return context


class SecondaryPropertyCreateView(StaffRequiredMixin, CreateView):
    """Создание объекта вторички"""
    model = SecondaryProperty
    form_class = SecondaryPropertyForm
    template_name = 'dashboard/secondary_form.html'
    success_url = reverse_lazy('dashboard:secondary_list')

    def form_valid(self, form):
        messages.success(self.request, 'Объект успешно добавлен')
        return super().form_valid(form)


class SecondaryPropertyUpdateView(StaffRequiredMixin, UpdateView):
    """Редактирование объекта вторички"""
    model = SecondaryProperty
    form_class = SecondaryPropertyForm
    template_name = 'dashboard/secondary_form.html'
    success_url = reverse_lazy('dashboard:secondary_list')

    def form_valid(self, form):
        messages.success(self.request, 'Объект успешно обновлен')
        return super().form_valid(form)


class SecondaryPropertyDeleteView(StaffRequiredMixin, DeleteView):
    """Удаление (деактивация) объекта"""
    model = SecondaryProperty
    success_url = reverse_lazy('dashboard:secondary_list')

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.object.is_active = False
        self.object.save()
        messages.success(request, 'Объект деактивирован')
        return redirect(self.success_url)


class SecondaryPropertyDetailView(StaffRequiredMixin, DetailView):
    """Детальная страница объекта вторички"""
    model = SecondaryProperty
    template_name = 'dashboard/secondary_detail.html'
    context_object_name = 'property'


class BIComplexListView(StaffRequiredMixin, ListView):
    """Список ЖК BI Group с фильтрацией (первичный рынок — квартиры)"""
    model = BIComplex
    template_name = 'dashboard/bi_complex_list.html'
    context_object_name = 'complexes'
    paginate_by = 20

    def get_queryset(self):
        queryset = BIComplex.objects.annotate(
            units_count=Count('units', filter=Q(units__is_active=True))
        ).order_by('-updated_at')

        # Фильтр по городу (city_uuid — но у нас нет name, ищем по address/name)
        search = self.request.GET.get('search')
        if search:
            queryset = queryset.filter(
                Q(name__icontains=search) |
                Q(address__icontains=search) |
                Q(description__icontains=search)
            )

        # Фильтр по диапазону цен
        price_min = self.request.GET.get('price_min')
        price_max = self.request.GET.get('price_max')
        if price_min:
            queryset = queryset.filter(min_price__gte=price_min)
        if price_max:
            queryset = queryset.filter(min_price__lte=price_max)

        # Фильтр по площади (min_area / max_area в комплексе)
        area_min = self.request.GET.get('area_min')
        area_max = self.request.GET.get('area_max')
        if area_min:
            queryset = queryset.filter(max_area__gte=area_min)
        if area_max:
            queryset = queryset.filter(min_area__lte=area_max)

        # Фильтр по классу ЖК
        class_name = self.request.GET.get('class_name')
        if class_name:
            queryset = queryset.filter(class_name__icontains=class_name)

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['total_units'] = BIUnit.objects.filter(is_active=True).count()
        context['class_names'] = BIComplex.objects.exclude(class_name='').values_list(
            'class_name', flat=True).distinct().order_by('class_name')
        return context


class BIComplexDetailView(StaffRequiredMixin, DetailView):
    """Детальная страница ЖК BI Group"""
    model = BIComplex
    template_name = 'dashboard/bi_complex_detail.html'
    context_object_name = 'complex'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        units = BIUnit.objects.filter(complex=self.object, is_active=True).order_by('price')
        aggregates = units.aggregate(
            min_price=Min('price'),
            max_price=Max('price'),
            min_area=Min('area'),
            max_area=Max('area')
        )
        context['units'] = units
        context['units_count'] = units.count()
        context.update(aggregates)
        return context


class BISyncView(StaffRequiredMixin, View):
    """Запуск синхронизации BI Group"""

    def post(self, request):
        try:
            from core.services.bi_syncer import BISyncService

            syncer = BISyncService()
            syncer.run_full_sync()

            messages.success(request, 'Синхронизация успешно завершена')
        except Exception as e:
            messages.error(request, f'Ошибка синхронизации: {str(e)}')

        return redirect('dashboard:bi_complex_list')


class BotUserListView(StaffRequiredMixin, ListView):
    """Список пользователей бота с фильтрацией и управлением ролями"""
    model = BotUser
    template_name = 'dashboard/user_list.html'
    context_object_name = 'users'
    paginate_by = 30

    def get_queryset(self):
        queryset = BotUser.objects.select_related('role').order_by('-last_active_at')

        # Фильтр по платформе
        platform = self.request.GET.get('platform')
        if platform:
            queryset = queryset.filter(platform=platform)

        # Фильтр по роли
        role_id = self.request.GET.get('role')
        if role_id == '0':
            queryset = queryset.filter(role__isnull=True)
        elif role_id:
            queryset = queryset.filter(role_id=role_id)

        # Поиск
        search = self.request.GET.get('search')
        if search:
            queryset = queryset.filter(
                Q(name__icontains=search) |
                Q(user_id__icontains=search) |
                Q(username__icontains=search)
            )

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['platform_choices'] = BotUser.PLATFORM_CHOICES
        context['roles'] = Role.objects.filter(is_active=True)
        context['telegram_users_count'] = BotUser.objects.filter(platform='telegram').count()
        context['whatsapp_users_count'] = BotUser.objects.filter(platform='whatsapp').count()
        context['active_today_count'] = BotUser.objects.filter(
            last_active_at__date=timezone.now().date()
        ).count()
        return context


class BotUserDetailView(StaffRequiredMixin, DetailView):
    """Детальная страница пользователя"""
    model = BotUser
    template_name = 'dashboard/user_detail.html'
    context_object_name = 'bot_user'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user_leads'] = Lead.objects.filter(user=self.object).order_by('-created_at')[:10]
        context['available_roles'] = Role.objects.filter(is_active=True)

        # Суточная статистика выдачи
        today = timezone.now().date()
        today_log = DailyUsageLog.objects.filter(user=self.object, date=today).first()
        context['today_usage'] = today_log
        context['today_date'] = today

        # Лимиты роли
        role = self.object.role
        if role:
            context['role_permissions'] = list(role.permissions.values('codename', 'name'))
            context['role_limits'] = {
                'total': role.limit_total_daily,
                'apartments': role.limit_apartments_daily,
                'commercial': role.limit_commercial_daily,
                'primary': role.limit_primary_daily,
                'secondary': role.limit_secondary_daily,
            }
            used = today_log.objects_shown if today_log else 0
            context['remaining_today'] = max(0, role.limit_total_daily - used)
        else:
            context['role_permissions'] = []
            context['role_limits'] = None
            context['remaining_today'] = None

        # История выдачи (последние 7 дней)
        context['usage_history'] = DailyUsageLog.objects.filter(
            user=self.object
        ).order_by('-date')[:7]

        return context


class RoleListView(StaffRequiredMixin, ListView):
    """Список ролей"""
    model = Role
    template_name = 'dashboard/role_list.html'
    context_object_name = 'roles'

    def get_queryset(self):
        return Role.objects.prefetch_related('permissions').order_by('name')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['total_permissions'] = Permission.objects.count()
        return context


def _permission_groups_context(form):
    """Формирует список групп разрешений с флагами checked для шаблона."""
    selected_ids = set()
    if form.instance.pk:
        selected_ids = set(form.instance.permissions.values_list('id', flat=True))
    # Если форма уже была сабмитнута с ошибками — берём из POST
    if form.data:
        try:
            selected_ids = set(int(v) for v in form.data.getlist('permissions'))
        except (ValueError, AttributeError):
            pass

    groups = []
    icons = {
        'properties': ('fas fa-building', 'text-primary'),
        'market': ('fas fa-store', 'text-success'),
        'bot': ('fas fa-robot', 'text-info'),
        'contacts': ('fas fa-address-book', 'text-warning'),
        'data': ('fas fa-chart-bar', 'text-danger'),
    }
    for cat_code, cat_label in Permission.CATEGORY_CHOICES:
        perms = Permission.objects.filter(category=cat_code)
        if perms.exists():
            icon_class, icon_color = icons.get(cat_code, ('fas fa-circle', 'text-muted'))
            groups.append({
                'label': cat_label,
                'icon': icon_class,
                'icon_color': icon_color,
                'permissions': [
                    {'obj': p, 'checked': p.id in selected_ids}
                    for p in perms
                ]
            })
    return groups


class RoleCreateView(StaffRequiredMixin, CreateView):
    """Создание новой роли"""
    model = Role
    form_class = RoleForm
    template_name = 'dashboard/role_form.html'
    success_url = reverse_lazy('dashboard:role_list')

    def form_valid(self, form):
        messages.success(self.request, f'Роль «{form.instance.name}» успешно создана')
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['permission_groups'] = _permission_groups_context(context['form'])
        context['is_create'] = True
        return context


class RoleUpdateView(StaffRequiredMixin, UpdateView):
    """Редактирование роли"""
    model = Role
    form_class = RoleForm
    template_name = 'dashboard/role_form.html'
    success_url = reverse_lazy('dashboard:role_list')

    def form_valid(self, form):
        messages.success(self.request, f'Роль «{form.instance.name}» успешно обновлена')
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['permission_groups'] = _permission_groups_context(context['form'])
        context['is_create'] = False
        return context


class RoleDeleteView(StaffRequiredMixin, View):
    """Удаление роли"""

    def post(self, request, pk):
        role = get_object_or_404(Role, pk=pk)
        name = role.name
        users_count = role.bot_users.count()
        if users_count > 0:
            messages.error(request, f'Нельзя удалить роль «{name}»: она назначена {users_count} пользователям')
            return redirect('dashboard:role_list')
        role.delete()
        messages.success(request, f'Роль «{name}» удалена')
        return redirect('dashboard:role_list')


class PermissionListView(StaffRequiredMixin, ListView):
    """Список всех разрешений в системе"""
    model = Permission
    template_name = 'dashboard/permission_list.html'
    context_object_name = 'permissions'

    def get_queryset(self):
        return Permission.objects.order_by('category', 'name')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        icons = {
            'properties': ('fas fa-building', 'text-primary'),
            'market': ('fas fa-store', 'text-success'),
            'bot': ('fas fa-robot', 'text-info'),
            'contacts': ('fas fa-address-book', 'text-warning'),
            'data': ('fas fa-chart-bar', 'text-danger'),
        }
        groups = []
        for cat_code, cat_label in Permission.CATEGORY_CHOICES:
            perms = Permission.objects.filter(category=cat_code)
            if perms.exists():
                icon_class, icon_color = icons.get(cat_code, ('fas fa-circle', 'text-muted'))
                groups.append({
                    'label': cat_label,
                    'icon': icon_class,
                    'icon_color': icon_color,
                    'permissions': perms,
                })
        context['permission_groups'] = groups
        return context


class AssignRoleView(StaffRequiredMixin, View):
    """Назначение/изменение роли пользователю бота"""

    def post(self, request, pk):
        user = get_object_or_404(BotUser, pk=pk)
        form = AssignRoleForm(request.POST)
        if form.is_valid():
            role = form.cleaned_data.get('role')
            user.role = role
            user.save(update_fields=['role'])
            if role:
                messages.success(request, f'Роль «{role.name}» назначена пользователю {user.name or user.user_id}')
            else:
                messages.success(request, f'Роль снята с пользователя {user.name or user.user_id}')
        else:
            messages.error(request, 'Ошибка при назначении роли')
        return redirect('dashboard:user_detail', pk=pk)


class SurveyAnalyticsView(StaffRequiredMixin, TemplateView):
    """Аналитика прохождения анкет и ответов."""
    template_name = 'dashboard/survey_analytics.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        survey_id = self.request.GET.get('survey_id')
        try:
            survey_id = int(survey_id) if survey_id else None
        except ValueError:
            survey_id = None

        snapshot = SurveyService.analytics_snapshot(survey_id)

        context['surveys'] = FeedbackSurvey.objects.all().order_by('-updated_at')
        context['selected_survey_id'] = survey_id
        context['snapshot'] = snapshot
        return context


@method_decorator(csrf_exempt, name='dispatch')
class SecondaryImportAPIView(View):
    """
    API endpoint for importing secondary properties from external clients.
    Auth: Authorization: Bearer <token> or X-API-KEY header.
    """
    def post(self, request):
        rid = str(uuid.uuid4())  # Correlation ID for grouping
        started_at = time.time()
        client_ip = request.META.get('HTTP_X_FORWARDED_FOR', request.META.get('REMOTE_ADDR', 'unknown'))
        content_length = request.META.get('CONTENT_LENGTH') or len(request.body or b'')
        query_str = request.META.get('QUERY_STRING', '')
        # Полный дамп хедеров
        try:
            headers_dump = {k: v for k, v in request.headers.items()} if _LOG_HEADERS else {}
        except Exception:
            headers_dump = {}
        # Сырый body (как есть, чтобы видеть точный JSON от клиента)
        try:
            raw_body_full = request.body.decode('utf-8', errors='replace')
            if _LOG_MAX_BODY and len(raw_body_full) > _LOG_MAX_BODY:
                raw_body = raw_body_full[:_LOG_MAX_BODY] + f"\n... [truncated {len(raw_body_full) - _LOG_MAX_BODY} bytes]"
            else:
                raw_body = raw_body_full
        except Exception:
            raw_body = '<failed to decode body>'

        token = self._extract_token(request)
        if not token:
            ilvo_logger.warning(f"RID={rid} | 401 | client={client_ip} | auth=missing | qs='{query_str}' | len={content_length}")
            # Подробности плохого запроса
            ilvo_logger.info(f"RID={rid} | REQ HEADERS: {json.dumps(headers_dump, ensure_ascii=False, default=str)}")
            ilvo_logger.info(f"RID={rid} | REQ BODY: {raw_body}")
            return JsonResponse({'error': 'Unauthorized'}, status=401)

        token_obj = ApiAccessToken.objects.filter(token=token, is_active=True).first()
        if not token_obj or not token_obj.is_valid():
            ilvo_logger.warning(f"RID={rid} | 403 | client={client_ip} | auth=invalid | qs='{query_str}' | len={content_length}")
            ilvo_logger.info(f"RID={rid} | REQ HEADERS: {json.dumps(headers_dump, ensure_ascii=False, default=str)}")
            ilvo_logger.info(f"RID={rid} | REQ BODY: {raw_body}")
            return JsonResponse({'error': 'Invalid or expired token'}, status=403)

        try:
            payload = json.loads(request.body.decode('utf-8'))
        except Exception:
            ilvo_logger.warning(f"RID={rid} | 400 | client={client_ip} | json=parse_error | qs='{query_str}' | len={content_length}")
            ilvo_logger.info(f"RID={rid} | REQ HEADERS: {json.dumps(headers_dump, ensure_ascii=False, default=str)}")
            ilvo_logger.info(f"RID={rid} | REQ BODY: {raw_body}")
            return JsonResponse({'error': 'Invalid JSON body'}, status=400)

        # Логируем валидный запрос полностью (хедеры + сырое тело), включая токены
        if _LOG_HEADERS:
            ilvo_logger.info(f"RID={rid} | REQ HEADERS: {json.dumps(headers_dump, ensure_ascii=False, default=str)}")
        ilvo_logger.info(f"RID={rid} | REQ BODY: {raw_body}")

        do_geocode = request.GET.get('geocode', '1') == '1'
        do_embed = request.GET.get('embed', '1') == '1'

        importer = SecondaryImporter(do_geocode=do_geocode, do_embed=do_embed)
        stats = importer.import_items(payload)

        duration_ms = int((time.time() - started_at) * 1000)
        # Формируем компактное резюме полезной нагрузки
        try:
            if isinstance(payload, list):
                items_info = f"list[{len(payload)}]"
            elif isinstance(payload, dict):
                # Попробуем извлечь id/uuid если есть
                uid = payload.get('uuid') or payload.get('external_uuid') or payload.get('id')
                items_info = f"dict[{uid or '1 item'}]"
            else:
                items_info = type(payload).__name__
        except Exception:
            items_info = 'unknown'

        ilvo_logger.info(
            f"RID={rid} | 200 | client={client_ip} | qs='{query_str}' | len={content_length} | "
            f"payload={items_info} | created={stats['created']} | updated={stats['updated']} | "
            f"skipped={stats['skipped']} | geocode={int(do_geocode)} | embed={int(do_embed)} | "
            f"t={duration_ms}ms"
        )

        response_payload = {
            'status': 'ok',
            'created': stats['created'],
            'updated': stats['updated'],
            'skipped': stats['skipped'],
        }
        # Логируем ответ сервера
        if _LOG_SUCCESS_BODY:
            ilvo_logger.info(f"RID={rid} | RESP BODY: {json.dumps(response_payload, ensure_ascii=False, default=str)}")
        ilvo_logger.info(f"RID={rid} | " + "-" * 80)

        return JsonResponse(response_payload)

    @staticmethod
    def _extract_token(request):
        # 1. Проверка стандартного Bearer токена
        auth = request.headers.get('Authorization') or ''
        if auth.lower().startswith('bearer '):
            return auth.split(' ', 1)[1].strip()

        # 2. Проверка заголовка X-API-KEY
        api_key = request.headers.get('X-API-KEY')
        if api_key:
            return api_key

        # 3. Добавлена поддержка заголовка x-token для совместимости с клиентом
        return request.headers.get('x-token')


# ---------------------------------------------------------------------------
# Вспомогательная функция — общая проверка токена для API
# ---------------------------------------------------------------------------

def _authenticate_api_request(request):
    """
    Извлекает и проверяет API-токен из запроса.
    Возвращает (token_obj, error_response) — один из них всегда None.
    """
    auth = request.headers.get('Authorization') or ''
    if auth.lower().startswith('bearer '):
        raw_token = auth.split(' ', 1)[1].strip()
    else:
        raw_token = (
            request.headers.get('X-API-KEY')
            or request.headers.get('x-token')
            or ''
        )

    if not raw_token:
        return None, JsonResponse({'error': 'Unauthorized', 'detail': 'Token is missing'}, status=401)

    token_obj = ApiAccessToken.objects.filter(token=raw_token, is_active=True).first()
    if not token_obj or not token_obj.is_valid():
        return None, JsonResponse({'error': 'Forbidden', 'detail': 'Invalid or expired token'}, status=403)

    return token_obj, None


# ---------------------------------------------------------------------------
# API: GET /api/secondary/commercial/
# Выдача коммерческой вторичной недвижимости (property_type='commercial')
# ---------------------------------------------------------------------------

@method_decorator(csrf_exempt, name='dispatch')
class SecondaryCommercialAPIView(View):
    """
    REST API для получения коммерческих объектов вторичной недвижимости.

    Auth:  Authorization: Bearer <token>  |  X-API-KEY: <token>
    Method: GET

    Query params:
      city          — фильтр по городу (exact, case-insensitive)
      district      — фильтр по району (contains)
      deal_type     — тип сделки: sell | rent
      subtype       — подтип (contains)
      price_min     — цена от (₸)
      price_max     — цена до (₸)
      area_min      — площадь от (м²)
      area_max      — площадь до (м²)
      floor_min     — этаж от
      floor_max     — этаж до
      is_verified   — проверен: true | false
      search        — текстовый поиск (title, address, description)
      ordering      — сортировка: price | -price | area | -area | created_at | -created_at
      page          — номер страницы (default: 1)
      page_size     — записей на странице (default: 20, max: 100)

    Response 200:
      {
        "count": <int>,          — всего записей по фильтрам
        "total_pages": <int>,
        "page": <int>,
        "page_size": <int>,
        "results": [ { ...all fields + raw_data } ]
      }
    """

    DEFAULT_PAGE_SIZE = 20
    MAX_PAGE_SIZE = 100
    ALLOWED_ORDERINGS = {
        'price': 'price',
        '-price': '-price',
        'area': 'area',
        '-area': '-area',
        'created_at': 'created_at',
        '-created_at': '-created_at',
        'floor': 'floor',
        '-floor': '-floor',
    }

    def get(self, request):
        # --- Auth ---
        token_obj, err = _authenticate_api_request(request)
        if err:
            return err

        # --- Base queryset: строго commercial ---
        qs = SecondaryProperty.objects.filter(
            property_type='commercial',
            is_active=True,
        )

        # --- Filters ---
        city = request.GET.get('city', '').strip()
        if city:
            qs = qs.filter(city__iexact=city)

        district = request.GET.get('district', '').strip()
        if district:
            qs = qs.filter(district__icontains=district)

        deal_type = request.GET.get('deal_type', '').strip()
        if deal_type:
            qs = qs.filter(deal_type__iexact=deal_type)

        subtype = request.GET.get('subtype', '').strip()
        if subtype:
            qs = qs.filter(subtype__icontains=subtype)

        price_min = request.GET.get('price_min', '').strip()
        if price_min:
            try:
                qs = qs.filter(price__gte=float(price_min))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'price_min must be numeric'}, status=400)

        price_max = request.GET.get('price_max', '').strip()
        if price_max:
            try:
                qs = qs.filter(price__lte=float(price_max))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'price_max must be numeric'}, status=400)

        area_min = request.GET.get('area_min', '').strip()
        if area_min:
            try:
                qs = qs.filter(area__gte=float(area_min))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'area_min must be numeric'}, status=400)

        area_max = request.GET.get('area_max', '').strip()
        if area_max:
            try:
                qs = qs.filter(area__lte=float(area_max))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'area_max must be numeric'}, status=400)

        floor_min = request.GET.get('floor_min', '').strip()
        if floor_min:
            try:
                qs = qs.filter(floor__gte=int(floor_min))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'floor_min must be integer'}, status=400)

        floor_max = request.GET.get('floor_max', '').strip()
        if floor_max:
            try:
                qs = qs.filter(floor__lte=int(floor_max))
            except ValueError:
                return JsonResponse({'error': 'Bad Request', 'detail': 'floor_max must be integer'}, status=400)

        is_verified = request.GET.get('is_verified', '').strip().lower()
        if is_verified == 'true':
            qs = qs.filter(is_verified=True)
        elif is_verified == 'false':
            qs = qs.filter(is_verified=False)

        search = request.GET.get('search', '').strip()
        if search:
            qs = qs.filter(
                Q(title__icontains=search)
                | Q(address__icontains=search)
                | Q(description__icontains=search)
                | Q(subtype__icontains=search)
            )

        # --- Ordering ---
        ordering_param = request.GET.get('ordering', '-created_at').strip()
        ordering = self.ALLOWED_ORDERINGS.get(ordering_param, '-created_at')
        qs = qs.order_by(ordering)

        # --- Pagination ---
        try:
            page_size = min(int(request.GET.get('page_size', self.DEFAULT_PAGE_SIZE)), self.MAX_PAGE_SIZE)
        except (ValueError, TypeError):
            page_size = self.DEFAULT_PAGE_SIZE

        paginator = Paginator(qs, page_size)
        try:
            page_number = int(request.GET.get('page', 1))
        except (ValueError, TypeError):
            page_number = 1

        try:
            page_obj = paginator.page(page_number)
        except InvalidPage:
            return JsonResponse({'error': 'Bad Request', 'detail': f'Page {page_number} does not exist'}, status=400)

        # --- Serialise ---
        results = [self._serialize(obj) for obj in page_obj.object_list]

        return JsonResponse({
            'count': paginator.count,
            'total_pages': paginator.num_pages,
            'page': page_obj.number,
            'page_size': page_size,
            'filters_applied': {
                'property_type': 'commercial',
                'city': city or None,
                'district': district or None,
                'deal_type': deal_type or None,
                'subtype': subtype or None,
                'price_min': price_min or None,
                'price_max': price_max or None,
                'area_min': area_min or None,
                'area_max': area_max or None,
                'floor_min': floor_min or None,
                'floor_max': floor_max or None,
                'is_verified': is_verified or None,
                'search': search or None,
                'ordering': ordering_param,
            },
            'results': results,
        }, json_dumps_params={'ensure_ascii': False, 'default': str})

    @staticmethod
    def _serialize(obj: SecondaryProperty) -> dict:
        return {
            'id': str(obj.id),
            'external_uuid': obj.external_uuid,
            'external_id': obj.external_id,
            'property_type': obj.property_type,
            'subtype': obj.subtype,
            'deal_type': obj.deal_type,
            'rent_type': obj.rent_type,
            'currency': obj.currency,
            'condition': obj.condition,
            'repair': obj.repair,
            'construction_year': obj.construction_year,
            'ceiling_height': obj.ceiling_height,
            'rooms_total': obj.rooms_total,
            'area_living': obj.area_living,
            'area_kitchen': obj.area_kitchen,
            'material': obj.material,
            'prices': obj.prices,
            'prices_m2': obj.prices_m2,
            'title': obj.title,
            'description': obj.description,
            'address': obj.address,
            'address_note': obj.address_note,
            'city': obj.city,
            'district': obj.district,
            'city_micro_district': obj.city_micro_district,
            'price': str(obj.price),
            'rooms': obj.rooms,
            'area': obj.area,
            'floor': obj.floor,
            'total_floors': obj.total_floors,
            'latitude': obj.latitude,
            'longitude': obj.longitude,
            'has_parking': obj.has_parking,
            'has_balcony': obj.has_balcony,
            'has_renovation': obj.has_renovation,
            'source_url': obj.source_url,
            'photos': obj.photos,
            'owner_phone': obj.owner_phone,
            'owner_name': obj.owner_name,
            'is_active': obj.is_active,
            'is_verified': obj.is_verified,
            'views_count': obj.views_count,
            'created_at': obj.created_at.isoformat(),
            'updated_at': obj.updated_at.isoformat(),
            # raw_data — полностью, без купюр
            'raw_data': obj.raw_data,
        }


# ======================================================================
# Анкеты обратной связи (UI-конструктор)
# ======================================================================


class SurveyListView(StaffRequiredMixin, ListView):
    model = FeedbackSurvey
    template_name = 'dashboard/survey_list.html'
    context_object_name = 'surveys'
    ordering = ['-updated_at']

    def get_queryset(self):
        qs = super().get_queryset()
        return qs.annotate(
            total_submissions=Count('submissions'),
            completed_count=Count('submissions', filter=Q(submissions__status='completed')),
        )


class SurveyDetailView(StaffRequiredMixin, DetailView):
    model = FeedbackSurvey
    template_name = 'dashboard/survey_detail.html'
    context_object_name = 'survey'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        survey = self.get_object()
        ctx['questions'] = survey.questions.filter(is_active=True).order_by('order')
        ctx['analytics'] = SurveyService.analytics_snapshot(survey.id)
        ctx['total_submissions'] = survey.submissions.count()
        ctx['completed_submissions'] = survey.submissions.filter(status='completed').count()
        return ctx


class SurveyCreateView(StaffRequiredMixin, View):
    template_name = 'dashboard/survey_form.html'

    def get(self, request):
        return self._render(request)

    def post(self, request):
        title = request.POST.get('title', '').strip()
        description = request.POST.get('description', '').strip()
        motivation_text = request.POST.get('motivation_text', '').strip()
        bonus_extra_limit = int(request.POST.get('bonus_extra_limit', 0) or 0)
        trigger_type = request.POST.get('trigger_type', 'manual')
        trigger_search_count = int(request.POST.get('trigger_search_count', 0) or 0)
        trigger_objects_count = int(request.POST.get('trigger_objects_count', 0) or 0)

        if not title:
            messages.error(request, 'Название анкеты обязательно.')
            return self._render(request)

        survey = FeedbackSurvey.objects.create(
            title=title,
            description=description,
            motivation_text=motivation_text,
            bonus_extra_limit=bonus_extra_limit,
            trigger_type=trigger_type,
            trigger_search_count=trigger_search_count,
            trigger_objects_count=trigger_objects_count,
        )
        messages.success(request, f'Анкета «{survey.title}» создана.')
        return redirect('dashboard:survey_detail', pk=survey.pk)

    def _render(self, request, **extra):
        return self._render_template(
            request,
            self.template_name,
            {'action': 'create', 'survey': None, **extra},
        )

    @staticmethod
    def _render_template(request, template, ctx):
        from django.shortcuts import render
        return render(request, template, ctx)


class SurveyEditView(StaffRequiredMixin, View):
    template_name = 'dashboard/survey_form.html'

    def get(self, request, pk):
        survey = get_object_or_404(FeedbackSurvey, pk=pk)
        from django.shortcuts import render
        return render(request, self.template_name, {'action': 'edit', 'survey': survey})

    def post(self, request, pk):
        survey = get_object_or_404(FeedbackSurvey, pk=pk)
        survey.title = request.POST.get('title', survey.title).strip()
        survey.description = request.POST.get('description', survey.description).strip()
        survey.motivation_text = request.POST.get('motivation_text', survey.motivation_text).strip()
        survey.bonus_extra_limit = int(request.POST.get('bonus_extra_limit', survey.bonus_extra_limit) or 0)
        survey.trigger_type = request.POST.get('trigger_type', survey.trigger_type)
        survey.trigger_search_count = int(request.POST.get('trigger_search_count', 0) or 0)
        survey.trigger_objects_count = int(request.POST.get('trigger_objects_count', 0) or 0)
        survey.save()
        messages.success(request, 'Анкета обновлена.')
        return redirect('dashboard:survey_detail', pk=survey.pk)


class SurveyDeleteView(StaffRequiredMixin, View):
    def post(self, request, pk):
        survey = get_object_or_404(FeedbackSurvey, pk=pk)
        title = survey.title
        survey.delete()
        messages.success(request, f'Анкета «{title}» удалена.')
        return redirect('dashboard:survey_list')


class SurveyToggleView(StaffRequiredMixin, View):
    def post(self, request, pk):
        survey = get_object_or_404(FeedbackSurvey, pk=pk)
        survey.is_active = not survey.is_active
        survey.save(update_fields=['is_active'])
        status = 'активирована' if survey.is_active else 'деактивирована'
        messages.success(request, f'Анкета «{survey.title}» {status}.')
        return redirect('dashboard:survey_detail', pk=survey.pk)


class QuestionCreateView(StaffRequiredMixin, View):
    def post(self, request, survey_pk):
        survey = get_object_or_404(FeedbackSurvey, pk=survey_pk)
        text = request.POST.get('text', '').strip()
        if not text:
            messages.error(request, 'Текст вопроса обязателен.')
            return redirect('dashboard:survey_detail', pk=survey_pk)

        question_type = request.POST.get('question_type', 'text')
        options_raw = request.POST.get('options', '').strip()
        is_required = request.POST.get('is_required') == 'on'

        # Парсим варианты ответов (по одному на строку)
        options = [o.strip() for o in options_raw.splitlines() if o.strip()] if options_raw else []

        # Следующий порядковый номер
        last_order = survey.questions.aggregate(m=models.Max('order'))['m'] or 0

        FeedbackSurveyQuestion.objects.create(
            survey=survey,
            text=text,
            question_type=question_type,
            options=options,
            order=last_order + 1,
            is_required=is_required,
        )
        messages.success(request, 'Вопрос добавлен.')
        return redirect('dashboard:survey_detail', pk=survey_pk)


class QuestionEditView(StaffRequiredMixin, View):
    def post(self, request, survey_pk, pk):
        question = get_object_or_404(FeedbackSurveyQuestion, pk=pk, survey_id=survey_pk)
        question.text = request.POST.get('text', question.text).strip()
        question.question_type = request.POST.get('question_type', question.question_type)
        options_raw = request.POST.get('options', '').strip()
        question.options = [o.strip() for o in options_raw.splitlines() if o.strip()]
        question.is_required = request.POST.get('is_required') == 'on'
        question.save()
        messages.success(request, 'Вопрос обновлён.')
        return redirect('dashboard:survey_detail', pk=survey_pk)


class QuestionDeleteView(StaffRequiredMixin, View):
    def post(self, request, survey_pk, pk):
        question = get_object_or_404(FeedbackSurveyQuestion, pk=pk, survey_id=survey_pk)
        question.delete()
        # Перенумеровываем оставшиеся вопросы
        for i, q in enumerate(
            FeedbackSurveyQuestion.objects.filter(survey_id=survey_pk).order_by('order'), 1
        ):
            q.order = i
            q.save(update_fields=['order'])
        messages.success(request, 'Вопрос удалён.')
        return redirect('dashboard:survey_detail', pk=survey_pk)


class QuestionReorderView(StaffRequiredMixin, View):
    """AJAX endpoint: принимает JSON [{id: N, order: M}, ...]"""
    def post(self, request, survey_pk):
        try:
            data = json.loads(request.body)
            for item in data:
                FeedbackSurveyQuestion.objects.filter(
                    pk=item['id'], survey_id=survey_pk
                ).update(order=item['order'])
            return JsonResponse({'ok': True})
        except Exception as exc:
            return JsonResponse({'ok': False, 'error': str(exc)}, status=400)


# ======================================================================
# Тексты бота (BotText)
# ======================================================================

class BotTextListView(StaffRequiredMixin, ListView):
    model = BotText
    template_name = 'dashboard/bot_text_list.html'
    context_object_name = 'bot_texts'
    ordering = ['key', 'channel', 'locale']

    def get_queryset(self):
        qs = super().get_queryset()
        q = self.request.GET.get('q')
        if q:
            qs = qs.filter(Q(key__icontains=q) | Q(text__icontains=q) | Q(description__icontains=q))
        return qs


class BotTextEditView(StaffRequiredMixin, View):
    template_name = 'dashboard/bot_text_edit.html'

    def get(self, request, pk):
        bot_text = get_object_or_404(BotText, pk=pk)
        from django.shortcuts import render
        return render(request, self.template_name, {'bot_text': bot_text})

    def post(self, request, pk):
        bot_text = get_object_or_404(BotText, pk=pk)
        bot_text.text = request.POST.get('text', bot_text.text)
        bot_text.description = request.POST.get('description', bot_text.description)
        bot_text.is_active = request.POST.get('is_active') == 'on'
        bot_text.save()

        # Инвалидируем кэш для этого ключа
        from django.core.cache import cache
        from core.services.bot_text_service import BotTextService
        cache.delete(BotTextService._cache_key(bot_text.key, bot_text.channel, bot_text.locale))

        messages.success(request, f'Текст «{bot_text.key}» обновлён и применён немедленно.')
        return redirect('dashboard:bot_text_list')


# ======================================================================
# Логи лидов BI Group CRM
# ======================================================================

class LeadAnalyticsView(StaffRequiredMixin, TemplateView):
    """Аналитика лидов (ТЗ п.6)."""

    template_name = 'dashboard/lead_analytics.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        today = timezone.localdate()
        default_from = today - timedelta(days=90)
        df = self.request.GET.get('date_from') or default_from.isoformat()
        dt = self.request.GET.get('date_to') or today.isoformat()
        try:
            date_from = timezone.datetime.fromisoformat(df).date()
        except ValueError:
            date_from = default_from
        try:
            date_to = timezone.datetime.fromisoformat(dt).date()
        except ValueError:
            date_to = today
        if date_from > date_to:
            date_from, date_to = date_to, date_from
        start_dt = timezone.make_aware(timezone.datetime.combine(date_from, timezone.datetime.min.time()))
        end_dt = timezone.make_aware(timezone.datetime.combine(date_to, timezone.datetime.max.time()))

        leads = (
            Lead.objects.filter(created_at__range=(start_dt, end_dt))
            .select_related('user')
            .order_by('-created_at')[:500]
        )
        ctx['leads'] = leads
        ctx['total_leads'] = Lead.objects.filter(created_at__range=(start_dt, end_dt)).count()
        ctx['by_developer'] = (
            Lead.objects.filter(created_at__range=(start_dt, end_dt))
            .exclude(developer='')
            .values('developer')
            .annotate(c=Count('id'))
            .order_by('-c')[:25]
        )
        ctx['by_complex'] = (
            Lead.objects.filter(created_at__range=(start_dt, end_dt))
            .exclude(residential_complex='')
            .values('residential_complex')
            .annotate(c=Count('id'))
            .order_by('-c')[:25]
        )
        ctx['bi_log'] = BIGroupLeadLog.objects.filter(created_at__range=(start_dt, end_dt)).order_by('-created_at')[:200]
        ctx['bi_log_total'] = BIGroupLeadLog.objects.filter(created_at__range=(start_dt, end_dt)).count()
        ctx['chart_leads'] = (
            Lead.objects.filter(created_at__range=(start_dt, end_dt))
            .annotate(day=TruncDate('created_at'))
            .values('day')
            .annotate(c=Count('id'))
            .order_by('day')
        )
        ctx['filter_date_from'] = date_from.isoformat()
        ctx['filter_date_to'] = date_to.isoformat()
        return ctx


class ReferralAnalyticsView(StaffRequiredMixin, TemplateView):
    """Аналитика рефералов (ТЗ п.10)."""

    template_name = 'dashboard/referral_analytics.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['total_invited'] = BotUser.objects.exclude(invited_by__isnull=True).count()
        ctx['referral_join_events'] = BotProductEvent.objects.filter(event_type='referral_join').count()
        ctx['top_referrers'] = (
            BotUser.objects.annotate(invited_count=Count('referrals'))
            .filter(invited_count__gt=0)
            .select_related('role')
            .order_by('-invited_count')[:40]
        )
        ctx['recent_invited'] = (
            BotUser.objects.exclude(invited_by__isnull=True)
            .select_related('invited_by', 'role')
            .order_by('-created_at')[:50]
        )
        return ctx


class BIGroupLeadLogView(StaffRequiredMixin, ListView):
    model = BIGroupLeadLog
    template_name = 'dashboard/bigroup_lead_log.html'
    context_object_name = 'logs'
    paginate_by = 50
    ordering = ['-created_at']

    def get_queryset(self):
        qs = super().get_queryset()
        status = self.request.GET.get('status')
        if status == 'success':
            qs = qs.filter(success=True)
        elif status == 'fail':
            qs = qs.filter(success=False)
        q = self.request.GET.get('q')
        if q:
            qs = qs.filter(Q(name__icontains=q) | Q(phone__icontains=q) | Q(complex_name__icontains=q))
        return qs

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['total'] = BIGroupLeadLog.objects.count()
        ctx['success_count'] = BIGroupLeadLog.objects.filter(success=True).count()
        ctx['fail_count'] = BIGroupLeadLog.objects.filter(success=False).count()
        ctx['filter_status'] = self.request.GET.get('status', '')
        ctx['filter_q'] = self.request.GET.get('q', '')
        return ctx