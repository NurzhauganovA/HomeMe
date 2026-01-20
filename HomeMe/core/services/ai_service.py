import ast
import re

import google.generativeai as genai
from google.api_core import exceptions
import json
import logging
import time
from typing import Dict, List, Optional, Tuple
from django.conf import settings

logger = logging.getLogger(__name__)


class EnhancedAIService:
    """
    Профессиональная многоступенчатая AI-система для интеллектуального поиска недвижимости.
    Включает: NLU, геокодирование, анализ предпочтений, валидацию и обогащение данных.
    """

    def __init__(self):
        api_key = getattr(settings, 'GEMINI_API_KEY')
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel('gemini-2.5-flash')

        print("🔍 Поиск доступных моделей...\n")

        try:
            for m in genai.list_models():
                # Нам нужны только те, которые умеют генерировать текст (generateContent)
                if 'generateContent' in m.supported_generation_methods:
                    print(f"- {m.name}")
        except Exception as e:
            print(f"Ошибка при получении списка: {e}")

        # Кэш для экономии запросов
        self._location_cache = {}
        self._query_enrichment_cache = {}

    def _generate_with_retry(self, prompt: str, retries=3, temperature=0.3, json_mode=False):
        """Умная генерация с retry логикой и настраиваемой температурой"""
        for attempt in range(retries):
            try:
                # Настройка конфига
                config = genai.types.GenerationConfig(
                    temperature=temperature,
                    top_p=0.95,
                    top_k=40,
                    max_output_tokens=4096,  # Увеличим лимит токенов на всякий случай
                    response_mime_type="application/json" if json_mode else "text/plain"
                )

                response = self.model.generate_content(prompt, generation_config=config)
                return response
            except exceptions.ResourceExhausted as e:
                wait_time = 10 * (attempt + 1)
                logger.warning(f"Gemini quota exceeded. Retry {attempt + 1}/{retries} after {wait_time}s")
                time.sleep(wait_time)
            except Exception as e:
                logger.error(f"Gemini error: {e}")
                if attempt == retries - 1:
                    return None
        return None

    @staticmethod
    def _extract_text(response) -> str:
        """Безопасное извлечение текста из ответа Gemini"""
        if not response:
            return ""
        try:
            return response.text or ""
        except Exception:
            try:
                candidates = getattr(response, "candidates", [])
                for cand in candidates:
                    content = getattr(cand, "content", None)
                    parts = getattr(content, "parts", [])
                    for part in parts:
                        text = getattr(part, "text", None)
                        if text:
                            return text
            except Exception as e:
                logger.error(f"Failed to extract text: {e}")
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

    # ======================== STAGE 1: INTENT CLASSIFICATION ========================

    def classify_intent(self, user_message: str, context: Dict = None) -> Dict:
        """
        Первый этап: классификация намерения пользователя.
        Определяет, что хочет пользователь: искать, консультироваться или связаться.
        """
        context_info = json.dumps(context or {}, ensure_ascii=False)

        prompt = f"""Ты — HomeMe AI, эксперт по анализу запросов о недвижимости.

ЗАДАЧА: Определить намерение (intent) пользователя.

ВОЗМОЖНЫЕ ИНТЕНТЫ:
1. "search_objects" - Хочет найти/посмотреть квартиры
2. "consult_location" - Спрашивает о районе/локации (информационный запрос)
3. "contact_expert" - Хочет связаться с живым экспертом
4. "greeting" - Приветствие или общая беседа
5. "refine_search" - Уточнение/изменение параметров поиска

КОНТЕКСТ ДИАЛОГА: {context_info}
СООБЩЕНИЕ: "{user_message}"

Верни JSON:
{{
    "intent": "search_objects",
    "confidence": 0.95,
    "reasoning": "Пользователь явно запрашивает поиск недвижимости",
    "is_continuation": false
}}"""

        response = self._generate_with_retry(prompt, temperature=0.2)
        text = self._extract_text(response)
        result = self._parse_json_response(text)

        if not result:
            return {
                "intent": "greeting",
                "confidence": 0.3,
                "reasoning": "Не удалось классифицировать",
                "is_continuation": False
            }

        return result

    # ======================== STAGE 2: GEOGRAPHIC INTELLIGENCE ========================

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

        response = self._generate_with_retry(prompt, temperature=0.1)
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

    # ======================== STAGE 3: LIFESTYLE & PREFERENCES EXTRACTION ========================

    def extract_lifestyle_preferences(self, user_message: str, context: Dict = None) -> Dict:
        """
        Третий этап: извлечение lifestyle-предпочтений и нефункциональных требований.
        "Тихо", "для семьи", "рядом с метро", "зеленый район" и т.д.
        """
        prompt = f"""Ты — AI-психолог недвижимости. Анализируешь lifestyle-предпочтения.

КАТЕГОРИИ ПРЕДПОЧТЕНИЙ:

1. АТМОСФЕРА:
   - quiet (тихо, спокойно)
   - lively (оживленно, центр)
   - nature (зелено, парки)
   - urban (городской стиль)

2. ИНФРАСТРУКТУРА:
   - metro (метро рядом)
   - school (школы, детсады)
   - mall (ТЦ, магазины)
   - medical (поликлиники)
   - park (парки, скверы)
   - gym (спортзалы)

3. ЦЕЛЕВАЯ АУДИТОРИЯ:
   - family (семья с детьми)
   - student (студент)
   - young_professional (молодой специалист)
   - investor (инвестор)
   - retiree (пенсионер)

4. ОСОБЫЕ ТРЕБОВАНИЯ:
   - view (красивый вид)
   - new_building (новостройка)
   - renovation (с ремонтом)
   - parking (парковка)
   - security (охрана)

ЗАПРОС: "{user_message}"

Извлеки максимум информации и верни JSON:
{{
    "lifestyle_tags": ["quiet", "family", "park", "school"],
    "priority_tags": ["quiet", "park"],
    "extracted_phrases": ["где тихо", "для семьи"],
    "target_audience": "family",
    "confidence": 0.75,
    "reasoning": "Запрос указывает на семейные ценности и тишину"
}}"""

        response = self._generate_with_retry(prompt, temperature=0.3, json_mode=True)
        text = self._extract_text(response)
        result = self._parse_json_response(text)

        return result or {"lifestyle_tags": [], "confidence": 0.0}

    # ======================== STAGE 4: PARAMETER EXTRACTION ========================

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

        response = self._generate_with_retry(prompt, temperature=0.2)
        text = self._extract_text(response)
        result = self._parse_json_response(text)

        return result or {"confidence": 0.0}

    # ======================== STAGE 5: QUERY ENRICHMENT & SEMANTIC EXPANSION ========================

    def enrich_search_query(self, user_message: str, location_data: Dict,
                            lifestyle_data: Dict, params_data: Dict) -> Dict:
        """
        Пятый этап: семантическое обогащение запроса для умного векторного поиска.
        Генерирует синонимы, связанные термины и поисковые ключи.
        """
        combined_context = {
            "location": location_data,
            "lifestyle": lifestyle_data,
            "params": params_data
        }
        context_str = json.dumps(combined_context, ensure_ascii=False)

        prompt = f"""Ты — AI для семантического обогащения поисковых запросов.

ЗАДАЧА: Создать расширенное поисковое представление для векторного поиска.

ВХОДНЫЕ ДАННЫЕ:
{context_str}

ОРИГИНАЛЬНЫЙ ЗАПРОС: "{user_message}"

Сгенерируй:
1. semantic_keywords - ключевые слова с синонимами
2. description_match_phrases - фразы для поиска в описаниях
3. exclusion_keywords - что точно НЕ подходит
4. embedding_text - итоговый текст для векторизации

ПРИМЕР:
Если "тихая квартира рядом с парком для семьи":
- semantic_keywords: ["тихий", "спокойный", "зеленый", "парк", "сквер", "семейный", "детская площадка"]
- description_match_phrases: ["тихий район", "рядом парк", "для семьи", "детская инфраструктура"]
- exclusion_keywords: ["шумный", "ночной клуб", "трасса"]

Верни JSON:
{{
    "semantic_keywords": ["тихий", "парк"],
    "description_match_phrases": ["тихий район", "зеленая зона"],
    "exclusion_keywords": ["шумный"],
    "embedding_text": "Тихая спокойная квартира в зеленом районе рядом с парком для семьи с детьми",
    "search_weight_factors": {{
        "location_weight": 0.4,
        "lifestyle_weight": 0.35,
        "params_weight": 0.25
    }}
}}"""

        response = self._generate_with_retry(prompt, temperature=0.4)
        text = self._extract_text(response)
        result = self._parse_json_response(text)

        return result or {"embedding_text": user_message}

    # ======================== MASTER ORCHESTRATION ========================

    def analyze_query_comprehensive(self, user_message: str, context: Dict = None) -> Dict:
        """
        ГЛАВНЫЙ МЕТОД: Оркестрирует все этапы анализа.
        Возвращает полное понимание запроса пользователя.
        """
        logger.info(f"🧠 Starting comprehensive analysis for: {user_message[:50]}...")

        # Stage 1: Intent
        intent_result = self.classify_intent(user_message, context)
        logger.info(f"📌 Intent: {intent_result.get('intent')} (conf: {intent_result.get('confidence')})")

        # Если не поиск - возвращаем базовый результат
        if intent_result.get('intent') not in ['search_objects', 'refine_search']:
            return {
                "intent": intent_result.get('intent'),
                "confidence": intent_result.get('confidence'),
                "stage": "intent_only"
            }

        # Stage 2: Location Intelligence
        location_result = self.resolve_location_intelligence(user_message, context)
        logger.info(f"📍 Location: {location_result.get('city')}, {location_result.get('district')}")

        # Stage 3: Lifestyle
        lifestyle_result = self.extract_lifestyle_preferences(user_message, context)
        logger.info(f"🎯 Lifestyle tags: {lifestyle_result.get('lifestyle_tags', [])}")

        # Stage 4: Parameters
        params_result = self.extract_search_parameters(user_message, context)
        logger.info(f"📊 Params: {params_result}")

        # Stage 5: Semantic Enrichment
        enrichment_result = self.enrich_search_query(
            user_message, location_result, lifestyle_result, params_result
        )
        logger.info(f"✨ Enrichment completed")

        # Собираем финальный результат
        comprehensive_result = {
            "intent": intent_result.get('intent'),
            "intent_confidence": intent_result.get('confidence'),

            # Location
            "city": location_result.get('city'),
            "district": location_result.get('district'),
            "nearby_landmarks": location_result.get('nearby_landmarks', []),
            "coordinates": location_result.get('coordinates_estimate'),
            "radius_km": location_result.get('radius_km'),
            "location_confidence": location_result.get('confidence', 0),

            # Parameters
            "rooms": params_result.get('rooms'),
            "max_price": params_result.get('max_price'),
            "min_price": params_result.get('min_price'),
            "min_area": params_result.get('min_area'),
            "max_area": params_result.get('max_area'),
            "floor_preferences": params_result.get('floor_preferences', []),
            "property_type": params_result.get('property_type'),

            # Lifestyle
            "lifestyle_tags": lifestyle_result.get('lifestyle_tags', []),
            "priority_tags": lifestyle_result.get('priority_tags', []),
            "target_audience": lifestyle_result.get('target_audience'),

            # Enrichment
            "semantic_keywords": enrichment_result.get('semantic_keywords', []),
            "description_match_phrases": enrichment_result.get('description_match_phrases', []),
            "exclusion_keywords": enrichment_result.get('exclusion_keywords', []),
            "embedding_text": enrichment_result.get('embedding_text', user_message),

            # Overall
            "analysis_complete": True,
            "stage": "comprehensive"
        }

        logger.info(f"✅ Comprehensive analysis complete!")
        return comprehensive_result

    # ======================== EMBEDDINGS ========================

    def get_embedding(self, text: str):
        """Генерация эмбеддинга для векторного поиска"""
        try:
            result = genai.embed_content(
                model="models/text-embedding-004",
                content=text,
                task_type="retrieval_document"
            )
            embedding = result.get('embedding')

            # Нормализуем в список, чтобы избежать ошибок truth value для numpy array
            if embedding is None:
                return None

            return list(embedding)
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
