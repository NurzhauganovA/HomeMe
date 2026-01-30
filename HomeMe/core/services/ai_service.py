import ast
import io
import re
import json
import logging
import time
from typing import Dict, Optional

import google.generativeai as genai
from django.conf import settings
from groq import Groq

logger = logging.getLogger(__name__)


class EnhancedAIService:
    """
    Профессиональная многоступенчатая AI-система для интеллектуального поиска недвижимости.
    Включает: NLU, геокодирование, анализ предпочтений, валидацию и обогащение данных.
    """

    def __init__(self, text_provider: Optional[str] = None):
        self.text_provider = (text_provider or getattr(settings, "AI_TEXT_PROVIDER", "gemini")).lower()

        groq_key = getattr(settings, 'GROQ_API_KEY', None)
        self.client = Groq(api_key=groq_key) if groq_key else None
        self.text_model = getattr(settings, "GROQ_TEXT_MODEL", "llama-3.3-70b-versatile")
        self.audio_model = getattr(settings, "GROQ_AUDIO_MODEL", "whisper-large-v3-turbo")

        self.gemini_text_model = getattr(settings, "GEMINI_TEXT_MODEL", "gemini-2.5-flash")
        self.gemini_json_model = getattr(settings, "GEMINI_JSON_MODEL", "gemini-1.5-flash")
        self.gemini_model = None
        self.gemini_json_model_client = None

        embedding_key = getattr(settings, 'GEMINI_API_KEY', None)
        if embedding_key:
            genai.configure(api_key=embedding_key)
            self.gemini_model = genai.GenerativeModel(self.gemini_text_model)
            self.gemini_json_model_client = genai.GenerativeModel(self.gemini_json_model)

        # Кэш для экономии запросов
        self._location_cache = {}
        self._quota_exceeded = False

    def _generate_with_retry(self, prompt: str, retries=3, temperature=0.3, json_mode=False):
        """Генерация текста через выбранный провайдер с retry логикой"""
        if self.text_provider == "groq":
            return self._generate_with_retry_groq(prompt, retries, temperature, json_mode)
        return self._generate_with_retry_gemini(prompt, retries, temperature, json_mode)

    def _generate_with_retry_groq(self, prompt: str, retries=3, temperature=0.3, json_mode=False):
        """Генерация текста через Groq с retry логикой"""
        force_json = bool(json_mode)
        for attempt in range(retries):
            try:
                if not self.client:
                    raise RuntimeError("GROQ_API_KEY is not configured")

                messages = [
                    {
                        "role": "system",
                        "content": "Return a valid JSON object only. No extra text." if force_json else "You are a helpful assistant."
                    },
                    {
                        "role": "user",
                        "content": prompt
                    }
                ]

                request_kwargs = {
                    "model": self.text_model,
                    "messages": messages,
                    "temperature": temperature,
                    "top_p": 0.95,
                    "max_tokens": 2048,
                }
                if force_json:
                    request_kwargs["response_format"] = {"type": "json_object"}

                response = self.client.chat.completions.create(**request_kwargs)
                return response
            except Exception as e:
                wait_time = 5 * (attempt + 1)
                error_text = str(e)
                if force_json and "response_format" in error_text.lower():
                    logger.warning("Groq response_format not supported, retrying without JSON mode")
                    force_json = False
                elif "429" in error_text or "rate" in error_text.lower():
                    logger.warning(f"Groq rate limit. Retry {attempt + 1}/{retries} after {wait_time}s")
                else:
                    logger.error(f"Groq error: {e}")
                if attempt == retries - 1:
                    self._quota_exceeded = True
                    return None
                time.sleep(wait_time)
        return None

    def _generate_with_retry_gemini(self, prompt: str, retries=3, temperature=0.3, json_mode=False):
        """Генерация текста через Gemini с retry логикой"""
        for attempt in range(retries):
            try:
                if not self.gemini_model:
                    raise RuntimeError("GEMINI_API_KEY is not configured")

                model = self.gemini_json_model_client if json_mode else self.gemini_model
                config = genai.types.GenerationConfig(
                    temperature=temperature,
                    top_p=0.95,
                    top_k=40,
                    max_output_tokens=4096,
                    response_mime_type="application/json" if json_mode else "text/plain"
                )
                response = model.generate_content(prompt, generation_config=config)
                return response
            except Exception as e:
                wait_time = 5 * (attempt + 1)
                error_text = str(e)
                if "429" in error_text or "rate" in error_text.lower():
                    logger.warning(f"Gemini rate limit. Retry {attempt + 1}/{retries} after {wait_time}s")
                else:
                    logger.error(f"Gemini error: {e}")
                if attempt == retries - 1:
                    self._quota_exceeded = True
                    return None
                time.sleep(wait_time)
        return None

    def consume_quota_error(self) -> bool:
        """Возвращает True, если quota была превышена, и сбрасывает флаг."""
        if self._quota_exceeded:
            self._quota_exceeded = False
            return True
        return False

    @staticmethod
    def _extract_text(response) -> str:
        """Безопасное извлечение текста из ответа"""
        if not response:
            return ""
        try:
            choices = getattr(response, "choices", [])
            if choices:
                message = getattr(choices[0], "message", None)
                if message and getattr(message, "content", None):
                    return message.content
            if getattr(response, "text", None):
                return response.text
        except Exception:
            logger.error("Failed to extract text from AI response")
        return ""

    def _parse_json_response(self, text: str) -> Optional[Dict]:
        """Парсинг JSON с поиском границ и поддержкой Python-синтаксиса"""
        if not text:
            return None

        try:
            # 1. Поиск границ JSON (чтобы убрать "Here is your JSON..." в начале)
            text = text.strip()

            # Ищем индексы начала объекта или списка
            start_brace = text.find('{')
            start_bracket = text.find('[')

            start = -1
            end = -1

            # Определяем, что начинается раньше (объект или список) и ищем конец
            if start_brace != -1 and (start_bracket == -1 or start_brace < start_bracket):
                start = start_brace
                end = text.rfind('}') + 1
            elif start_bracket != -1 and (start_brace == -1 or start_bracket < start_brace):
                start = start_bracket
                end = text.rfind(']') + 1

            if start != -1 and end > start:
                json_str = text[start:end]
            else:
                # Если скобок не нашли, пробуем чистить как было (на всякий случай)
                json_str = text.replace('```json', '').replace('```', '').strip()

            # 2. Чистка висячих запятых (Regex)
            json_str = re.sub(r',\s*]', ']', json_str)
            json_str = re.sub(r',\s*}', '}', json_str)

            # 3. Попытка стандартного JSON парсинга
            return json.loads(json_str)

        except json.JSONDecodeError:
            try:
                # 4. FALLBACK: Python eval
                # Спасает, если AI вернул одинарные кавычки: {'key': 'value'}
                return ast.literal_eval(json_str)
            except Exception:
                # 5. ЛОГИРОВАНИЕ ОШИБКИ
                # Это самое важное: мы увидим в консоли, какой именно текст сломал парсер
                logger.error(f"❌ JSON Parse Failed. Bad text content:\n{text}")
                return None
        except Exception as e:
            logger.error(f"❌ Unexpected Error in JSON parser: {e}")
            return None

    def transcribe_audio(self, audio_bytes: bytes, mime_type: str = "audio/mp3") -> str:
        """
        Превращает аудио-файл (байты) в текст.
        """
        if self.text_provider == "groq":
            return self._transcribe_audio_groq(audio_bytes, mime_type)
        return self._transcribe_audio_gemini(audio_bytes, mime_type)

    def _transcribe_audio_groq(self, audio_bytes: bytes, mime_type: str) -> str:
        try:
            if not self.client:
                raise RuntimeError("GROQ_API_KEY is not configured")

            logger.info("🎤 Sending audio to Groq for transcription...")

            if not isinstance(audio_bytes, (bytes, bytearray)):
                audio_bytes = bytes(audio_bytes)

            file_obj = io.BytesIO(audio_bytes)
            file_obj.name = "audio.mp3" if "mp3" in mime_type else "audio.ogg"

            response = self.client.audio.transcriptions.create(
                model=self.audio_model,
                file=file_obj,
                response_format="text"
            )

            text = str(response).strip()

            if not text:
                logger.warning("⚠️ Transcription returned empty content")
                return ""

            logger.info(f"📝 Transcription result: '{text}'")
            return text

        except Exception as e:
            error_text = str(e)
            logger.error(f"❌ Transcription failed: {e}")

            if "429" in error_text or "quota" in error_text.lower():
                return "__QUOTA_EXCEEDED__"

            return ""

    def _transcribe_audio_gemini(self, audio_bytes: bytes, mime_type: str) -> str:
        try:
            if not self.gemini_model:
                raise RuntimeError("GEMINI_API_KEY is not configured")

            logger.info("🎤 Sending audio to Gemini for transcription...")

            if not isinstance(audio_bytes, (bytes, bytearray)):
                audio_bytes = bytes(audio_bytes)

            prompt = "Listen to this audio and transcribe it exactly into Russian text. Do not add any commentary. Just the text."
            response = self.gemini_model.generate_content([
                prompt,
                {
                    "mime_type": mime_type,
                    "data": audio_bytes
                }
            ])

            text = ""
            try:
                text = response.text.strip()
            except Exception:
                text = ""

            if not text:
                logger.warning("⚠️ Transcription returned empty content")
                return ""

            logger.info(f"📝 Transcription result: '{text}'")
            return text

        except Exception as e:
            error_text = str(e)
            logger.error(f"❌ Transcription failed: {e}")

            if "429" in error_text or "quota" in error_text.lower():
                return "__QUOTA_EXCEEDED__"

            return ""

    # ======================== GEOGRAPHIC INTELLIGENCE ========================

    def resolve_location_intelligence(self, user_message: str, context: Dict = None) -> Dict:
        """
        Второй этап: интеллектуальное геокодирование и нормализация локаций.
        AI сам понимает EXPO, Левый берег, "рядом с Mega" и т.д.
        """
        # Контекст может быть пустым при первом сообщении, поэтому нормализуем
        context = context or {}
        cache_key = f"{user_message[:50]}_{context.get('city', '')}"
        if cache_key in self._location_cache:
            return self._location_cache[cache_key]

        context_info = json.dumps(context, ensure_ascii=False)

        prompt = f"""Ты — географический AI-эксперт по городам Казахстана (Астана, Алматы, Шымкент, Атырау).

ЗАДАЧА: Нормализовать и обогатить географическую информацию из запроса пользователя.

ГОРОДА (только эти):
- Astana (Астана, Нурсултан)
- Almaty (Алматы)
- Shymkent (Шымкент)
- Atyrau (Атырау)

ИЗВЕСТНЫЕ РАЙОНЫ АСТАНЫ:
- Есильский район (Левый берег, Yesil, Esil) - новый центр, EXPO, Mega Silk Way, Байтерек
- Сарыаркинский район (Правый берег) - старый город, рынки
- Алматинский район - жилые массивы
- Байконурский район - промзона, жилье

ИЗВЕСТНЫЕ ЛОКАЦИИ АСТАНЫ:
- EXPO - Есильский р-н, бизнес-центр, координаты ~51.091, 71.417
- Mega Silk Way - рядом с EXPO
- Хан Шатыр - центр
- Назарбаев Университет - рядом с EXPO
- Ботанический сад - север города

АЛМАТЫ:
- Алмалинский район - центр, Арбат
- Медеуский район - элитный, горы
- Бостандыкский - деловой
- Ауэзовский - жилой массив

ПРАВИЛА:
1. Если уверенность < 0.4, возвращай city=null, district=null
2. EXPO автоматически = Astana + Есильский район
3. "Левый берег" = Astana + Есильский
4. Ориентиры (парк, метро, ТЦ) добавляй в nearby_landmarks
5. Не придумывай адреса - только то, что реально есть
6. Если в тексте указано расстояние ("500 метров", "1 км") - заполни radius_km
7. Если упомянут известный ориентир (университет, ТРЦ, парк) — попробуй указать coordinates_estimate
   (даже приблизительно), и отрази это в confidence

КОНТЕКСТ: {context_info}
ЗАПРОС: "{user_message}"

Верни JSON:
{{
    "city": "Astana",
    "city_confidence": 0.95,
    "district": "Есильский район",
    "district_normalized": "Yesil District",
    "nearby_landmarks": ["EXPO", "Mega Silk Way"],
    "coordinates_estimate": {{"lat": 51.091, "lon": 71.417}},
    "radius_km": 5.0,
    "confidence": 0.88,
    "reasoning": "Упомянут EXPO, который находится в Есильском районе Астаны"
}}"""

        response = self._generate_with_retry(prompt, temperature=0.1, json_mode=True)
        text = self._extract_text(response)
        result = self._parse_json_response(text)
        if not result:
            retry_prompt = (
                "Верни ТОЛЬКО валидный JSON без кода и текста. "
                "Если не уверен, используй null/0.\n\n" + prompt
            )
            response = self._generate_with_retry(retry_prompt, temperature=0.0, json_mode=True)
            text = self._extract_text(response)
            result = self._parse_json_response(text)

        if not result or result.get('confidence', 0) < 0.4:
            return {
                "city": None,
                "district": None,
                "confidence": 0.0,
                "reasoning": "Не удалось определить локацию с достаточной уверенностью"
            }

        self._location_cache[cache_key] = result
        return result

    # ======================== PARAMETER EXTRACTION ========================

    def extract_search_parameters(self, user_message: str, context: Dict = None) -> Dict:
        """
        Четвертый этап: извлечение конкретных параметров поиска.
        Цена, комнаты, площадь и т.д.
        """
        context_info = json.dumps(context or {}, ensure_ascii=False)

        prompt = f"""Ты — AI-аналитик параметров недвижимости.

ИЗВЛЕКАЕМЫЕ ПАРАМЕТРЫ:
1. rooms (int) - количество комнат (1, 2, 3, 4+)
2. min_price / max_price (int) - бюджет в тенге
3. min_area / max_area (float) - площадь в м²
4. floor_preferences (list) - предпочтения по этажу ["not_first", "not_last", "high"]
5. property_type (str) - "new_building", "secondary", "any"

РАСПОЗНАВАНИЕ ФОРМУЛИРОВОК:
- "двушка" = 2 комнаты
- "до 50 лямов" = max_price: 50000000
- "40-50 квадратов" = min_area: 40, max_area: 50
- "не первый этаж" = floor_preferences: ["not_first"]

КОНТЕКСТ: {context_info}
ЗАПРОС: "{user_message}"

Верни JSON:
{{
    "rooms": 2,
    "max_price": 50000000,
    "min_area": 40,
    "max_area": 60,
    "floor_preferences": ["not_first"],
    "property_type": "any",
    "confidence": 0.85,
    "extracted_entities": {{"rooms": "двушка", "price": "до 50 млн"}}
}}"""

        response = self._generate_with_retry(prompt, temperature=0.2, json_mode=True)
        text = self._extract_text(response)
        result = self._parse_json_response(text)
        if not result:
            retry_prompt = (
                "Верни ТОЛЬКО валидный JSON без кода и текста. "
                "Если не уверен, используй null/0.\n\n" + prompt
            )
            response = self._generate_with_retry(retry_prompt, temperature=0.0, json_mode=True)
            text = self._extract_text(response)
            result = self._parse_json_response(text)

        return result or {"confidence": 0.0}

    # ======================== EMBEDDINGS ========================

    def get_embedding(self, text: str):
        """Генерация эмбеддинга для векторного поиска"""
        try:
            if not getattr(settings, 'GEMINI_API_KEY', None):
                logger.warning("⚠️ GEMINI_API_KEY is not configured, embeddings disabled")
                return None
            embedding_model = getattr(settings, "EMBEDDING_MODEL", "models/text-embedding-004")
            result = genai.embed_content(
                model=embedding_model,
                content=text,
                task_type="retrieval_document"
            )
            embedding = result.get('embedding')

            # Нормализуем в список, чтобы избежать ошибок truth value для numpy array
            if embedding is None:
                return None

            embedding = list(embedding)
            expected_dim = getattr(settings, "EMBEDDING_DIMENSIONS", 768)
            if len(embedding) != expected_dim:
                logger.warning(
                    f"⚠️ Embedding dimension mismatch: got {len(embedding)}, expected {expected_dim}. "
                    "Auto-adjusting."
                )
                if len(embedding) > expected_dim:
                    embedding = embedding[:expected_dim]
                else:
                    embedding = embedding + [0.0] * (expected_dim - len(embedding))

            return embedding
        except Exception as e:
            logger.error(f"Embedding error: {e}")
            return None

    # ======================== CONSULTATION (RAG) ========================

    def generate_consultation(self, query: str, location_info: Dict = None) -> str:
        """Генерация консультации по району"""
        location_context = json.dumps(location_info or {}, ensure_ascii=False)

        prompt = f"""Ты — эксперт по недвижимости Казахстана.

КОНТЕКСТ ЛОКАЦИИ: {location_context}
ВОПРОС: "{query}"

Дай профессиональную консультацию:
1. Краткое описание района/локации
2. Плюсы (3-4 пункта)
3. Минусы (2-3 пункта)
4. Для кого подходит
5. Средние цены (если знаешь)

Стиль: дружелюбный эксперт, честный, без преувеличений."""

        response = self._generate_with_retry(prompt, temperature=0.6)
        return self._extract_text(response) or "Не удалось получить консультацию."
