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

        if response and response.text:
            try:
                clean_text = response.text.replace('```json', '').replace('```', '').strip()
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
            return response.text
        return "Не удалось получить консультацию сейчас."