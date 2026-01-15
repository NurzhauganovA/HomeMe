from typing import Dict

from core.services.ai_service import EnhancedAIService
from core.services.search_service import EnhancedSearchService
from core.location_resolver import DynamicLocationResolver, create_location_filter_for_search
from telegram_bot.models import BotUser, UserSession, Lead
from asgiref.sync import sync_to_async
import logging

logger = logging.getLogger(__name__)


class EnhancedDialogManager:
    """
    Профессиональный менеджер диалогов с многоступенчатым AI-анализом.
    Обеспечивает естественное общение и точный поиск недвижимости.
    """

    def __init__(self):
        self.ai = EnhancedAIService()
        self.search = EnhancedSearchService(self.ai)
        self.location_resolver = DynamicLocationResolver(self.ai)

    async def process_message(self, user_id: str, platform: str, text: str,
                              user_name: str = None) -> dict:
        """
        Главный метод обработки сообщений.

        Returns:
            dict: {
                'text': str,
                'buttons': list,
                'objects': list[PropertyDTO],
                'show_typing': bool
            }
        """
        logger.info(f"📨 Processing message from {user_id}: {text[:50]}...")

        # ========== ИНИЦИАЛИЗАЦИЯ ПОЛЬЗОВАТЕЛЯ ==========
        user, created = await sync_to_async(BotUser.objects.get_or_create)(
            user_id=str(user_id),
            platform=platform,
            defaults={'name': user_name}
        )

        if created:
            logger.info(f"👤 New user registered: {user_name}")

        session, _ = await sync_to_async(UserSession.objects.get_or_create)(user=user)

        # ========== COMPREHENSIVE AI ANALYSIS ==========
        # Передаем текущую сессию как контекст
        context = {
            'previous_params': session.search_params,
            'current_intent': session.current_intent,
            'city': session.search_params.get('city'),
            'district': session.search_params.get('district')
        }

        logger.info("🧠 Running comprehensive AI analysis...")
        analysis = await sync_to_async(self.ai.analyze_query_comprehensive)(text, context)

        intent = analysis.get('intent', 'greeting')
        logger.info(f"🎯 Detected intent: {intent}")

        # Обновляем сессию
        session.current_intent = intent
        await sync_to_async(session.save)()

        # ========== СЦЕНАРИИ ==========

        if intent == 'greeting':
            return await self._handle_greeting(user, text)

        elif intent in ['search_objects', 'refine_search']:
            return await self._handle_search(user, session, text, analysis)

        elif intent == 'consult_location':
            return await self._handle_consultation(text, analysis)

        elif intent == 'contact_expert':
            return await self._handle_expert_contact(user, text)

        else:
            return await self._handle_fallback(text)

    async def _handle_greeting(self, user: BotUser, text: str) -> dict:
        """Обработка приветствия"""
        name = user.name or 'друг'

        greeting_text = (
            f"Привет, {name}! 👋\n\n"
            f"Я HomeMe — ваш умный помощник по недвижимости в Казахстане.\n\n"
            f"🔍 Я могу найти идеальную квартиру, учитывая все ваши пожелания:\n"
            f"• Местоположение (даже если вы скажете 'рядом с EXPO')\n"
            f"• Lifestyle-предпочтения ('тихо', 'для семьи', 'рядом с парком')\n"
            f"• Бюджет и параметры\n\n"
            f"🏢 Расскажу о любом районе\n"
            f"👨‍💼 Свяжу с экспертом при необходимости\n\n"
            f"Просто напишите, что вы ищете — я понимаю естественный язык!"
        )

        return {
            'text': greeting_text,
            'buttons': [
                '🔍 Найти квартиру',
                '🏢 Узнать о районах',
                '👨‍💼 Связаться с экспертом'
            ],
            'objects': [],
            'show_typing': False
        }

    async def _handle_search(self, user: BotUser, session: UserSession,
                             text: str, analysis: Dict) -> dict:
        """Обработка поиска недвижимости"""

        # Обновляем параметры поиска в сессии
        search_params = session.search_params

        # Дополнительный AI-резолв локаций (EXPO, "левый берег" и т.д.)
        city_hint = analysis.get('city') or search_params.get('city')
        location_data = self.location_resolver.resolve_any_location(text, city_hint=city_hint)
        location_filter = create_location_filter_for_search(location_data)

        # Обогащаем analysis локационными данными для поиска и кэша сессии
        if location_filter.get('city') and not analysis.get('city'):
            analysis['city'] = location_filter['city']
        if location_filter.get('district') and not analysis.get('district'):
            analysis['district'] = location_filter['district']
        if location_filter.get('coordinates'):
            lat, lon = location_filter['coordinates']
            analysis['coordinates'] = {'lat': lat, 'lon': lon}
        if location_filter.get('radius_km'):
            analysis['radius_km'] = location_filter['radius_km']

        if location_filter.get('text_keywords'):
            extra_keywords = location_filter.get('text_keywords', [])
            merged_keywords = list({*analysis.get('semantic_keywords', []), *extra_keywords})
            analysis['semantic_keywords'] = merged_keywords

        # Мерджим новые данные
        if analysis.get('city'):
            search_params['city'] = analysis['city']
        if analysis.get('district'):
            search_params['district'] = analysis['district']
        if analysis.get('rooms'):
            search_params['rooms'] = analysis['rooms']
        if analysis.get('max_price'):
            search_params['max_price'] = analysis['max_price']
        if analysis.get('min_price'):
            search_params['min_price'] = analysis['min_price']
        if analysis.get('min_area'):
            search_params['min_area'] = analysis['min_area']
        if analysis.get('max_area'):
            search_params['max_area'] = analysis['max_area']

        # Сохраняем lifestyle и semantic данные
        search_params['lifestyle_tags'] = analysis.get('lifestyle_tags', [])
        search_params['semantic_keywords'] = analysis.get('semantic_keywords', [])
        search_params['embedding_text'] = analysis.get('embedding_text', text)
        if analysis.get('coordinates'):
            search_params['coordinates'] = analysis['coordinates']
        if analysis.get('radius_km'):
            search_params['radius_km'] = analysis['radius_km']

        session.search_params = search_params
        await sync_to_async(session.save)()

        # ========== ВЫПОЛНЯЕМ ПОИСК ==========
        logger.info("🔍 Executing intelligent search...")

        results = await sync_to_async(self.search.intelligent_search)(
            analysis_result=analysis,
            limit=7
        )

        # ========== ФОРМИРУЕМ ОТВЕТ ==========
        if results:
            # Формируем описание параметров поиска
            params_desc = self._format_search_params(analysis)

            response_text = (
                f"Нашел {len(results)} {'вариант' if len(results) == 1 else 'варианта' if len(results) < 5 else 'вариантов'} "
                f"по вашему запросу:\n\n{params_desc}\n\n"
                f"Объекты отсортированы по релевантности 👇"
            )

            buttons = [
                '🔍 Показать ещё',
                '🔄 Изменить параметры',
                '👨‍💼 Связаться с экспертом'
            ]
        else:
            response_text = self._generate_no_results_message(analysis)
            buttons = [
                '🔄 Изменить параметры',
                '🏢 Узнать о районах',
                '👨‍💼 Связаться с экспертом'
            ]

        return {
            'text': response_text,
            'buttons': buttons,
            'objects': results,
            'show_typing': True
        }

    async def _handle_consultation(self, text: str, analysis: Dict) -> dict:
        """Обработка консультации по районам"""

        location_info = {
            'city': analysis.get('city'),
            'district': analysis.get('district'),
            'nearby_landmarks': analysis.get('nearby_landmarks', [])
        }

        logger.info("💬 Generating consultation...")
        consultation = await sync_to_async(self.ai.generate_consultation)(text, location_info)

        return {
            'text': consultation,
            'buttons': [
                '🔍 Искать здесь жилье',
                '🏢 Другой район',
                '👨‍💼 Связаться с экспертом'
            ],
            'objects': [],
            'show_typing': True
        }

    async def _handle_expert_contact(self, user: BotUser, text: str) -> dict:
        """Обработка запроса на связь с экспертом"""

        # Создаем лид в базе
        await sync_to_async(Lead.objects.create)(
            user=user,
            request_text=text
        )

        logger.info(f"📋 Lead created for user {user.name}")

        return {
            'text': (
                "✅ Заявка принята!\n\n"
                "Наш менеджер свяжется с вами в ближайшее время.\n"
                "Обычно это занимает 10-15 минут в рабочее время.\n\n"
                "Пока ждете, можете продолжить поиск или узнать о районах 👇"
            ),
            'buttons': [
                '🔍 Продолжить поиск',
                '🏢 Узнать о районах'
            ],
            'objects': [],
            'show_typing': False
        }

    async def _handle_fallback(self, text: str) -> dict:
        """Обработка непонятных запросов"""
        return {
            'text': (
                "Извините, я не совсем понял ваш запрос 🤔\n\n"
                "Я могу помочь вам:\n"
                "• Найти квартиру (просто опишите, что вы хотите)\n"
                "• Рассказать о районах\n"
                "• Связать с экспертом\n\n"
                "Попробуйте переформулировать или выберите действие ниже:"
            ),
            'buttons': [
                '🔍 Найти квартиру',
                '🏢 О районах',
                '👨‍💼 Эксперт'
            ],
            'objects': [],
            'show_typing': False
        }

    def _format_search_params(self, analysis: Dict) -> str:
        """Форматирование параметров поиска для отображения пользователю"""
        parts = []

        if analysis.get('city'):
            parts.append(f"📍 {analysis['city']}")

        if analysis.get('district'):
            parts.append(f"🏘 {analysis['district']}")

        if analysis.get('rooms'):
            parts.append(f"🛏 {analysis['rooms']}-комн")

        if analysis.get('max_price'):
            price_mln = analysis['max_price'] / 1_000_000
            parts.append(f"💰 до {price_mln:.0f} млн ₸")

        if analysis.get('min_area') or analysis.get('max_area'):
            area_str = f"📐 "
            if analysis.get('min_area'):
                area_str += f"от {analysis['min_area']}"
            if analysis.get('max_area'):
                area_str += f" до {analysis['max_area']}"
            area_str += " м²"
            parts.append(area_str)

        lifestyle = analysis.get('lifestyle_tags', [])
        if lifestyle:
            tags_emoji = {
                'quiet': '🤫',
                'family': '👨‍👩‍👧',
                'park': '🌳',
                'metro': '🚇',
                'view': '🌆'
            }
            lifestyle_str = " ".join([tags_emoji.get(tag, '✨') for tag in lifestyle[:3]])
            parts.append(lifestyle_str)

        return " • ".join(parts) if parts else "Все параметры"

    def _generate_no_results_message(self, analysis: Dict) -> str:
        """Генерация сообщения когда ничего не найдено"""
        suggestions = []

        if analysis.get('max_price'):
            price_mln = analysis['max_price'] / 1_000_000
            new_price = int(price_mln * 1.3)
            suggestions.append(f"• Увеличить бюджет до {new_price} млн ₸")

        if analysis.get('district'):
            suggestions.append("• Рассмотреть соседние районы")

        if analysis.get('rooms'):
            suggestions.append(
                f"• Посмотреть {analysis['rooms'] - 1 if analysis['rooms'] > 1 else analysis['rooms'] + 1}-комнатные")

        suggestions_text = "\n".join(suggestions) if suggestions else ""

        return (
            "К сожалению, по вашим параметрам пока ничего не нашлось 😔\n\n"
            "Попробуйте:\n"
            f"{suggestions_text}\n\n"
            "Или свяжитесь с нашим экспертом — он найдет варианты вручную!"
        )