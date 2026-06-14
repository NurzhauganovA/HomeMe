import io
import logging
import random
from asgiref.sync import sync_to_async
from shutil import which
from pydub import AudioSegment

from core.location_resolver import DynamicLocationResolver
from telegram_bot.models import BotUser, UserSession, Lead, FavoriteProperty, BotProductEvent
from core.dto import PropertyDTO
from core.services.ai_service import EnhancedAIService
from core.services.search_service import EnhancedSearchService
from core.services.limit_service import LimitService
from core.services.permission_service import PermissionService
from core.services.bot_text_service import BotTextService
from core.services.survey_service import SurveyService
from core.services.product_analytics_service import ProductAnalyticsService
from core.services import referral_service
from core.services.lead_context import snapshot_for_expert_lead
from dashboard.models import FeedbackSurveySubmission

logger = logging.getLogger(__name__)


class EnhancedDialogManager:
    def __init__(self):
        self.ai = EnhancedAIService()
        self.search = EnhancedSearchService(self.ai)
        self.location_resolver = DynamicLocationResolver(self.ai)

    async def _check_permission(self, user, codename: str):
        allowed, message = await sync_to_async(PermissionService.assert_permission)(user, codename)
        if allowed:
            return True, None
        return False, {
            'text': message,
            'buttons': ['В главное меню']
        }

    async def process_message(self, user_id, platform, text, user_name=None, is_voice: bool = False, telegram_username=None):
        user, created = await sync_to_async(BotUser.objects.get_or_create)(
            user_id=str(user_id),
            platform=platform,
            defaults={'name': user_name}
        )
        if telegram_username and getattr(user, 'username', None) != telegram_username:
            user.username = (telegram_username or '')[:100]
            await sync_to_async(user.save)(update_fields=['username'])

        await sync_to_async(referral_service.ensure_referral_code)(user)

        referral_attached = False
        start_arg = referral_service.parse_start_argument(text)
        if start_arg:
            referral_attached = await sync_to_async(referral_service.try_attach_referrer)(user, start_arg)
            if referral_attached:
                await sync_to_async(ProductAnalyticsService.record)(
                    user, 'referral_join',
                    payload={'start_arg': start_arg},
                    search_params=None,
                )

        session, _ = await sync_to_async(UserSession.objects.get_or_create)(user=user)

        has_bot_access, denied_response = await self._check_permission(user, 'use_bot')
        if not has_bot_access:
            return denied_response

        state = session.current_intent or 'START'
        params = session.search_params or {}

        response = {'text': '', 'buttons': [], 'objects': []}

        # Глобальные команды (/start с аргументом реферала — тоже сюда)
        raw_cmd = (text or '').strip()
        low_cmd = raw_cmd.lower()
        is_root_menu = low_cmd in ['/start', 'привет', 'меню', 'start', 'reset', 'в главное меню'] or low_cmd.startswith('/start')
        if is_root_menu:
            await sync_to_async(ProductAnalyticsService.record)(
                user,
                BotProductEvent.EVENT_BOT_START,
                payload={'is_new_user': created, 'cmd': raw_cmd[:120]},
                search_params=None,
            )
            await self._update_state(session, 'START', {})
            return await self._scenario_start(user, referral_attached=referral_attached)

        # Ветка прохождения анкеты обратной связи
        if state == 'SURVEY_IN_PROGRESS':
            survey_response = await self._handle_survey_step(user, session, text)
            return self._ensure_main_menu_button(survey_response, state)

        # Голосовые сообщения: используем AI для извлечения параметров
        if is_voice:
            voice_params = await self._apply_voice_ai_params(text, params)
            if voice_params is None:
                return await self._quota_response()
            params = voice_params
            if self._has_search_intent(params, text):
                response = await self._run_search_with_params(session, params, user)
                return self._ensure_main_menu_button(response, state)

        if self._is_edit_params_command(text):
            response = await self._enter_edit_params_menu(session, params)
            return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')

        # --- МАШИНА СОСТОЯНИЙ ---

        if state == 'START':
            lowered_text = text.lower()
            if text == '1' or 'подобрать' in lowered_text:
                await self._update_state(session, 'CHOOSING_TYPE')
                response[
                    'text'] = "Отлично! Что будем смотреть?\n\n1. Новостройки BI Group 🏗\n2. Вторичка 🏠"
                response['buttons'] = ['1. BI Group', '2. Вторичка', 'В главное меню']

            elif text == '2' or 'район' in lowered_text:
                await self._update_state(session, 'CONSULTATION_TOPIC')
                response['text'] = "Про какой район рассказать? (Выберите район или берег)"
                response['buttons'] = self._location_buttons()

            elif 'поделиться' in lowered_text or 'реферал' in lowered_text or 'приглас' in lowered_text or '🔗' in text:
                code = await sync_to_async(referral_service.ensure_referral_code)(user)
                share = referral_service.build_referral_share_text(code)
                link = referral_service.build_telegram_referral_link(code)
                if link:
                    response['text'] = await BotTextService.aget(
                        'referral.invite',
                        fallback='👥 Поделитесь ботом с друзьями.\nВаша персональная ссылка:\n{link}',
                        link=link,
                    )
                else:
                    response['text'] = (
                        '👥 Поделитесь ботом с друзьями.\n'
                        f'Пусть друг откроет бота и отправит команду:\n{share}'
                    )
                # Без Markdown: символ _ в @username бота ломает ссылку (Telegram «съедает» _)
                response['parse_mode'] = 'plain'
                response['buttons'] = ['В главное меню']

            elif text == '3' or 'эксперт' in lowered_text:
                allowed, denied = await self._check_permission(user, 'request_consultation')
                if not allowed:
                    return denied
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = await BotTextService.aget(
                    "lead.ask_name",
                    fallback="Я соединю тебя с экспертом. Как к тебе обращаться?",
                )

            elif 'избран' in lowered_text:
                allowed, denied = await self._check_permission(user, 'manage_favorites')
                if not allowed:
                    return denied
                favorites = await sync_to_async(
                    lambda: list(FavoriteProperty.objects.filter(user=user).order_by('-created_at'))
                )()
                if favorites:
                    response['text'] = await BotTextService.aget(
                        "favorites.list",
                        fallback="⭐ Ваши избранные объекты:\n\nНажмите 🗑 Удалить на карточке объекта, чтобы убрать из избранного.",
                    )
                    dtos = []
                    for item in favorites:
                        dto = PropertyDTO.from_dict(item.data)
                        dto.favorite_id = str(item.id)
                        dtos.append(dto)
                    response['objects'] = dtos
                else:
                    response['text'] = await BotTextService.aget(
                        "favorites.empty",
                        fallback="⭐ Избранное пока пустое.",
                    )
                response['buttons'] = ['В главное меню']
                await self._update_state(session, 'START', params)

            elif any(word in lowered_text for word in ['найди', 'квартира', 'квартиру', 'жк', 'жилье', 'квартир']):
                # Быстрый старт без кнопок: извлекаем параметры и сразу ищем
                params = await sync_to_async(
                    self.ai.extract_search_parameters,
                    thread_sensitive=False
                )(text)
                if self.ai.consume_quota_error():
                    return await self._quota_response()
                params['embedding_text'] = text
                params['source'] = params.get('source', 'mixed')

                if any(word in lowered_text for word in ['офис', 'коммер', 'помещение', 'бизнес', 'retail', 'стрит']):
                    params['source'] = 'bi'
                    params['bi_category'] = 'commercial'
                    params['bi_scope'] = 'both'
                    if any(word in lowered_text for word in ['здание', 'целиком', 'бц', 'business center']):
                        params['bi_scope'] = 'complex'

                location_data = await sync_to_async(
                    self.location_resolver.resolve_any_location,
                    thread_sensitive=False
                )(text, city_hint="Astana")
                if self.ai.consume_quota_error():
                    return await self._quota_response()
                if location_data:
                    center = location_data.get('center_coordinates')
                    radius_km = location_data.get('search_radius_km')
                    if center:
                        params['coordinates'] = {'lat': center[0], 'lon': center[1]}
                        params['radius_km'] = radius_km or 3.0

                params['offset'] = 0
                params['city'] = 'Astana'

                # Быстрый старт идёт через _run_search_with_params для единообразия лимитов
                response = await self._run_search_with_params(session, params, user)

            else:
                return await self._scenario_start(user)

        elif state == 'CHOOSING_TYPE':
            if '1' in text or 'bi' in text.lower():
                params['source'] = 'bi'
                await self._update_state(session, 'CHOOSING_BI_CATEGORY', params)
                response['text'] = "Что именно интересует в BI Group?\n\n1. Квартиры\n2. Коммерческие помещения"
                response['buttons'] = ['1. Квартиры', '2. Коммерческие помещения']
                return self._ensure_main_menu_button(response, state)
            elif '2' in text or 'вторич' in text.lower():
                params['source'] = 'secondary'
                await self._update_state(session, 'CHOOSING_SECONDARY_CATEGORY', params)
                response['text'] = "Что ищете на вторичном рынке?\n\n1. Квартиры 🏠\n2. Коммерческие помещения 🏢"
                response['buttons'] = ['1. Квартиры', '2. Коммерческие помещения']
                return self._ensure_main_menu_button(response, state)
            else:
                params['source'] = 'mixed'

            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = (
                "Какой бюджет? 💰\n"
                "Указывайте конкретный диапазон, чтобы поиск был точнее.\n"
                "Например: 40-45 млн или 18-20 млн."
            )
            response['buttons'] = [
                'до 30 млн', '30-40 млн', '40-50 млн',
                '50-60 млн', '60-70 млн', '70-80 млн', 'Не важно'
            ]

        elif state == 'CHOOSING_BI_CATEGORY':
            lowered_text = text.lower()
            if '2' in lowered_text or 'офис' in lowered_text or 'коммер' in lowered_text:
                params['bi_category'] = 'commercial'
                params['bi_scope'] = 'both'
            else:
                params['bi_category'] = 'residential'

            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = (
                "Какой бюджет? 💰\n"
                "Указывайте конкретный диапазон, чтобы поиск был точнее.\n"
                "Например: 40-45 млн или 18-20 млн."
            )
            if params.get('bi_category') == 'commercial':
                response['buttons'] = [
                    'до 50 млн', '50-70 млн', '70-90 млн',
                    '90-120 млн', '120-150 млн', '150-200 млн', 'Не важно'
                ]
            else:
                response['buttons'] = [
                    'до 30 млн', '30-40 млн', '40-50 млн',
                    '50-60 млн', '60-70 млн', '70-80 млн', 'Не важно'
                ]

        elif state == 'CHOOSING_SECONDARY_CATEGORY':
            lowered_text = text.lower()
            if '2' in lowered_text or 'коммер' in lowered_text or 'офис' in lowered_text or 'помещ' in lowered_text:
                params['secondary_category'] = 'commercial'
                response['buttons'] = [
                    'до 50 млн', '50-70 млн', '70-90 млн',
                    '90-120 млн', '120-150 млн', '150-200 млн', 'Не важно'
                ]
            else:
                params['secondary_category'] = 'apartment'
                response['buttons'] = [
                    'до 30 млн', '30-40 млн', '40-50 млн',
                    '50-60 млн', '60-70 млн', '70-80 млн', 'Не важно'
                ]
            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = (
                "Какой бюджет? 💰\n"
                "Указывайте конкретный диапазон, чтобы поиск был точнее.\n"
                "Например: 40-45 млн или 18-20 млн."
            )

        elif state == 'SETTING_BUDGET':
            allowed_budgets = {
                'до 30 млн', '30-40 млн', '40-50 млн', '50-60 млн', '60-70 млн', '70-80 млн',
                'до 50 млн', '50-70 млн', '70-90 млн', '90-120 млн', '120-150 млн', '150-200 млн',
                '30-50 млн', '50-80 млн', '80-120 млн', '120-200 млн', 'Не важно'
            }
            if text == 'Не важно':
                parsed_budget = {'max_price': 1000000000000, 'min_price': 0}
            else:
                parsed_budget = self._parse_budget_text(text)
            if not (parsed_budget.get('max_price') or parsed_budget.get('min_price')):
                ai_budget = await self._ai_fallback_parse(text, ['min_price', 'max_price'])
                if ai_budget is None:
                    return await self._quota_response()
                if ai_budget.get('min_price') or ai_budget.get('max_price'):
                    parsed_budget = ai_budget

            # Убрано ограничение на широкий диапазон - пользователь может указывать любые диапазоны
            if parsed_budget.get('max_price') or parsed_budget.get('min_price'):
                params.update(parsed_budget)
                if params.get('edit_mode'):
                    response = await self._enter_edit_params_menu(
                        session,
                        params,
                        prompt="Бюджет обновил. Что ещё изменить? Или нажмите «Искать»."
                    )
                    return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')
                is_commercial = (
                    params.get('bi_category') == 'commercial' or
                    params.get('secondary_category') == 'commercial'
                )
                if is_commercial:
                    await self._update_state(session, 'SETTING_AREA', params)
                    response['text'] = "Какая площадь нужна? 🏢 (Например: '50-120 м²' или 'до 80 м²')"
                    response['buttons'] = ['до 50 м²', '50-100 м²', '100-200 м²', 'Не важно']
                else:
                    await self._update_state(session, 'SETTING_ROOMS', params)
                    response['text'] = "Сколько комнат? 🛏\n(Можно выбрать несколько: например, '2-3' или '4-5')"
                    response['buttons'] = ['1', '2', '3', '4', '5+', '2-3', '4-5', 'Не важно']
            else:
                response['text'] = self._random_prompt(
                    "Бюджет не распознал.",
                    "Можно ответить так: 'до 50 млн' или '50-80 млн'.",
                    "Напиши бюджет цифрами, например: 45-60 млн."
                )

        elif state == 'SETTING_AREA':
            lowered_text = text.lower()

            if params.get('bi_category') == 'commercial':
                if any(word in lowered_text for word in ['здание', 'целиком', 'бц', 'business center']):
                    params['bi_scope'] = 'complex'
                elif any(word in lowered_text for word in ['офис', 'кабинет', 'помещение', 'retail', 'стрит']):
                    params['bi_scope'] = 'unit'

            parsed_area = self._parse_area_text(text)
            if not (parsed_area.get('min_area') or parsed_area.get('max_area')) and 'не важно' not in lowered_text:
                ai_area = await self._ai_fallback_parse(text, ['min_area', 'max_area'])
                if ai_area is None:
                    return await self._quota_response()
                if ai_area.get('min_area') or ai_area.get('max_area'):
                    parsed_area = ai_area

            if parsed_area.get('min_area') or parsed_area.get('max_area'):
                params.update(parsed_area)
            elif 'не важно' in lowered_text:
                params.pop('min_area', None)
                params.pop('max_area', None)
            else:
                response['text'] = self._random_prompt(
                    "Площадь не распознал.",
                    "Ответь так: 'до 80 м²' или '100-200 м²'.",
                    "Напиши площадь цифрами, например: 120 м²."
                )
                is_commercial = (
                    params.get('bi_category') == 'commercial' or
                    params.get('secondary_category') == 'commercial'
                )
                if is_commercial:
                    response['buttons'] = ['до 50 м²', '50-100 м²', '100-200 м²', 'Не важно']
                else:
                    response['buttons'] = ['до 40 м²', '40-60 м²', '60-80 м²', '80-100 м²', '100-120 м²', '120+ м²', 'Не важно']
                return self._ensure_main_menu_button(response, state)

            if params.get('edit_mode'):
                response = await self._enter_edit_params_menu(
                    session,
                    params,
                    prompt="Площадь обновил. Что ещё изменить? Или нажмите «Искать»."
                )
                return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')

            # Для жилых объектов BI Group спрашиваем класс жилья, для остальных идем на локацию
            if params.get('source') == 'bi' and params.get('bi_category') == 'residential':
                await self._update_state(session, 'SETTING_CLASS_NAME', params)
                response['text'] = "Какой класс жилья предпочитаете? 🏠"
                response['buttons'] = [
                    "Стандарт", "Комфорт",
                    "Бизнес", "Премиум", "Не важно"
                ]
            else:
                await self._update_state(session, 'SETTING_LOCATION', params)
                response['text'] = "Есть предпочтения по району? 📍\n(Выберите район, берег или напишите ориентир)"
                response['buttons'] = self._location_buttons()

        elif state == 'SETTING_ROOMS':
            lowered_text = text.lower()
            if 'не важно' in lowered_text:
                params.pop('rooms', None)
            else:
                # Парсим множественный выбор комнат (например, "2-3", "4-5", "1,2,3")
                rooms_list = self._parse_rooms_text(text)
                if rooms_list:
                    params['rooms'] = rooms_list
                else:
                    # Пробуем через AI
                    ai_rooms = await self._ai_fallback_parse(text, ['rooms'])
                    if ai_rooms is None:
                        return await self._quota_response()
                    if ai_rooms.get('rooms'):
                        # Если AI вернул одно число, делаем список
                        rooms_value = ai_rooms.get('rooms')
                        if isinstance(rooms_value, list):
                            params['rooms'] = rooms_value
                        else:
                            params['rooms'] = [rooms_value]
                    else:
                        response['text'] = self._random_prompt(
                            "Количество комнат не распознал.",
                            "Можно написать: 1, 2, 3, 4, 5+, 2-3, 4-5 или 'Не важно'.",
                            "Напиши количество комнат, например: 2 или 2-3."
                        )
                        response['buttons'] = ['1', '2', '3', '4', '5+', '2-3', '4-5', 'Не важно']
                        return self._ensure_main_menu_button(response, state)

            if params.get('edit_mode'):
                response = await self._enter_edit_params_menu(
                    session,
                    params,
                    prompt="Комнаты обновил. Что ещё изменить? Или нажмите «Искать»."
                )
                return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')

            await self._update_state(session, 'SETTING_AREA', params)
            response['text'] = "Какая площадь нужна? 📐 (Например: '45-70 м²' или 'до 60 м²')"
            response['buttons'] = ['до 40 м²', '40-60 м²', '60-80 м²', '80-100 м²', '100-120 м²', '120+ м²', 'Не важно']

        elif state == 'SETTING_CLASS_NAME':
            lowered_text = text.lower()
            class_names = [
                "Стандарт", "Комфорт",
                "Бизнес", "Премиум"
            ]

            # Ищем соответствие с классом жилья (case-insensitive)
            selected_class = None
            for class_name in class_names:
                if class_name.lower() in lowered_text:
                    selected_class = class_name
                    break

            if 'не важно' in lowered_text:
                params.pop('property_class', None)
            elif selected_class:
                params['property_class'] = selected_class
            else:
                response['text'] = self._random_prompt(
                    "Класс жилья не распознал.",
                    "Выберите из предложенных вариантов или нажмите «Не важно».",
                    "Напиши класс, например: Комфорт или Премиум."
                )
                response['buttons'] = [
                    "Стандарт", "Комфорт",
                    "Бизнес", "Премиум", "Не важно"
                ]
                return self._ensure_main_menu_button(response, state)

            if params.get('edit_mode'):
                response = await self._enter_edit_params_menu(
                    session,
                    params,
                    prompt="Класс жилья обновил. Что ещё изменить? Или нажмите «Искать»."
                )
                return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')

            await self._update_state(session, 'SETTING_LOCATION', params)
            response['text'] = "Есть предпочтения по району? 📍\n(Выберите район, берег или напишите ориентир)"
            response['buttons'] = self._location_buttons()

        elif state == 'SETTING_LOCATION':
            lowered = text.lower()
            if 'не важно' in lowered:
                params.pop('coordinates', None)
                params.pop('radius_km', None)
                params.pop('embedding_text', None)
                params.pop('district', None)
                params.pop('side', None)
                logger.info(f"🌍 Location: Не важно (все фильтры локации сброшены)")
            else:
                district = self._normalize_admin_district(text)
                if district:
                    params['district'] = district
                    params.pop('coordinates', None)
                    params.pop('radius_km', None)
                    params.pop('side', None)
                    params.pop('embedding_text', None)
                    logger.info(f"🏘 DISTRICT SET: {district}")
                elif 'левый' in lowered or 'правый' in lowered:
                    params['side'] = 'Left' if 'левый' in lowered else 'Right'
                    params.pop('coordinates', None)
                    params.pop('radius_km', None)
                    params.pop('district', None)
                    params.pop('embedding_text', None)
                    logger.info(f"🏖 SIDE SET: {params['side']}")
                else:
                    params['embedding_text'] = text
                    params.pop('side', None)
                    params.pop('district', None)
                    logger.info(f"📍 LANDMARK/EMBEDDING: {text}")

                    location_data = await sync_to_async(
                        self.location_resolver.resolve_any_location,
                        thread_sensitive=False
                    )(text, city_hint="Astana")
                    if self.ai.consume_quota_error():
                        return await self._quota_response()

                    if location_data:
                        center = location_data.get('center_coordinates')
                        radius_km = location_data.get('search_radius_km')
                        if center:
                            params['coordinates'] = {'lat': center[0], 'lon': center[1]}
                            params['radius_km'] = radius_km or 3.0
                            logger.info(f"📍 Coordinates found for '{text}': {params['coordinates']}")
                        else:
                            params.pop('coordinates', None)
                    else:
                        params.pop('coordinates', None)

            # Сброс пагинации перед новым поиском
            params['offset'] = 0
            params['city'] = 'Astana'  # Hardcode MVP
            
            logger.info(f"🚀 Starting search with params: district={params.get('district')}, side={params.get('side')}, coords={params.get('coordinates')}, source={params.get('source')}")

            if params.get('edit_mode'):
                response = await self._enter_edit_params_menu(
                    session,
                    params,
                    prompt="Локацию обновил. Что ещё изменить? Или нажмите «Искать»."
                )
            else:
                response = await self._run_search_with_params(session, params, user)

        elif state == 'COMPLEX_RESULTS':
            lowered_text = text.lower()
            if lowered_text in ['показать еще', 'показать ещё', 'еще', 'ещё', 'показать больше']:
                allowed, denied = await self._check_permission(user, 'search_properties')
                if not allowed:
                    return denied
                search_result = await sync_to_async(
                    self.search.search_complexes,
                    thread_sensitive=False
                )(params, offset=params.get('complex_offset', 0), limit=5)
                complexes, next_offset = self._unpack_complexes_result(
                    search_result,
                    params.get('complex_offset', 0)
                )

                if complexes:
                    params['complex_offset'] = next_offset
                    mapped = await sync_to_async(
                        self.search.map_complexes_to_dto,
                        thread_sensitive=False
                    )(params, complexes)
                    mapped = self._filter_seen_objects(params, mapped)
                    mapped, _, blocked = await sync_to_async(
                        LimitService.apply_limit
                    )(user, mapped, params)
                    if blocked or not mapped:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return response
                    response['objects'] = mapped
                    allowed_ids = {obj.object_id for obj in mapped if obj.object_id}
                    complexes_for_candidates = [c for c in complexes if c.bi_uuid in allowed_ids]
                    params['complex_candidates'] = self._merge_complex_candidates(
                        params.get('complex_candidates'),
                        self._serialize_complexes(complexes_for_candidates)
                    )
                    await self._update_state(session, 'COMPLEX_RESULTS', params)
                    response['text'] = "Еще варианты: 👇"
                    response['buttons'] = self._complex_action_buttons(params)
                    await self._emit_show_more(user, params)
                else:
                    response['text'] = "Больше вариантов нет. Можешь выбрать ЖК/БЦ из списка."
                    response['buttons'] = self._complex_action_buttons(params)
            elif 'показать' in lowered_text or 'квартир' in lowered_text or 'помещ' in lowered_text:
                await self._update_state(session, 'CHOOSING_COMPLEX_NUMBER', params)
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)
            elif 'изменить' in lowered_text:
                response = await self._enter_edit_params_menu(session, params)
            else:
                response['text'] = self._format_complexes_intro(params)
                response['buttons'] = self._complex_action_buttons(params)

        elif state == 'CHOOSING_COMPLEX_NUMBER':
            choice = self._parse_choice(text)
            candidates = params.get('complex_candidates') or []
            if 'изменить' in text.lower():
                response = await self._enter_edit_params_menu(session, params)
                return self._ensure_main_menu_button(response, 'EDITING_PARAMS_MENU')
            if not choice or choice < 1 or choice > len(candidates):
                response['text'] = "Пожалуйста, выбери номер из списка."
                response['buttons'] = self._complex_number_buttons(params)
            else:
                selected = candidates[choice - 1]
                params['selected_complex_id'] = selected.get('id')
                params['selected_complex_name'] = selected.get('name')
                params['offset'] = 0

                results = await sync_to_async(
                    self.search.search_units_for_complex,
                    thread_sensitive=False
                )(params, selected.get('id'), offset=0)

                if results:
                    raw_count = len(results)
                    results = self._filter_seen_objects(params, results)
                    results, _, blocked = await sync_to_async(
                        LimitService.apply_limit
                    )(user, results, params)
                    if blocked or not results:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return response
                    params['offset'] = raw_count
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = f"Вот варианты по {selected.get('name')}:"
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Другой ЖК/БЦ', 'Изменить параметры поиска']
                else:
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = f"По {selected.get('name')} ничего не найдено по текущим фильтрам."
                    response['buttons'] = ['Другой ЖК/БЦ', 'Изменить параметры поиска']

        elif state == 'BROWSING':
            if text.lower() in ['показать еще', 'показать ещё', 'еще', 'дальше', 'ещё']:
                # Проверяем лимит перед "Показать ещё"
                remaining_before = await sync_to_async(LimitService.get_remaining_total)(user)
                if remaining_before <= 0:
                    msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                    response['text'] = msg
                    response['buttons'] = ['В главное меню']
                    return self._ensure_main_menu_button(response, state)

                if params.get('source') == 'mixed':
                    results, new_bi_offset, new_secondary_offset = await sync_to_async(
                        self.search.intelligent_search_mixed,
                        thread_sensitive=False
                    )(
                        params,
                        bi_offset=params.get('bi_offset', 0),
                        secondary_offset=params.get('secondary_offset', 0)
                    )

                    if results:
                        filtered = self._filter_seen_objects(params, results)
                        params['bi_offset'] = new_bi_offset
                        params['secondary_offset'] = new_secondary_offset
                        await self._update_state(session, 'BROWSING', params)
                        if filtered:
                            # Применяем лимит
                            filtered, remaining, _ = await sync_to_async(
                                LimitService.apply_limit)(user, filtered, params)
                            if filtered:
                                response['text'] = await BotTextService.aget("search.show_more", fallback="Вот ещё варианты: 👇")
                                response['objects'] = filtered
                                response['buttons'] = ['Показать ещё', 'Изменить параметры поиска']
                                await self._emit_show_more(user, params)
                            else:
                                msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                                response['text'] = msg
                                response['buttons'] = ['В главное меню']
                        else:
                            response['text'] = await BotTextService.aget("search.no_more", fallback="Больше вариантов по вашему запросу нет. 🤷‍♂️")
                            response['buttons'] = ['Изменить параметры поиска']
                    else:
                        response['text'] = await BotTextService.aget("search.no_more", fallback="Больше вариантов по вашему запросу нет. 🤷‍♂️")
                        response['buttons'] = ['Изменить параметры поиска']
                else:
                    current_offset = params.get('offset', 0)

                    # Поиск следующей страницы
                    results = await sync_to_async(
                        self.search.intelligent_search,
                        thread_sensitive=False
                    )(params, offset=current_offset)

                    if results:
                        raw_count = len(results)
                        filtered = self._filter_seen_objects(params, results)
                        params['offset'] = current_offset + raw_count
                        await self._update_state(session, 'BROWSING', params)
                        if filtered:
                            # Применяем лимит
                            filtered, remaining, _ = await sync_to_async(
                                LimitService.apply_limit)(user, filtered, params)
                            if filtered:
                                response['text'] = await BotTextService.aget("search.show_more", fallback="Вот ещё варианты: 👇")
                                response['objects'] = filtered
                                response['buttons'] = ['Показать ещё', 'Изменить параметры поиска']
                                await self._emit_show_more(user, params)
                            else:
                                msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                                response['text'] = msg
                                response['buttons'] = ['В главное меню']
                        else:
                            response['text'] = await BotTextService.aget("search.no_more", fallback="Больше вариантов по вашему запросу нет. 🤷‍♂️")
                            response['buttons'] = ['Изменить параметры поиска']
                    else:
                        response['text'] = await BotTextService.aget("search.no_more", fallback="Больше вариантов по вашему запросу нет. 🤷‍♂️")
                        response['buttons'] = ['Изменить параметры поиска']

            elif 'бюджет' in text.lower() or 'параметр' in text.lower() or 'изменить' in text.lower():
                response = await self._enter_edit_params_menu(session, params)

            elif 'эксперт' in text.lower():
                allowed, denied = await self._check_permission(user, 'request_consultation')
                if not allowed:
                    return denied
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = await BotTextService.aget(
                    "lead.ask_name",
                    fallback="Я соединю тебя с экспертом. Как к тебе обращаться?",
                )
            else:
                return await self._scenario_start(user)

        elif state == 'BROWSING_UNITS':
            lowered_text = text.lower()
            if lowered_text in ['показать еще', 'показать ещё', 'еще', 'дальше', 'ещё']:
                allowed, denied = await self._check_permission(user, 'search_properties')
                if not allowed:
                    return denied
                current_offset = params.get('offset', 0)
                selected_id = params.get('selected_complex_id')

                results = await sync_to_async(
                    self.search.search_units_for_complex,
                    thread_sensitive=False
                )(params, selected_id, offset=current_offset)

                if results:
                    raw_count = len(results)
                    results = self._filter_seen_objects(params, results)
                    results, _, blocked = await sync_to_async(
                        LimitService.apply_limit
                    )(user, results, params)
                    if blocked or not results:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return self._ensure_main_menu_button(response, state)
                    params['offset'] = current_offset + raw_count
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = await BotTextService.aget("search.show_more", fallback="Вот ещё варианты: 👇")
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Другой ЖК/БЦ', 'Изменить параметры поиска']
                    await self._emit_show_more(user, params)
                else:
                    response['text'] = await BotTextService.aget("search.no_more", fallback="Варианты по этому ЖК/БЦ закончились. 🤷‍♂️")
                    response['buttons'] = ['Другой ЖК/БЦ', 'Изменить параметры поиска']

            elif 'другой' in lowered_text:
                await self._update_state(session, 'CHOOSING_COMPLEX_NUMBER', params)
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)

            elif 'изменить' in lowered_text or 'по другому' in lowered_text:
                response = await self._enter_edit_params_menu(session, params)

            else:
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)

        elif state == 'EDITING_PARAMS_MENU':
            lowered_text = text.lower()
            if lowered_text in ['искать', 'поиск', 'начать поиск', 'показать варианты', 'покажи варианты']:
                params.pop('edit_mode', None)
                response = await self._run_search_with_params(session, params, user)
            elif 'бюджет' in lowered_text:
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Какой бюджет? 💰"
                is_commercial = (
                    params.get('bi_category') == 'commercial' or
                    params.get('secondary_category') == 'commercial'
                )
                if is_commercial:
                    response['buttons'] = [
                        'до 50 млн', '50-70 млн', '70-90 млн',
                        '90-120 млн', '120-150 млн', '150-200 млн', 'Не важно'
                    ]
                else:
                    response['buttons'] = [
                        'до 30 млн', '30-40 млн', '40-50 млн',
                        '50-60 млн', '60-70 млн', '70-80 млн', 'Не важно'
                    ]
            elif 'комнат' in lowered_text or 'комнаты' in lowered_text:
                is_commercial = (
                    params.get('bi_category') == 'commercial' or
                    params.get('secondary_category') == 'commercial'
                )
                if is_commercial:
                    response = await self._enter_edit_params_menu(
                        session,
                        params,
                        prompt="Для коммерции комнаты не используются. Можно изменить другие параметры."
                    )
                else:
                    await self._update_state(session, 'SETTING_ROOMS', params)
                    response['text'] = "Сколько комнат?"
                    response['buttons'] = ['1', '2', '3', '4+', 'Не важно']
            elif 'площад' in lowered_text:
                await self._update_state(session, 'SETTING_AREA', params)
                is_commercial = (
                    params.get('bi_category') == 'commercial' or
                    params.get('secondary_category') == 'commercial'
                )
                if is_commercial:
                    response['text'] = "Какая площадь нужна? 🏢 (Например: '50-120 м²' или 'до 80 м²')"
                    response['buttons'] = ['до 50 м²', '50-100 м²', '100-200 м²', 'Не важно']
                else:
                    response['text'] = "Какая площадь нужна? 📐 (Например: '45-70 м²' или 'до 60 м²')"
                    response['buttons'] = ['до 40 м²', '40-60 м²', '60-80 м²', '80-100 м²', '100-120 м²', '120+ м²', 'Не важно']
            elif 'класс' in lowered_text:
                # Класс жилья может быть изменен только для BI Group жилых квартир
                if params.get('source') == 'bi' and params.get('bi_category') == 'residential':
                    await self._update_state(session, 'SETTING_CLASS_NAME', params)
                    response['text'] = "Какой класс жилья предпочитаете? 🏠"
                    response['buttons'] = [
                        "Стандарт", "Комфорт",
                        "Бизнес", "Премиум", "Не важно"
                    ]
                else:
                    response = await self._enter_edit_params_menu(
                        session,
                        params,
                        prompt="Класс жилья доступен только для BI Group квартир. Можно изменить другие параметры."
                    )
            elif 'район' in lowered_text or 'местополож' in lowered_text or 'локац' in lowered_text:
                await self._update_state(session, 'SETTING_LOCATION', params)
                response['text'] = "Есть предпочтения по району? 📍\n(Выберите район, берег или напишите ориентир)"
                response['buttons'] = self._location_buttons()
            else:
                response = await self._enter_edit_params_menu(session, params)

        elif state == 'NO_RESULTS':
            if 'эксперт' in text.lower():
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = await BotTextService.aget(
                    "lead.ask_name",
                    fallback="Как тебя зовут?",
                )
            else:
                response = await self._enter_edit_params_menu(session, params)

        elif state == 'LEAD_NAME':
            allowed, denied = await self._check_permission(user, 'request_consultation')
            if not allowed:
                return denied
            snap = snapshot_for_expert_lead(session.search_params or {})
            await sync_to_async(Lead.objects.create)(
                user=user,
                request_text=f"Заявка на эксперта. Контекст поиска: {session.search_params}",
                status='new',
                search_params=session.search_params or {},
                **snap,
            )
            await sync_to_async(ProductAnalyticsService.record)(
                user,
                'lead_expert_request',
                payload={'client_name': (text or '')[:120]},
                search_params=session.search_params or {},
            )
            response['text'] = await BotTextService.aget(
                "lead.submitted",
                fallback="Спасибо, {name}! Менеджер скоро свяжется. 📞",
                name=text,
            )
            response['buttons'] = ['В главное меню']
            await self._update_state(session, 'START', {})

        elif state == 'CONSULTATION_TOPIC':
            consultation = await sync_to_async(
                self.ai.generate_consultation,
                thread_sensitive=False
            )(text)
            if self.ai.consume_quota_error():
                return await self._quota_response()
            response['text'] = consultation
            response['parse_mode'] = 'plain'
            response['buttons'] = []
            await self._update_state(session, 'START', {})

        if response.get('objects'):
            await self._cache_last_objects(session, response['objects'])

            # Автоматический триггер показа анкеты после выдачи объектов
            should_start = await SurveyService.should_start_survey(user)
            if should_start:
                submission = await SurveyService.start_survey(user)
                if submission:
                    params = session.search_params or {}
                    params['survey_submission_id'] = submission.id
                    await self._update_state(session, 'SURVEY_IN_PROGRESS', params)
                    question = await SurveyService.get_next_question(submission)
                    if question:
                        response['text'] = (
                            f"{response.get('text', '')}\n\n"
                            f"📝 {submission.survey.motivation_text or 'Ответьте на короткую анкету, пожалуйста.'}\n\n"
                            f"{SurveyService.question_prompt(question)}"
                        ).strip()
                        response['buttons'] = SurveyService.question_buttons(question) + ['В главное меню']

        return self._ensure_main_menu_button(response, state)

    async def _handle_survey_step(self, user, session, text):
        params = session.search_params or {}
        submission_id = params.get('survey_submission_id')
        if not submission_id:
            await self._update_state(session, 'START', params)
            return await self._scenario_start(user)

        submission = await sync_to_async(
            lambda: FeedbackSurveySubmission.objects.select_related('survey').filter(id=submission_id, user=user).first()
        )()
        if not submission:
            await self._update_state(session, 'START', params)
            return await self._scenario_start(user)

        question = await SurveyService.get_next_question(submission)
        if not question:
            await SurveyService.complete_survey(submission)
            params.pop('survey_submission_id', None)
            await self._update_state(session, 'START', params)
            bonus = submission.survey.bonus_extra_limit
            bonus_text = ""
            if bonus > 0:
                bonus_text = f"\n🎁 Бонус начислен: +{bonus} к суточному лимиту."
            return {
                'text': f"Спасибо! Анкета завершена.{bonus_text}",
                'buttons': ['В главное меню']
            }

        ok, error = await SurveyService.save_answer(submission, question, text)
        if not ok:
            return {
                'text': error,
                'buttons': SurveyService.question_buttons(question) + ['В главное меню']
            }

        next_question = await SurveyService.get_next_question(submission)
        if not next_question:
            await SurveyService.complete_survey(submission)
            params.pop('survey_submission_id', None)
            await self._update_state(session, 'START', params)
            bonus = submission.survey.bonus_extra_limit
            bonus_text = ""
            if bonus > 0:
                bonus_text = f"\n🎁 Бонус начислен: +{bonus} к суточному лимиту."
            return {
                'text': f"Спасибо! Анкета завершена.{bonus_text}",
                'buttons': ['В главное меню']
            }

        return {
            'text': SurveyService.question_prompt(next_question),
            'buttons': SurveyService.question_buttons(next_question) + ['В главное меню']
        }

    async def _cache_last_objects(self, session, objects):
        if not objects:
            return
        payload = [obj.to_dict() for obj in objects]
        params = session.search_params or {}
        params['last_objects'] = payload
        session.search_params = params
        await sync_to_async(session.save)()

    @staticmethod
    def _filter_seen_objects(params: dict, objects):
        if not objects:
            return objects
        seen = set(params.get('seen_object_ids') or [])
        filtered = []
        for obj in objects:
            obj_id = getattr(obj, "object_id", None) or ""
            key = f"{getattr(obj, 'object_kind', '')}:{obj_id}"
            if key in seen:
                continue
            seen.add(key)
            filtered.append(obj)
        params['seen_object_ids'] = list(seen)
        return filtered

    @staticmethod
    def _unpack_complexes_result(search_result, fallback_offset: int):
        if isinstance(search_result, tuple) and len(search_result) == 2:
            return search_result
        complexes = search_result or []
        return complexes, fallback_offset + len(complexes)

    async def process_voice(self, user_id, platform, voice_file_object, user_name=None, telegram_username=None):
        """
        Обрабатывает голосовое сообщение:
        1. Скачивает байты.
        2. Конвертирует OGG -> MP3 (для совместимости).
        3. Транскрибирует через AI.
        4. Вызывает process_message с полученным текстом.
        """
        try:
            # 1. Читаем файл в память (voice_file_object - это уже скачанный файл Telegram)
            voice_bytes = await voice_file_object.download_as_bytearray()

            audio_bytes = bytes(voice_bytes)
            mime_type = "audio/ogg"

            # 2. Конвертация OGG -> MP3 (если доступен ffmpeg/ffprobe)
            # Telegram шлет OGG Opus. Gemini лучше понимает MP3/WAV.
            if which("ffprobe") and which("ffmpeg"):
                try:
                    logger.info("🔄 Converting OGG to MP3...")
                    audio = AudioSegment.from_file(io.BytesIO(voice_bytes), format="ogg")

                    # Экспортируем в MP3 в буфер памяти
                    mp3_io = io.BytesIO()
                    audio.export(mp3_io, format="mp3")
                    audio_bytes = mp3_io.getvalue()
                    mime_type = "audio/mp3"
                except Exception as exc:
                    logger.warning(f"⚠️ OGG->MP3 conversion failed, using OGG: {exc}")
            else:
                logger.warning("⚠️ ffmpeg/ffprobe not found, using OGG directly")

            # 3. Транскрибация
            text = await sync_to_async(
                self.ai.transcribe_audio,
                thread_sensitive=False
            )(audio_bytes, mime_type)

            if text == "__QUOTA_EXCEEDED__":
                return {
                    'text': "Лимит на распознавание аудио исчерпан. 😔 Попробуйте позже или напишите текстом."
                }

            if not text:
                return {'text': "Не удалось разобрать голосовое сообщение. 😔 Попробуйте текстом."}

            normalized_text = self._normalize_voice_text(text)

            # 4. 🔥 ГЛАВНЫЙ ТРЮК: Рекурсия
            # Мы просто скармливаем полученный текст в наш основной метод
            logger.info(f"🗣 Voice recognized as: '{text}' -> '{normalized_text}' -> Delegating to process_message")

            # Добавляем пометку (🎤), чтобы юзер видел, как мы его поняли
            response = await self.process_message(
                user_id, platform, normalized_text, user_name, is_voice=True, telegram_username=telegram_username
            )

            # Модифицируем ответ, добавляя расшифровку
            original_text = response.get('text', '')
            if normalized_text != text:
                response['text'] = f"🎤 *Вы сказали:* \"{text}\"\n*Интерпретация:* \"{normalized_text}\"\n\n{original_text}"
            else:
                response['text'] = f"🎤 *Вы сказали:* \"{text}\"\n\n{original_text}"

            return response

        except Exception as e:
            logger.error(f"❌ Error processing voice: {e}")
            return {'text': "Ошибка обработки аудио. Пожалуйста, напишите текстом."}

    async def _update_state(self, session, new_state, params=None):
        session.current_intent = new_state
        if params is not None:
            session.search_params = params
        await sync_to_async(session.save)()

    @staticmethod
    def _normalize_voice_text(text: str) -> str:
        """
        Нормализует типичные голосовые ответы в команды/варианты.
        """
        if not text:
            return text

        lowered = text.strip().lower()
        is_short = len(lowered) <= 25
        has_choice_words = any(word in lowered for word in ['вариант', 'пункт', 'кнопк', 'номер'])

        # Простые порядковые числительные
        ordinals = {
            'первый': '1',
            'первая': '1',
            'первое': '1',
            'второй': '2',
            'вторая': '2',
            'второе': '2',
            'третий': '3',
            'третья': '3',
            'третье': '3',
        }

        if is_short or has_choice_words:
            for word, number in ordinals.items():
                if word in lowered:
                    return number

        # Типичные фразы выбора
        if is_short or has_choice_words:
            if 'подобрал объект' in lowered or 'подобрать объект' in lowered or lowered == 'подобрать':
                return '1'
            if 'узнать про район' in lowered or 'узнать про районы' in lowered or lowered == 'район':
                return '2'

        return text

    async def _scenario_start(self, user, referral_attached: bool = False):
        name = user.name or 'друг'
        welcome = await BotTextService.aget(
            "start.welcome",
            fallback=(
                "Привет, {name}!\n"
                "Я HomeMe - ИИ-агент по недвижимости в Астане 🏠.\n"
                "Помогу подобрать новостройки BI Group и вторичку, "
                "а ещё расскажу про районы и локации.\n\nЧто хочешь сделать?"
            ),
            name=name,
        )
        if referral_attached and user.invited_by_id:
            referrer = await sync_to_async(
                lambda: BotUser.objects.filter(pk=user.invited_by_id).values_list('name', 'user_id').first()
            )()
            referrer_label = (referrer[0] if referrer and referrer[0] else None) or 'друг'
            referred_note = await BotTextService.aget(
                "referral.welcome_referred",
                fallback="🎉 Вас пригласил {referrer}! Добро пожаловать.\n\n",
                referrer=referrer_label,
            )
            welcome = f"{referred_note}{welcome}"
        return {
            'text': welcome,
            'buttons': ['1. Подобрать объект', '⭐ Избранные', '2. Узнать про районы', '🔗 Поделиться с другом']
        }

    @staticmethod
    async def _quota_response():
        return {
            'text': await BotTextService.aget(
                "error.ai_quota_exceeded",
                fallback="Лимит запросов к AI исчерпан. 😔 Попробуйте позже или напишите текстом.",
            )
        }

    async def _format_intro(self, results, params):
        source = params.get('source', 'mixed')
        secondary_category = params.get('secondary_category')
        if source == 'secondary':
            if secondary_category == 'commercial':
                return await BotTextService.aget(
                    "search.results.secondary_commercial",
                    fallback="Нашел {count} коммерческих объектов на вторичном рынке: 👇",
                    count=len(results),
                )
            return await BotTextService.aget(
                "search.results.secondary_apartments",
                fallback="Нашел {count} квартир на вторичном рынке: 👇",
                count=len(results),
            )
        return await BotTextService.aget(
            "search.results.default",
            fallback="Нашел {count} вариантов: 👇",
            count=len(results),
        )

    def _has_search_intent(self, params: dict, text: str) -> bool:
        keywords = ['найди', 'поиск', 'квартира', 'жк', 'офис', 'помещение', 'вторич']
        if any(k in text.lower() for k in keywords):
            return True
        return any(params.get(k) for k in ['min_price', 'max_price', 'rooms', 'min_area', 'max_area', 'coordinates'])

    async def _apply_voice_ai_params(self, text: str, params: dict):
        extracted = await sync_to_async(
            self.ai.extract_search_parameters,
            thread_sensitive=False
        )(text)
        if self.ai.consume_quota_error():
            return None

        location_data = await sync_to_async(
            self.location_resolver.resolve_any_location,
            thread_sensitive=False
        )(text, city_hint="Astana")
        if self.ai.consume_quota_error():
            return None

        if extracted:
            params.update({k: v for k, v in extracted.items() if v is not None})

        if location_data:
            center = location_data.get('center_coordinates')
            radius_km = location_data.get('search_radius_km')
            if center:
                params['coordinates'] = {'lat': center[0], 'lon': center[1]}
                params['radius_km'] = radius_km or 3.0
            params['embedding_text'] = text

        lowered = text.lower()
        if any(word in lowered for word in ['офис', 'коммер', 'помещение', 'бизнес', 'retail', 'стрит']):
            params['source'] = 'bi'
            params['bi_category'] = 'commercial'
            params['bi_scope'] = 'both'
        elif 'вторич' in lowered:
            params['source'] = 'secondary'
        else:
            params['source'] = params.get('source', 'mixed')

        return params

    async def _run_search_with_params(self, session, params, user=None):
        response = {'text': '', 'buttons': [], 'objects': []}

        params['offset'] = 0
        params['city'] = 'Astana'
        params['seen_object_ids'] = []

        if user is not None:
            allowed, denied = await self._check_permission(user, 'search_properties')
            if not allowed:
                return denied

        # Проверяем лимит ДО поиска
        if user is not None:
            remaining = await sync_to_async(LimitService.get_remaining_total)(user)
            if remaining <= 0:
                msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                response['text'] = msg
                response['buttons'] = ['В главное меню']
                return response

        if params.get('source') == 'bi':
            complex_offset = params.get('complex_offset', 0)
            search_result = await sync_to_async(
                self.search.search_complexes,
                thread_sensitive=False
            )(params, offset=complex_offset, limit=5)
            complexes, next_offset = self._unpack_complexes_result(search_result, complex_offset)

            if complexes:
                params['complex_offset'] = next_offset
                mapped = await sync_to_async(
                    self.search.map_complexes_to_dto,
                    thread_sensitive=False
                )(params, complexes)
                mapped = self._filter_seen_objects(params, mapped)

                # Применяем лимит
                if user is not None:
                    mapped, remaining, blocked = await sync_to_async(
                        LimitService.apply_limit)(user, mapped, params)
                    if blocked or not mapped:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return response

                response['objects'] = mapped
                allowed_ids = {obj.object_id for obj in mapped if obj.object_id}
                complexes_for_candidates = [c for c in complexes if c.bi_uuid in allowed_ids]
                params['complex_candidates'] = self._merge_complex_candidates(
                    params.get('complex_candidates'),
                    self._serialize_complexes(complexes_for_candidates)
                )
                await self._update_state(session, 'COMPLEX_RESULTS', params)
                response['text'] = self._format_complexes_intro(params)
                response['buttons'] = self._complex_action_buttons(params)
            else:
                await self._update_state(session, 'NO_RESULTS', params)
                if params.get('coordinates'):
                    location_label = params.get('embedding_text', 'указанной локации')
                    response['text'] = (
                        f"Не удалось найти объекты рядом с \"{location_label}\" "
                        f"в радиусе {params.get('radius_km', '')} км. 😔\n\n"
                        "Варианты действий:"
                    )
                else:
                    response['text'] = (
                        f"По запросу (до {params.get('max_price', '')} ₸) ничего не найдено. 😔\n\n"
                        "Варианты действий:"
                    )
                response['buttons'] = ['Изменить параметры поиска']
        elif params.get('source') == 'mixed':
            params['bi_offset'] = 0
            params['secondary_offset'] = 0
            results, new_bi_offset, new_secondary_offset = await sync_to_async(
                self.search.intelligent_search_mixed,
                thread_sensitive=False
            )(params, bi_offset=0, secondary_offset=0)

            if results:
                results = self._filter_seen_objects(params, results)

                # Применяем лимит
                if user is not None:
                    results, remaining, blocked = await sync_to_async(
                        LimitService.apply_limit)(user, results, params)
                    if blocked or not results:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return response

                params['bi_offset'] = new_bi_offset
                params['secondary_offset'] = new_secondary_offset
                await self._update_state(session, 'BROWSING', params)

                response['text'] = await self._format_intro(results, params)
                response['objects'] = results
                response['buttons'] = ['Показать ещё', 'Изменить параметры поиска']
            else:
                await self._update_state(session, 'NO_RESULTS', params)
                if params.get('coordinates'):
                    location_label = params.get('embedding_text', 'указанной локации')
                    response['text'] = (
                        f"Не удалось найти объекты рядом с \"{location_label}\" "
                        f"в радиусе {params.get('radius_km', '')} км. 😔\n\n"
                        "Варианты действий:"
                    )
                else:
                    response['text'] = (
                        f"По запросу (до {params.get('max_price', '')} ₸) ничего не найдено. 😔\n\n"
                        "Варианты действий:"
                    )
                response['buttons'] = ['Изменить параметры поиска']
        else:
            results = await sync_to_async(
                self.search.intelligent_search,
                thread_sensitive=False
            )(params, offset=0)

            if results:
                results = self._filter_seen_objects(params, results)

                # Применяем лимит
                if user is not None:
                    results, remaining, blocked = await sync_to_async(
                        LimitService.apply_limit)(user, results, params)
                    if blocked or not results:
                        msg = await sync_to_async(LimitService.limit_exceeded_message)(user)
                        response['text'] = msg
                        response['buttons'] = ['В главное меню']
                        return response

                params['offset'] = len(results)
                await self._update_state(session, 'BROWSING', params)

                response['text'] = await self._format_intro(results, params)
                response['objects'] = results
                response['buttons'] = ['Показать ещё', 'Изменить параметры поиска']
            else:
                await self._update_state(session, 'NO_RESULTS', params)
                if params.get('coordinates'):
                    location_label = params.get('embedding_text', 'указанной локации')
                    response['text'] = (
                        f"Не удалось найти объекты рядом с \"{location_label}\" "
                        f"в радиусе {params.get('radius_km', '')} км. 😔\n\n"
                        "Варианты действий:"
                    )
                else:
                    response['text'] = (
                        f"По запросу (до {params.get('max_price', '')} ₸) ничего не найдено. 😔\n\n"
                        "Варианты действий:"
                    )
                response['buttons'] = ['Изменить параметры поиска']

        if user is not None:
            await self._emit_search_analytics(user, params, response)
        return response

    async def _emit_show_more(self, user, params):
        await sync_to_async(ProductAnalyticsService.record)(
            user,
            BotProductEvent.EVENT_SHOW_MORE,
            payload={},
            search_params=params,
        )

    async def _emit_search_analytics(self, user, params, response):
        text = (response.get('text') or '').lower()
        objs = response.get('objects') or []
        n = len(objs)
        raw = response.get('text') or ''
        if 'лимит' in text or 'исчерп' in text or '⛔' in raw:
            await sync_to_async(ProductAnalyticsService.record)(
                user, 'limit_hit', payload={}, search_params=params)
            return
        if n > 0:
            await sync_to_async(ProductAnalyticsService.record)(
                user,
                BotProductEvent.EVENT_SEARCH,
                payload={'results_count': n},
                search_params=params,
            )
        elif 'ничего не найдено' in text or 'не удалось найти' in text:
            await sync_to_async(ProductAnalyticsService.record)(
                user,
                BotProductEvent.EVENT_NO_RESULTS,
                payload={},
                search_params=params,
            )

    @staticmethod
    def _serialize_complexes(complexes):
        return [
            {
                "id": str(c.id),
                "name": c.name,
                "address": c.address,
            }
            for c in complexes
        ]

    def _format_complexes_intro(self, params):
        label = "БЦ" if params.get('bi_category') == 'commercial' else "ЖК"
        count = len(params.get('complex_candidates') or [])
        action = "помещения" if params.get('bi_category') == 'commercial' else "квартиры"
        return f"Нашел {count} {label}. Нажмите «Показать {action}», чтобы выбрать конкретный объект."

    def _format_complexes_list(self, params):
        label = "БЦ" if params.get('bi_category') == 'commercial' else "ЖК"
        candidates = params.get('complex_candidates') or []
        lines = [f"Выберите номер {label}, чтобы посмотреть варианты:"]
        for idx, item in enumerate(candidates, start=1):
            address = item.get('address') or ''
            lines.append(f"{idx}. {label} {item.get('name')} — {address}")
        return "\n".join(lines)

    def _complex_action_buttons(self, params):
        if params.get('bi_category') == 'commercial':
            return ['Показать помещения', 'Показать ещё', 'Изменить параметры поиска']
        return ['Показать квартиры', 'Показать ещё', 'Изменить параметры поиска']

    @staticmethod
    def _complex_number_buttons(params):
        candidates = params.get('complex_candidates') or []
        buttons = [str(i) for i in range(1, min(len(candidates), 10) + 1)]
        buttons.append('Изменить параметры поиска')
        return buttons

    @staticmethod
    def _parse_choice(text):
        try:
            return int(text.strip())
        except Exception:
            return None

    @staticmethod
    def _parse_budget_text(text: str):
        """
        Парсинг бюджета без AI.
        Поддержка: "до X млн", "от X млн", "X+ млн", "X-Y млн", "X млн".
        """
        if not text or text == 'Не важно':
            return {}

        cleaned = text.lower().replace("млн", "").replace("миллион", "").replace("миллиона", "").replace("миллионов", "")
        cleaned = cleaned.replace(" ", "")

        def to_amount(value: str):
            try:
                value = value.replace(",", ".")
                return float(value) * 1_000_000
            except Exception:
                return None

        if "-" in cleaned:
            parts = cleaned.split("-", 1)
            min_v = to_amount(parts[0])
            max_v = to_amount(parts[1])
            if min_v or max_v:
                return {"min_price": min_v, "max_price": max_v}

        if cleaned.startswith("до") or cleaned.startswith("меньше"):
            max_v = to_amount(cleaned.replace("до", ""))
            if max_v:
                return {"max_price": max_v}

        if cleaned.startswith("от") or cleaned.startswith("больше"):
            min_v = to_amount(cleaned.replace("от", ""))
            if min_v:
                return {"min_price": min_v}

        if cleaned.endswith("+"):
            min_v = to_amount(cleaned[:-1])
            if min_v:
                return {"min_price": min_v}

        value = to_amount(cleaned)
        if value:
            return {"max_price": value}

        return {}

    @staticmethod
    def _parse_area_text(text: str):
        """
        Парсинг площади без AI.
        Поддержка: "до X м2", "от X м2", "X+ м2", "X-Y м2", "X м2".
        """
        if not text:
            return {}

        cleaned = text.lower()
        for token in ["м2", "м²", "квм", "кв.м", "кв. м", "м", "метр", "метров", "метра"]:
            cleaned = cleaned.replace(token, "")
        cleaned = cleaned.replace(" ", "")

        def to_value(value: str):
            try:
                value = value.replace(",", ".")
                return float(value)
            except Exception:
                return None

        if "-" in cleaned:
            parts = cleaned.split("-", 1)
            min_v = to_value(parts[0])
            max_v = to_value(parts[1])
            if min_v or max_v:
                return {"min_area": min_v, "max_area": max_v}

        if cleaned.startswith("до"):
            max_v = to_value(cleaned.replace("до", ""))
            if max_v:
                return {"max_area": max_v}

        if cleaned.startswith("от"):
            min_v = to_value(cleaned.replace("от", ""))
            if min_v:
                return {"min_area": min_v}

        if cleaned.endswith("+"):
            min_v = to_value(cleaned[:-1])
            if min_v:
                return {"min_area": min_v}

        value = to_value(cleaned)
        if value:
            return {"max_area": value}

        return {}

    @staticmethod
    def _parse_rooms_text(text: str):
        """
        Парсинг количества комнат с поддержкой множественного выбора.
        Поддержка: "2-3", "4-5", "1,2,3", "1", "5+", "2,3,4"
        Возвращает список чисел или None
        """
        if not text:
            return None

        cleaned = text.lower().replace(" ", "").replace("комнат", "").replace("комнаты", "").replace("комната", "")
        
        # Обработка диапазона (например, "2-3")
        if "-" in cleaned:
            parts = cleaned.split("-", 1)
            try:
                start = int(parts[0])
                end_str = parts[1].replace("+", "")
                end = int(end_str)
                # Генерируем список от start до end включительно
                return list(range(start, end + 1))
            except (ValueError, IndexError):
                return None
        
        # Обработка списка через запятую (например, "1,2,3")
        if "," in cleaned:
            try:
                rooms_list = [int(x.strip()) for x in cleaned.split(",") if x.strip().isdigit()]
                return rooms_list if rooms_list else None
            except ValueError:
                return None
        
        # Обработка "5+" - возвращаем [5, 6, 7, 8, 9, 10] (до 10 комнат)
        if cleaned.endswith("+"):
            try:
                start = int(cleaned[:-1])
                return list(range(start, 11))  # От указанного числа до 10
            except ValueError:
                return None
        
        # Обработка одного числа
        try:
            room_num = int(cleaned)
            return [room_num]
        except ValueError:
            return None

    def _random_prompt(self, *variants):
        return random.choice([v for v in variants if v])

    async def _ai_fallback_parse(self, text: str, fields: list):
        extracted = await sync_to_async(
            self.ai.extract_search_parameters,
            thread_sensitive=False
        )(text)
        if self.ai.consume_quota_error():
            return None
        if not extracted:
            return {}
        return {k: extracted.get(k) for k in fields if extracted.get(k) is not None}

    @staticmethod
    def _location_buttons():
        return [
            'Левый берег', 'Правый берег',
            'Есильский', 'Сарыаркинский',
            'Алматинский', 'Байконурский',
            'Нура', 'Сарайшык',
            'Не важно', 'В главное меню'
        ]

    @staticmethod
    def _is_edit_params_command(text: str) -> bool:
        if not text:
            return False
        lowered_text = text.strip().lower()
        return 'изменить параметры поиска' in lowered_text or lowered_text == 'изменить параметры'

    @staticmethod
    def _edit_params_buttons(params: dict):
        buttons = ['Изменить бюджет']
        is_commercial = (
            params.get('bi_category') == 'commercial' or
            params.get('secondary_category') == 'commercial'
        )
        # Кнопка "Изменить класс жилья" только для BI Group жилых квартир
        if params.get('source') == 'bi' and params.get('bi_category') == 'residential':
            buttons.extend(['Изменить комнаты', 'Изменить класс жилья'])
        elif not is_commercial:
            buttons.append('Изменить комнаты')
        buttons.extend(['Изменить площадь', 'Изменить район', 'Искать'])
        return buttons

    async def _enter_edit_params_menu(self, session, params: dict, prompt: str | None = None):
        params['edit_mode'] = True
        await self._update_state(session, 'EDITING_PARAMS_MENU', params)
        return {
            'text': prompt or (
                "Что хотите изменить? Можно менять несколько параметров.\n"
                "Когда готовы — нажмите «Искать»."
            ),
            'buttons': self._edit_params_buttons(params)
        }

    @staticmethod
    def _normalize_admin_district(text: str):
        """
        Нормализует район на значения, которые есть в БД.
        Возвращает каноническое имя района.
        """
        if not text:
            return None
        lowered = text.strip().lower()
        
        # Маппинг на базовые значения, которые реально есть в БД
        mapping = {
            'алматинский': 'Алматинский',
            'сарыаркинский': 'Сарыарка',  # В BI это "Сарыарка", во вторичке "Сарыаркинский"
            'сарыарка': 'Сарыарка',
            'есильский район': 'Есильский',
            'есильский': 'Есильский',
            'байконурский': 'Байконурский',
            'нуринский': 'Нура',  # В БД везде "Нура"
            'нура': 'Нура',
            'сарайшық': 'Сарайшық',
            'сарайшык': 'Сарайшық',
        }
        for key, value in mapping.items():
            if key in lowered:
                return value
        return None

    @staticmethod
    def _merge_complex_candidates(existing, new_items):
        existing = existing or []
        existing_ids = {item.get('id') for item in existing}
        merged = list(existing)
        for item in new_items:
            if item.get('id') not in existing_ids:
                merged.append(item)
        return merged

    @staticmethod
    def _ensure_main_menu_button(response: dict, state: str) -> dict:
        if not response:
            return response
        if state == 'START':
            return response

        buttons = response.get('buttons') or []
        if 'В главное меню' not in buttons:
            buttons = list(buttons)
            buttons.append('В главное меню')
            response['buttons'] = buttons
        return response