from django.views.generic import TemplateView, ListView, CreateView, UpdateView, DeleteView, View, DetailView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.shortcuts import redirect, get_object_or_404
from django.contrib import messages
from django.urls import reverse_lazy
from django.db.models import Q, Count, Min, Max
from django.http import JsonResponse
from datetime import timedelta
from django.utils import timezone

from telegram_bot.models import Lead, SecondaryProperty, BIComplex, BotUser, BIUnit
from .forms import SecondaryPropertyForm, LeadUpdateForm


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
    """Список объектов вторички"""
    model = SecondaryProperty
    template_name = 'dashboard/secondary_list.html'
    context_object_name = 'properties'
    paginate_by = 12

    def get_queryset(self):
        queryset = SecondaryProperty.objects.filter(is_active=True).order_by('-created_at')

        # Фильтр по городу
        city = self.request.GET.get('city')
        if city:
            queryset = queryset.filter(city=city)

        # Поиск
        search = self.request.GET.get('search')
        if search:
            queryset = queryset.filter(
                Q(title__icontains=search) |
                Q(address__icontains=search) |
                Q(description__icontains=search)
            )

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['cities'] = SecondaryProperty.objects.values_list('city', flat=True).distinct()
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
    """Список ЖК BI Group"""
    model = BIComplex
    template_name = 'dashboard/bi_complex_list.html'
    context_object_name = 'complexes'
    paginate_by = 20

    def get_queryset(self):
        return BIComplex.objects.annotate(
            units_count=Count('units', filter=Q(units__is_active=True))
        ).order_by('-updated_at')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['total_units'] = BIUnit.objects.filter(is_active=True).count()
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
    """Список пользователей бота"""
    model = BotUser
    template_name = 'dashboard/user_list.html'
    context_object_name = 'users'
    paginate_by = 30

    def get_queryset(self):
        queryset = BotUser.objects.order_by('-last_active_at')

        # Фильтр по платформе
        platform = self.request.GET.get('platform')
        if platform:
            queryset = queryset.filter(platform=platform)

        return queryset

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['telegram_users_count'] = BotUser.objects.filter(platform='telegram').count()
        context['whatsapp_users_count'] = BotUser.objects.filter(platform='whatsapp').count()
        context['active_today_count'] = BotUser.objects.filter(
            last_active_at__date=timezone.now().date()
        ).count()
        return context

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['platform_choices'] = BotUser.PLATFORM_CHOICES
        return context


class BotUserDetailView(StaffRequiredMixin, DetailView):
    """Детальная страница пользователя"""
    model = BotUser
    template_name = 'dashboard/user_detail.html'
    context_object_name = 'bot_user'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Добавляем статистику пользователя
        context['user_leads'] = Lead.objects.filter(user=self.object).order_by('-created_at')[:10]
        return context