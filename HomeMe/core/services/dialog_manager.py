from core.services.ai_service import AIService
from core.services.search_service import UnifiedSearchService
from telegram_bot.models import BotUser, UserSession, Lead
from asgiref.sync import sync_to_async


class DialogManager:
    def __init__(self):
        self.ai = AIService()
        self.search_service = UnifiedSearchService()

    async def process_message(self, user_id: str, platform: str, text: str, user_name: str = None) -> dict:
        """
        Главный метод обработки. Возвращает dict: {'text': str, 'buttons': list, 'photos': list}
        """
        # 1. Получаем/Создаем пользователя и сессию (в базе)
        # Оборачиваем ORM в sync_to_async для Telegram
        user, _ = await sync_to_async(BotUser.objects.get_or_create)(
            user_id=str(user_id),
            platform=platform,
            defaults={'name': user_name}
        )
        session, _ = await sync_to_async(UserSession.objects.get_or_create)(user=user)

        # 2. Анализируем через AI
        # Передаем текущие параметры поиска для контекста
        ai_analysis = self.ai.analyze_message(text, session.search_params)

        intent = ai_analysis.get('intent', 'greeting')
        extracted_params = ai_analysis.get('params', {})

        # 3. Обновляем параметры в сессии
        if extracted_params:
            current_params = session.search_params
            current_params.update(extracted_params)
            session.search_params = current_params
            await sync_to_async(session.save)()

        response_data = {
            'text': "",
            'buttons': [],
            'objects': []  # Список PropertyDTO
        }

        # --- СЦЕНАРИИ (согласно ТЗ) ---

        if intent == 'greeting':
            response_data['text'] = (
                f"Привет, {user.name or 'друг'}! Я HomeMe — ИИ-агент по недвижимости.\n"
                "Я могу найти квартиру в BI Group и на вторичке, или рассказать про районы Астаны."
            )
            response_data['buttons'] = ['🔍 Подобрать квартиру', '🏢 О районах', '👨‍💼 Связаться с экспертом']

        elif intent == 'search_objects':
            # Проверяем, достаточно ли данных. Для MVP ищем сразу.
            params = session.search_params

            # Доп. нормализация локации и предпочтений через AI (без ручных словарей)
            enrichment = self.ai.resolve_location_and_prefs(text, params)
            if enrichment:
                confidence = enrichment.get("confidence") or 0
                if confidence >= 0.35:
                    city_ai = enrichment.get("city")
                    district_ai = enrichment.get("district_normalized")
                    if city_ai and not params.get('city'):
                        params['city'] = city_ai
                    if district_ai and not params.get('district'):
                        params['district'] = district_ai
                    params['location_keywords'] = enrichment.get("nearby_keywords") or []
                    params['lifestyle_tags'] = enrichment.get("lifestyle_tags") or []
                    session.search_params = params
                    await sync_to_async(session.save)()

            # Если нет бюджета или комнат, AI мог бы спросить, но пока ищем "широким поиском"
            # или сообщаем, что нашли по текущим фильтрам.

            # Вызов поиска
            results = await sync_to_async(self.search_service.search)(
                rooms=params.get('rooms'),
                max_price=params.get('max_price'),
                city=params.get('city'),
                district=params.get('district'),
                query_text=text,
                location_keywords=params.get('location_keywords'),
                lifestyle_tags=params.get('lifestyle_tags'),
            )

            response_data['objects'] = results
            if results:
                response_data['text'] = f"Нашел {len(results)} вариантов по вашему запросу:"
            else:
                response_data[
                    'text'] = "Пока ничего подходящего не нашел. Попробуйте изменить бюджет или количество комнат."

            response_data['buttons'] = ['🔍 Показать еще', '🔄 Изменить поиск']

        elif intent == 'consult_location':
            # RAG / Консультация
            consultation_text = self.ai.generate_consultation(text)
            response_data['text'] = consultation_text
            response_data['buttons'] = ['🔍 Искать здесь жилье', '🏢 Другой район']

        elif intent == 'contact_expert':
            # Создаем лид
            await sync_to_async(Lead.objects.create)(
                user=user,
                request_text=text
            )
            response_data['text'] = "Ваша заявка принята! Менеджер скоро свяжется с вами."
            response_data['buttons'] = ['🔍 Вернуться к поиску']

        else:
            # Fallback
            response_data['text'] = "Я не совсем понял. Вы хотите найти квартиру или узнать про район?"
            response_data['buttons'] = ['🔍 Подобрать квартиру', '🏢 О районах']

        return response_data