import io
import logging
from asgiref.sync import sync_to_async
from shutil import which
from pydub import AudioSegment

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
        if text.lower() in ['/start', 'привет', 'меню', 'start', 'reset', 'в главное меню']:
            await self._update_state(session, 'START', {})
            return self._scenario_start(user.name or 'друг')

        # --- МАШИНА СОСТОЯНИЙ ---

        if state == 'START':
            lowered_text = text.lower()
            if text == '1' or 'подобрать' in lowered_text:
                await self._update_state(session, 'CHOOSING_TYPE')
                response[
                    'text'] = "Отлично! Что будем смотреть?\n\n1. Новостройки BI Group 🏗\n2. Вторичка 🏠\n3. Смешанный поиск ⭐"
                response['buttons'] = ['1. BI Group', '2. Вторичка', '3. Смешанный']

            elif text == '2' or 'район' in lowered_text:
                await self._update_state(session, 'CONSULTATION_TOPIC')
                response['text'] = "Про какой район рассказать? (Например: 'Есильский', 'EXPO')"
                response['buttons'] = ['Левый берег', 'Есильский', 'EXPO']

            elif text == '3' or 'эксперт' in lowered_text:
                await self._update_state(session, 'LEAD_NAME')
                response['text'] = "Я соединю тебя с экспертом. Как к тебе обращаться?"

            elif any(word in lowered_text for word in ['найди', 'квартира', 'квартиру', 'жк', 'жилье', 'квартир']):
                # Быстрый старт без кнопок: извлекаем параметры и сразу ищем
                params = await sync_to_async(
                    self.ai.extract_search_parameters,
                    thread_sensitive=False
                )(text)
                if self.ai.consume_quota_error():
                    return self._quota_response()
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
                    return self._quota_response()
                if location_data:
                    center = location_data.get('center_coordinates')
                    radius_km = location_data.get('search_radius_km')
                    if center:
                        params['coordinates'] = {'lat': center[0], 'lon': center[1]}
                        params['radius_km'] = radius_km or 3.0

                params['offset'] = 0
                params['city'] = 'Astana'

                if params.get('source') == 'bi':
                    complex_offset = params.get('complex_offset', 0)
                    complexes = await sync_to_async(
                        self.search.search_complexes,
                        thread_sensitive=False
                    )(params, offset=complex_offset, limit=5)

                    if complexes:
                        params['complex_offset'] = complex_offset + len(complexes)
                        response['objects'] = await sync_to_async(
                            self.search.map_complexes_to_dto,
                            thread_sensitive=False
                        )(params, complexes)
                        params['complex_candidates'] = self._merge_complex_candidates(
                            params.get('complex_candidates'),
                            self._serialize_complexes(complexes)
                        )
                        await self._update_state(session, 'COMPLEX_RESULTS', params)
                        response['text'] = self._format_complexes_intro(params)
                        response['buttons'] = self._complex_action_buttons(params)
                    else:
                        await self._update_state(session, 'NO_RESULTS', params)
                        response['text'] = "По запросу ничего не найдено. 😔\n\nВарианты действий:"
                        response['buttons'] = ['Увеличить бюджет', 'Изменить параметры', 'Связаться с экспертом']
                else:
                    results = await sync_to_async(
                        self.search.intelligent_search,
                        thread_sensitive=False
                    )(params, offset=0)
                    if results:
                        params['offset'] = len(results)
                        await self._update_state(session, 'BROWSING', params)
                        response['text'] = self._format_intro(results, params)
                        response['objects'] = results
                        response['buttons'] = ['Показать ещё', 'Изменить бюджет', 'Связаться с экспертом']
                    else:
                        await self._update_state(session, 'NO_RESULTS', params)
                        response['text'] = "По запросу ничего не найдено. 😔\n\nВарианты действий:"
                        response['buttons'] = ['Увеличить бюджет', 'Изменить комнаты', 'Связаться с экспертом']

            else:
                return self._scenario_start(user.name)

        elif state == 'CHOOSING_TYPE':
            if '1' in text or 'bi' in text.lower():
                params['source'] = 'bi'
                await self._update_state(session, 'CHOOSING_BI_CATEGORY', params)
                response['text'] = "Что именно интересует в BI Group?\n\n1. ЖК (квартиры)\n2. Офисы / коммерция"
                response['buttons'] = ['1. ЖК', '2. Офисы/коммерция']
                return self._ensure_main_menu_button(response, state)
            elif '2' in text or 'вторич' in text.lower():
                params['source'] = 'secondary'
            else:
                params['source'] = 'mixed'

            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = "Какой бюджет? 💰 (Например: '45-60' или 'до 50' млн)"
            response['buttons'] = ['до 30 млн', '30-50 млн', '50-80 млн']

        elif state == 'CHOOSING_BI_CATEGORY':
            lowered_text = text.lower()
            if '2' in lowered_text or 'офис' in lowered_text or 'коммер' in lowered_text:
                params['bi_category'] = 'commercial'
                params['bi_scope'] = 'both'
            else:
                params['bi_category'] = 'residential'

            await self._update_state(session, 'SETTING_BUDGET', params)
            response['text'] = "Какой бюджет? 💰 (Например: '45-60' или 'до 50' млн)"
            response['buttons'] = ['до 30 млн', '30-50 млн', '50-80 млн']

        elif state == 'SETTING_BUDGET':
            extracted = await sync_to_async(
                self.ai.extract_search_parameters,
                thread_sensitive=False
            )(text)
            if self.ai.consume_quota_error():
                return self._quota_response()
            if extracted.get('max_price') or extracted.get('min_price'):
                params.update(extracted)
                if params.get('bi_category') == 'commercial':
                    await self._update_state(session, 'SETTING_AREA', params)
                    response['text'] = "Какая площадь нужна? 🏢 (Например: '50-120 м²' или 'до 80 м²')"
                    response['buttons'] = ['до 50 м²', '50-100 м²', '100-200 м²', 'Не важно']
                else:
                    await self._update_state(session, 'SETTING_ROOMS', params)
                    response['text'] = "Сколько комнат? 🛏"
                    response['buttons'] = ['1', '2', '3', '4+', 'Не важно']
            else:
                response['text'] = "Не понял сумму. Напиши просто цифрами, например '50 млн'."

        elif state == 'SETTING_AREA':
            lowered_text = text.lower()

            if any(word in lowered_text for word in ['здание', 'целиком', 'бц', 'business center']):
                params['bi_scope'] = 'complex'
            elif any(word in lowered_text for word in ['офис', 'кабинет', 'помещение', 'retail', 'стрит']):
                params['bi_scope'] = 'unit'

            extracted = await sync_to_async(
                self.ai.extract_search_parameters,
                thread_sensitive=False
            )(text)
            if self.ai.consume_quota_error():
                return self._quota_response()

            if extracted.get('min_area') or extracted.get('max_area'):
                params.update(extracted)
            elif 'не важно' in lowered_text:
                params.pop('min_area', None)
                params.pop('max_area', None)

            await self._update_state(session, 'SETTING_LOCATION', params)
            response['text'] = "Есть предпочтения по району? 📍\n('Левый берег', 'EXPO' или 'Не важно')"
            response['buttons'] = ['Левый берег', 'Есильский', 'EXPO', 'Не важно']

        elif state == 'SETTING_ROOMS':
            lowered_text = text.lower()
            if 'не важно' in lowered_text:
                params.pop('rooms', None)
            elif '1' in text:
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

                location_data = await sync_to_async(
                    self.location_resolver.resolve_any_location,
                    thread_sensitive=False
                )(text, city_hint="Astana")
                if self.ai.consume_quota_error():
                    return self._quota_response()

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
                    # Если координаты не найдены (например, "тихий район"), удаляем старые, чтобы не мешали
                    params.pop('coordinates', None)

            # Сброс пагинации перед новым поиском
            params['offset'] = 0
            params['city'] = 'Astana'  # Hardcode MVP

            # ЗАПУСК ПОИСКА
            if params.get('source') == 'bi':
                complex_offset = params.get('complex_offset', 0)
                complexes = await sync_to_async(
                    self.search.search_complexes,
                    thread_sensitive=False
                )(params, offset=complex_offset, limit=5)

                if complexes:
                    params['complex_offset'] = complex_offset + len(complexes)
                    response['objects'] = await sync_to_async(
                        self.search.map_complexes_to_dto,
                        thread_sensitive=False
                    )(params, complexes)
                    params['complex_candidates'] = self._merge_complex_candidates(
                        params.get('complex_candidates'),
                        self._serialize_complexes(complexes)
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
                    response['buttons'] = ['Увеличить бюджет', 'Изменить параметры', 'Связаться с экспертом']
            else:
                results = await sync_to_async(
                    self.search.intelligent_search,
                    thread_sensitive=False
                )(params, offset=0)

                if results:
                    params['offset'] = len(results)
                    await self._update_state(session, 'BROWSING', params)

                    response['text'] = self._format_intro(results, params)
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Изменить бюджет', 'Связаться с экспертом']
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
                    response['buttons'] = ['Увеличить бюджет', 'Изменить комнаты', 'Связаться с экспертом']

        elif state == 'COMPLEX_RESULTS':
            lowered_text = text.lower()
            if 'ещ' in lowered_text:
                complexes = await sync_to_async(
                    self.search.search_complexes,
                    thread_sensitive=False
                )(params, offset=params.get('complex_offset', 0), limit=5)

                if complexes:
                    params['complex_offset'] = params.get('complex_offset', 0) + len(complexes)
                    response['objects'] = await sync_to_async(
                        self.search.map_complexes_to_dto,
                        thread_sensitive=False
                    )(params, complexes)
                    params['complex_candidates'] = self._merge_complex_candidates(
                        params.get('complex_candidates'),
                        self._serialize_complexes(complexes)
                    )
                    await self._update_state(session, 'COMPLEX_RESULTS', params)
                    response['text'] = "Еще варианты: 👇"
                    response['buttons'] = self._complex_action_buttons(params)
                else:
                    response['text'] = "Больше вариантов нет. Можешь выбрать ЖК/БЦ из списка."
                    response['buttons'] = self._complex_action_buttons(params)
            elif 'показать' in lowered_text or 'квартир' in lowered_text or 'помещ' in lowered_text:
                await self._update_state(session, 'CHOOSING_COMPLEX_NUMBER', params)
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)
            elif 'изменить' in lowered_text:
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Напиши новый бюджет:"
            else:
                response['text'] = self._format_complexes_intro(params)
                response['buttons'] = self._complex_action_buttons(params)

        elif state == 'CHOOSING_COMPLEX_NUMBER':
            choice = self._parse_choice(text)
            candidates = params.get('complex_candidates') or []
            if 'изменить' in text.lower():
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Напиши новый бюджет:"
                return self._ensure_main_menu_button(response, state)
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
                    params['offset'] = len(results)
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = f"Вот варианты по {selected.get('name')}:"
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Другой ЖК/БЦ', 'Изменить параметры']
                else:
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = f"По {selected.get('name')} ничего не найдено по текущим фильтрам."
                    response['buttons'] = ['Другой ЖК/БЦ', 'Изменить параметры']

        elif state == 'BROWSING':
            if text.lower() in ['показать еще', 'показать ещё', 'еще', 'дальше', 'ещё']:
                current_offset = params.get('offset', 0)

                # Поиск следующей страницы
                results = await sync_to_async(
                    self.search.intelligent_search,
                    thread_sensitive=False
                )(params, offset=current_offset)

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

        elif state == 'BROWSING_UNITS':
            lowered_text = text.lower()
            if lowered_text in ['показать еще', 'показать ещё', 'еще', 'дальше', 'ещё']:
                current_offset = params.get('offset', 0)
                selected_id = params.get('selected_complex_id')

                results = await sync_to_async(
                    self.search.search_units_for_complex,
                    thread_sensitive=False
                )(params, selected_id, offset=current_offset)

                if results:
                    params['offset'] = current_offset + len(results)
                    await self._update_state(session, 'BROWSING_UNITS', params)
                    response['text'] = "Вот еще варианты: 👇"
                    response['objects'] = results
                    response['buttons'] = ['Показать ещё', 'Другой ЖК/БЦ', 'Изменить параметры']
                else:
                    response['text'] = "Варианты по этому ЖК/БЦ закончились. 🤷‍♂️"
                    response['buttons'] = ['Другой ЖК/БЦ', 'Изменить параметры']

            elif 'другой' in lowered_text:
                await self._update_state(session, 'CHOOSING_COMPLEX_NUMBER', params)
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)

            elif 'изменить' in lowered_text or 'по другому' in lowered_text:
                await self._update_state(session, 'SETTING_BUDGET', params)
                response['text'] = "Напиши новый бюджет:"

            else:
                response['text'] = self._format_complexes_list(params)
                response['buttons'] = self._complex_number_buttons(params)

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
            consultation = await sync_to_async(
                self.ai.generate_consultation,
                thread_sensitive=False
            )(text)
            if self.ai.consume_quota_error():
                return self._quota_response()
            response['text'] = consultation
            response['buttons'] = ['Искать здесь', 'В меню']
            await self._update_state(session, 'START', {})

        return self._ensure_main_menu_button(response, state)

    async def process_voice(self, user_id, platform, voice_file_object, user_name=None):
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
            response = await self.process_message(user_id, platform, normalized_text, user_name)

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
            if 'связаться с экспертом' in lowered or lowered == 'эксперт':
                return '3'

        return text

    def _scenario_start(self, name):
        return {
            'text': f"Привет, {name}!\nЯ HomeMe - ИИ-агент по недвижимости в Астане 🏠.\nПомогу подобрать новостройки BI Group и вторичку, а ещё расскажу про районы и локации.\n\nЧто хочешь сделать?",
            'buttons': ['1. Подобрать объект', '2. Узнать про районы', '3. Связаться с экспертом']
        }

    @staticmethod
    def _quota_response():
        return {
            'text': "Лимит запросов к AI исчерпан. 😔 Попробуйте позже или напишите текстом."
        }

    def _format_intro(self, results, params):
        return f"Нашел {len(results)} вариантов (сгруппировано по ЖК): 👇"

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
            return ['Показать помещения', 'Показать ещё', 'Изменить параметры']
        return ['Показать квартиры', 'Показать ещё', 'Изменить параметры']

    @staticmethod
    def _complex_number_buttons(params):
        candidates = params.get('complex_candidates') or []
        buttons = [str(i) for i in range(1, min(len(candidates), 10) + 1)]
        buttons.append('Изменить параметры')
        return buttons

    @staticmethod
    def _parse_choice(text):
        try:
            return int(text.strip())
        except Exception:
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