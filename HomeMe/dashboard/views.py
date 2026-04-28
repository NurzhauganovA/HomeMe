from django.views.generic import TemplateView, ListView, CreateView, UpdateView, DeleteView, View, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.shortcuts import redirect, get_object_or_404
from django.contrib import messages
from django.urls import reverse_lazy
from django.db.models import Q, Count, Min, Max
from django.http import JsonResponse
from datetime import timedelta
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
import json
import os
import time
import logging
from logging.handlers import TimedRotatingFileHandler
import uuid
import gzip
import shutil

from telegram_bot.models import Lead, SecondaryProperty, BIComplex, BotUser, BIUnit, BICommercialComplex, BICommercialUnit, DailyUsageLog
from .models import ApiAccessToken, Role, Permission
from core.services.secondary_importer import SecondaryImporter
from .forms import SecondaryPropertyForm, LeadUpdateForm, RoleForm, AssignRoleForm
from django.conf import settings

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
    """Главная страница дашборда со статистикой"""
    template_name = 'dashboard/index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # Статистика
        context['stats'] = {
            'new_leads': Lead.objects.filter(status='new').count(),
            'active_properties': SecondaryProperty.objects.filter(is_active=True).count(),
            'total_users': BotUser.objects.count(),
            'bi_complexes': BIComplex.objects.count(),
        }

        # Последние лиды
        context['recent_leads'] = Lead.objects.select_related('user').order_by('-created_at')[:5]

        # Данные для графика (лиды за последние 7 дней)
        week_ago = timezone.now() - timedelta(days=7)
        leads_by_day = []
        for i in range(7):
            day = week_ago + timedelta(days=i)
            count = Lead.objects.filter(
                created_at__date=day.date()
            ).count()
            leads_by_day.append({
                'date': day.strftime('%d.%m'),
                'count': count
            })
        context['chart_data'] = leads_by_day

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