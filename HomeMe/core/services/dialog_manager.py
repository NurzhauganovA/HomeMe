import logging
from asgiref.sync import sync_to_async

from core.location_resolver import DynamicLocationResolver
from telegram_bot.models import BotUser, UserSession, Lead
from core.services.ai_service import EnhancedAIService
from core.services.search_service import EnhancedSearchService

logger = logging.getLogger(__name__)


class EnhancedDialogManager:
    def __init__(self):
        self.ai = EnhancedAIService()
        self.search = EnhancedSearchService(self.ai)
        self.location_resolver = DynamicLocationResolver(self.ai)

    async def process_message(self, user_id, platform, text, user_name=None):
        user, _ = await sync_to_async(BotUser.objects.get_or_create)(
            user_id=str(user_id),
            platform=platform,
            defaults={'name': user_name}
        )
        session, _ = await sync_to_async(UserSession.objects.get_or_create)(user=user)

        state = session.current_intent or 'START'
        params = session.search_params or {}

        response = {'text': '', 'buttons': [], 'objects': []}

        # Глобальные команды
        if text.lower() in ['/start', 'привет', 'меню', 'start', 'reset']:
            await self._update_state(session, 'START', {})
            return self._scenario_start(user.name or 'друг')

        # --- МАШИНА СОСТОЯНИЙ ---

        if state == 'START':
            if text == '1' or 'подобрать' in text.lower():
                await self._update_state(session, 'CHOOSING_TYPE')
                response[
                    'text'] = "Отлично! Что будем смотреть?\n\n1. Новостройки BI Group 🏗\n2. Вторичка 🏠\n3. Смешанный поиск ⭐"
                response['buttons'] = ['1. BI Group', '2. Вторичка', '3. Смешанный']

            elif text == '2' or 'район' in text.lower():
                await self._update_state(session, 'CONSULTATION_TOPIC')
                response['text'] = "Про какой район рассказать? (Например: 'Есильский', 'EXPO')"
                response['buttons'] = ['Левый берег', 'Есильский', 'EXPO']

            elif text == '3' or 'эксперт' in text.lower():
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = "Я соединю тебя с экспертом. Как к тебе обращаться?"

            else:
                return self._scenario_start(user.name)

        elif state == 'CHOOSING_TYPE':
            if '1' in text or 'bi' in text.lower():
                params['source'] = 'bi'
            elif '2' in text or 'вторич' in text.lower():
                params['source'] = 'secondary'
            else:
                params['source'] = 'mixed'

            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = "Какой бюджет? 💰 (Например: '45-60' или 'до 50' млн)"
            response['buttons'] = ['до 30 млн', '30-50 млн', '50-80 млн']

        elif state == 'SETTING_BUDGET':
            extracted = await sync_to_async(self.ai.extract_search_parameters)(text)
            if extracted.get('max_price') or extracted.get('min_price'):
                params.update(extracted)
                await self._update_state(session, 'SETTING_ROOMS', params)
                response['text'] = "Сколько комнат? 🛏"
                response['buttons'] = ['1', '2', '3', '4+', 'Не важно']
            else:
                response['text'] = "Не понял сумму. Напиши просто цифрами, например '50 млн'."

        elif state == 'SETTING_ROOMS':
            if '1' in text:
                params['rooms'] = 1
            elif '2' in text:
                params['rooms'] = 2
            elif '3' in text:
                params['rooms'] = 3
            elif '4' in text:
                params['rooms'] = 4

            await self._update_state(session, 'SETTING_LOCATION', params)
            response['text'] = "Есть предпочтения по району? 📍\n('Левый берег', 'EXPO' или 'Не важно')"
            response['buttons'] = ['Левый берег', 'Есильский', 'EXPO', 'Не важно']

        elif state == 'SETTING_LOCATION':
            if 'не важно' not in text.lower():
                params['embedding_text'] = text

                location_data = self.location_resolver.resolve_any_location(text, city_hint="Astana")

                if location_data and location_data.get('coordinates_estimate'):
                    params['coordinates'] = location_data['coordinates_estimate']
                    params['radius_km'] = location_data.get('radius_km', 2.5)
                    logger.info(f"📍 Coordinates found for '{text}': {params['coordinates']}")
                else:
                    # Если координаты не найдены (например, "тихий район"), удаляем старые, чтобы не мешали
                    params.pop('coordinates', None)

            # Сброс пагинации перед новым поиском
            params['offset'] = 0
            params['city'] = 'Astana'  # Hardcode MVP

            # ЗАПУСК ПОИСКА
            results = await sync_to_async(self.search.intelligent_search)(params, offset=0)

            if results:
                # Увеличиваем offset на длину полученных результатов
                params['offset'] = len(results)
                await self._update_state(session, 'BROWSING', params)

                response['text'] = self._format_intro(results, params)
                response['objects'] = results
                response['buttons'] = ['Показать ещё', 'Изменить бюджет', 'Связаться с экспертом']
            else:
                # Если 0 результатов
                await self._update_state(session, 'NO_RESULTS', params)
                response['text'] = (
                    f"По запросу (до {params.get('max_price', '')} ₸) ничего не найдено. 😔\n\n"
                    "Варианты действий:"
                )
                response['buttons'] = ['Увеличить бюджет', 'Изменить комнаты', 'Связаться с экспертом']

        elif state == 'BROWSING':
            if text.lower() in ['показать еще', 'показать ещё', 'еще', 'дальше', 'ещё']:
                current_offset = params.get('offset', 0)

                # Поиск следующей страницы
                results = await sync_to_async(self.search.intelligent_search)(params, offset=current_offset)

                if results:
                    params['offset'] = current_offset + len(results)
                    await self._update_state(session, 'BROWSING', params)

                    response['text'] = "Вот еще варианты: 👇"
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Изменить параметры', 'Связаться с экспертом']
                else:
                    response['text'] = "Варианты по этому запросу закончились. 🤷‍♂️"
                    response['buttons'] = ['Изменить параметры', 'Связаться с экспертом']

            elif 'бюджет' in text.lower() or 'параметр' in text.lower():
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Напиши новый бюджет:"

            elif 'эксперт' in text.lower():
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = "Как к тебе обращаться?"
            else:
                return self._scenario_start(user.name)

        elif state == 'NO_RESULTS':
            if 'бюджет' in text.lower():
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Какой новый бюджет?"
            elif 'комнат' in text.lower():
                await self._update_state(session, 'SETTING_ROOMS', params)
                response['text'] = "Сколько комнат?"
            elif 'эксперт' in text.lower():
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = "Как тебя зовут?"

        elif state == 'LEAD_NAME':
            await sync_to_async(Lead.objects.create)(
                user=user,
                request_text=f"Заявка на эксперта. Контекст поиска: {session.search_params}",
                status='new'
            )
            response['text'] = f"Спасибо, {text}! Менеджер скоро свяжется. 📞"
            response['buttons'] = ['В главное меню']
            await self._update_state(session, 'START', {})

        elif state == 'CONSULTATION_TOPIC':
            consultation = await sync_to_async(self.ai.generate_consultation)(text)
            response['text'] = consultation
            response['buttons'] = ['Искать здесь', 'В меню']
            await self._update_state(session, 'START', {})

        return response

    async def _update_state(self, session, new_state, params=None):
        session.current_intent = new_state
        if params is not None:
            session.search_params = params
        await sync_to_async(session.save)()

    def _scenario_start(self, name):
        return {
            'text': f"Привет, {name}!\nЯ HomeMe - ИИ-агент по недвижимости в Астане 🏠.\nПомогу подобрать новостройки BI Group и вторичку, а ещё расскажу про районы и локации.\n\nЧто хочешь сделать?",
            'buttons': ['1. Подобрать объект', '2. Узнать про районы', '3. Связаться с экспертом']
        }

    def _format_intro(self, results, params):
        return f"Нашел {len(results)} вариантов (сгруппировано по ЖК): 👇"