import google.generativeai as genai
from google.api_core import exceptions
import json
import logging
import os
import time
from django.conf import settings

logger = logging.getLogger(__name__)


class AIService:
    def __init__(self):
        # Настройка API
        api_key = getattr(settings, 'GEMINI_API_KEY')
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel('gemini-3-flash-preview')

    def get_embedding(self, text: str):
        """Превращает текст в вектор (768 чисел)"""
        try:
            # Используем модель для эмбеддингов
            result = genai.embed_content(
                model="models/text-embedding-004",  # Или models/embedding-001
                content=text,
                task_type="retrieval_document",
                title="Property Description"
            )
            return result['embedding']
        except Exception as e:
            logger.error(f"Embedding Error: {e}")
            return None

    def _generate_with_retry(self, prompt: str, retries=3):
        """Пытается получить ответ, при ошибке 429 ждет и пробует снова"""
        for attempt in range(retries):
            try:
                return self.model.generate_content(prompt)
            except exceptions.ResourceExhausted as e:
                wait_time = 10 * (attempt + 1)  # Ждем 10с, потом 20с...
                logger.warning(f"Gemini 429 Error (Quota). Waiting {wait_time}s... Attempt {attempt + 1}/{retries}")
                time.sleep(wait_time)
            except Exception as e:
                logger.error(f"Gemini Error: {e}")
                return None
        return None

    @staticmethod
    def _extract_text(response) -> str:
        """
        Безопасно извлекает текст из ответа Gemini.
        Бывают случаи, когда response.text бросает ValueError из-за пустых Part.
        """
        if not response:
            return ""
        # Прямой быстрый путь
        try:
            return response.text or ""
        except Exception:
            pass

        # Фолбэк: вытаскиваем из кандидатов
        try:
            candidates = getattr(response, "candidates", None) or []
            for cand in candidates:
                content = getattr(cand, "content", None)
                parts = getattr(content, "parts", None) or []
                for part in parts:
                    text = getattr(part, "text", None)
                    if text:
                        return text
        except Exception as e:
            logger.error(f"Failed to extract text from Gemini response: {e}")

        return ""

    def analyze_message(self, user_text: str, current_context: dict = None) -> dict:
        context_str = json.dumps(current_context, ensure_ascii=False) if current_context else {}

        prompt = f"""
            ТЫ — HomeMe, профессиональный ИИ-консультант по недвижимости.

            ТВОЯ ЗАДАЧА:
            Проанализировать сообщение и вернуть JSON с параметрами поиска.

            ИЗВЛЕЧЕНИЕ ПАРАМЕТРОВ (params) для интента "search_objects":
            - "rooms" (int): Количество комнат.
            - "max_price" (int): Максимальный бюджет (50 млн -> 50000000).
            - "city" (str): Город. ОЧЕНЬ ВАЖНО. Варианты: "Astana", "Almaty", "Shymkent", "Atyrau". По умолчанию null (если не указан).
            - "district" (str): Ключевые слова локации (EXPO, Есильский, Ботанический, Мега, Центр).

            ПРАВИЛА КОНТЕКСТА:
            - Текущий контекст: {context_str}
            - Если пользователь пишет "Найди в районе EXPO", это значит district="EXPO", city="Astana" (так как EXPO в Астане).
            - Алиасы: "левый берег", "левберег", "Esil" -> city="Astana", district="левый берег".
            - Если пишет "В Алматы", то city="Almaty".

            ФОРМАТ ОТВЕТА (JSON):
            {{
                "intent": "search_objects" или "greeting" или "consult_location",
                "params": {{
                    "rooms": null,
                    "max_price": null,
                    "city": "Astana",
                    "district": "EXPO"
                }},
                "reply_text": "Ответ пользователю"
            }}

            Входящее сообщение: "{user_text}"
        """

        response = self._generate_with_retry(prompt)

        resp_text = self._extract_text(response)
        if resp_text:
            try:
                clean_text = resp_text.replace('```json', '').replace('```', '').strip()
                return json.loads(clean_text)
            except json.JSONDecodeError:
                return {"intent": "greeting", "params": {}, "reply_text": "Не понял формат."}

        # Если после всех попыток ответа нет
        return {"intent": "greeting", "params": {}, "reply_text": "Сервисы перегружены, попробуйте через минуту."}

    def generate_consultation(self, query: str) -> str:
        prompt = f"""
        Ты эксперт по недвижимости Астаны. Пользователь спрашивает: "{query}".
        Расскажи кратко и честно про этот район/вопрос. Выдели плюсы и минусы.
        Не предлагай конкретные квартиры, просто дай справку.
        """
        response = self._generate_with_retry(prompt)
        if response:
            text = self._extract_text(response)
            if text:
                return text
        return "Не удалось получить консультацию сейчас."

    def resolve_location_and_prefs(self, user_text: str, current_context: dict | None = None) -> dict:
        """
        Нормализация города/района и извлечение предпочтений (тихо/шумно/парки/метро и т.д.) через LLM.
        Возвращает dict c полями:
        - city: Один из ["Astana", "Almaty", "Shymkent", "Atyrau"] или null.
        - district_normalized: Нормализованное название/район или null.
        - nearby_keywords: Список строк (ориентиры: EXPO, Mega, парк, набережная).
        - lifestyle_tags: Список тегов предпочтений: ["quiet","noisy","park","school","metro","center","view","green","family","student"].
        - confidence: float 0..1.
        - reason: краткое объяснение.
        """
        context_str = json.dumps(current_context, ensure_ascii=False) if current_context else "{}"

        prompt = f"""
        Ты — HomeMe AI. Твоя задача: нормализовать локацию и предпочтения для поиска жилья.

        Правила:
        - Города: только Astana, Almaty, Shymkent, Atyrau. Если не уверен — null.
        - Если встречается EXPO, левый берег, Есильский район — это Astana (Есильский).
        - Для "тихо/шумно/рядом с парком/метро/центром" выдай lifestyle_tags.
        - Не придумывай адреса. Если уверенность < 0.35 — ставь city=null, district_normalized=null.

        Формат JSON (строго, без комментариев):
        {{
            "city": "Astana",
            "district_normalized": "Есильский район",
            "nearby_keywords": ["EXPO", "Mega Silk Way"],
            "lifestyle_tags": ["quiet", "park"],
            "confidence": 0.82,
            "reason": "Пользователь упомянул EXPO и тишину"
        }}

        Контекст предыдущих параметров: {context_str}
        Сообщение пользователя: "{user_text}"
        """

        response = self._generate_with_retry(prompt)
        resp_text = self._extract_text(response)
        if not resp_text:
            return {}

        try:
            clean_text = resp_text.replace('```json', '').replace('```', '').strip()
            data = json.loads(clean_text)
            # Жесткие ограничения на города
            if data.get("city") not in ["Astana", "Almaty", "Shymkent", "Atyrau", None]:
                data["city"] = None
            # Нормализация списков
            data["nearby_keywords"] = data.get("nearby_keywords") or []
            data["lifestyle_tags"] = data.get("lifestyle_tags") or []
            return data
        except Exception:
            return {}