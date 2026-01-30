import logging
import json
import time
import requests
import google.generativeai as genai
from django.conf import settings
from telegram_bot.models import BIComplex, BIUnit, BICommercialComplex, BICommercialUnit
from core.bi_client import EnhancedBIGroupClient
from core.services.ai_service import EnhancedAIService

logger = logging.getLogger(__name__)


class BISyncService:
    def __init__(self):
        self.client = EnhancedBIGroupClient()
        self.ai = EnhancedAIService()
        self.ASTANA_UUID = self.client.CITY_MAP.get("Astana", "4c0fe725-4b6f-11e8-80cf-bb580b2abfef")
        self.groq_api_key = getattr(settings, "GROQ_API_KEY", None)
        gemini_key = getattr(settings, "GEMINI_API_KEY", None)
        if gemini_key:
            genai.configure(api_key=gemini_key)

    def run_full_sync(self):
        """Полная синхронизация ЖК и квартир с умным обогащением данных"""
        logger.info("🚀 Starting Smart Full Sync (Residential + Commercial)...")

        # 1. Получаем все ЖК
        residential = self.run_residential_sync()
        commercial = self.run_commercial_sync()

        logger.info(
            f"✅ Smart Sync Complete! "
            f"Residential synced {residential['synced']}, AI skipped {residential['ai_skipped']}. "
            f"Commercial synced {commercial['synced']}, AI skipped {commercial['ai_skipped']}"
        )

    def run_residential_sync(self):
        """Синхронизация только ЖК и квартир"""
        complexes_data = self.client.get_all_real_estates()
        logger.info(f"🏢 Found {len(complexes_data)} complexes via API")

        synced_count = 0
        skipped_ai_count = 0
        for item in complexes_data:
            ai_status = self._sync_complex_and_units(item)
            synced_count += 1
            if ai_status == 0:
                skipped_ai_count += 1

        return {"synced": synced_count, "ai_skipped": skipped_ai_count}

    def run_commercial_sync(self):
        """Синхронизация только коммерческих объектов и помещений"""
        commercial_data = self.client.get_all_commercial_real_estates()
        logger.info(f"🏢 Found {len(commercial_data)} commercial complexes via API")

        commercial_synced = 0
        commercial_skipped_ai = 0
        for item in commercial_data:
            ai_status = self._sync_commercial_complex_and_units(item)
            commercial_synced += 1
            if ai_status == 0:
                commercial_skipped_ai += 1

        return {"synced": commercial_synced, "ai_skipped": commercial_skipped_ai}

    def _sync_complex_and_units(self, item: dict):
        """Синхронизация одного ЖК, AI-анализ локации и обновление квартир"""
        try:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != self.ASTANA_UUID:
                return None

            bi_uuid = item.get("uuid")
            name = item.get("name")
            address = item.get("address", "")

            # Сохраняем базовые данные
            defaults = {
                "name": name,
                "address": address,
                "city_uuid": item.get("cityUUID", ""),
                "latitude": item.get("latitude"),
                "longitude": item.get("longitude"),
                "url": item.get("website", ""),
                "image_url": item.get("photoURL400") or item.get("photoURL", ""),
                "class_name": item.get('propertyClassName', [''])[0] if item.get('propertyClassName') else "",
                "description": f"ЖК {name}. Адрес: {address}",
                "min_price": item.get("minTotalPrice"),
                "min_area": item.get("squareMin"),
                "max_area": item.get("squareMax"),
            }

            complex_obj, created = BIComplex.objects.update_or_create(
                bi_uuid=bi_uuid,
                defaults=defaults
            )

            status = 0

            # --- УМНАЯ ЛОГИКА AI (С ЭКОНОМИЕЙ) ---

            # Сценарий 1: Нет тегов (features) -> Полный анализ (Дорого)
            if not complex_obj.features:
                logger.info(f"🤖 AI Analysis needed for {name} (No features)...")
                self._enrich_complex_with_deep_analysis(complex_obj)
                status = 1

            # Сценарий 2: Теги есть, но нет вектора -> Только вектор (Дешево)
            elif complex_obj.embedding is None:
                logger.info(f"🧬 Generating Embedding only for {name} (Features exist)...")
                self._regenerate_embedding_from_features(complex_obj)
                status = 2

            # Сценарий 3: Всё есть -> Пропуск
            else:
                logger.info(f"⏭️ SKIPPING AI for {name} (All data present)")
                status = 0

            # Синхронизация квартир
            placements = self.client.get_placements_for_complex(bi_uuid)
            if placements:
                self._sync_units_batch(complex_obj, placements, BIUnit)

            return status

        except Exception as e:
            logger.error(f"⚠️ Error syncing complex {item.get('name')}: {e}")
            return None

    def _sync_commercial_complex_and_units(self, item: dict):
        """Синхронизация коммерческого объекта и помещений"""
        try:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != self.ASTANA_UUID:
                return None

            bi_uuid = item.get("uuid")
            name = item.get("name")
            address = item.get("address", "")

            defaults = {
                "name": name,
                "address": address,
                "city_uuid": item.get("cityUUID", ""),
                "latitude": item.get("latitude"),
                "longitude": item.get("longitude"),
                "url": item.get("website", ""),
                "image_url": item.get("photoURL400") or item.get("photoURL", ""),
                "class_name": item.get('propertyClassName', [''])[0] if item.get('propertyClassName') else "",
                "description": f"Коммерческий объект {name}. Адрес: {address}",
                "min_price": item.get("minTotalPrice"),
                "min_area": item.get("squareMin"),
                "max_area": item.get("squareMax"),
            }

            complex_obj, created = BICommercialComplex.objects.update_or_create(
                bi_uuid=bi_uuid,
                defaults=defaults
            )

            status = 0

            if not complex_obj.features:
                logger.info(f"🤖 AI Analysis needed for commercial {name} (No features)...")
                self._enrich_commercial_complex_with_deep_analysis(complex_obj)
                status = 1
            elif complex_obj.embedding is None:
                logger.info(f"🧬 Generating Commercial Embedding only for {name} (Features exist)...")
                self._regenerate_embedding_from_features(complex_obj, kind="commercial")
                status = 2
            else:
                logger.info(f"⏭️ SKIPPING AI for commercial {name} (All data present)")
                status = 0

            placements = self.client.get_commercial_placements_for_complex(bi_uuid)
            if placements:
                self._sync_units_batch(complex_obj, placements, BICommercialUnit)

            return status

        except Exception as e:
            logger.error(f"⚠️ Error syncing commercial complex {item.get('name')}: {e}")
            return None

    def _enrich_complex_with_deep_analysis(self, complex_obj: BIComplex):
        """
        AI-агент, который классифицирует локацию для жестких фильтров.
        Определяет берег (Левый/Правый) и атмосферу.
        """
        logger.info(f"🧠 Deep Analyzing Location: {complex_obj.name}...")

        prompt = f"""
        Ты — эксперт по недвижимости Астаны и Алматы.

        Объект: ЖК "{complex_obj.name}"
        Адрес: "{complex_obj.address}"

        Твоя задача — классифицировать этот объект для фильтров поиска.

        1. ОПРЕДЕЛИ БЕРЕГ (Только для Астаны): 
           - "Left": Есильский район, Нура, район EXPO, Ботанический сад.
           - "Right": Сарыарка, Байконур, Алматинский район.

        2. АТМОСФЕРА:
           - Опиши атмосферу района СТРОГО НА РУССКОМ ЯЗЫКЕ.
           - Используй прилагательные: "тихий", "шумный", "семейный", "деловой", "молодежный", "зеленый", "ветреный", "элитный".
           - Добавь детали: "широкие дороги", "красивый вид", "чистый воздух", "пробки".
           - Здесь, по атмосферам тоже нужно самому дополнить. Тут тоже может быть много вариантов, например, такие как, (тихо, шумно, красиво, улицы чистые, дороги хорошие, вид красивый и т.д.). Нужно максимально много слов, которые соответствуют на характеристику адреса.

        3. ТЕГИ: Добавь список тегов (парк рядом, школа рядом, экспо рядом, вокзал). В дальнейшем мы будем искать по тегам ЖК, так что, чтобы мы нашли из БД определенных объектов без проблем,
        нужно максимально добавить много тегов. Много, как можно максимально. Любая мелочь, такие как, рядом супермаркет, аптека и т.д. Или определенные большие ТЦ, ФудКорты и т.д.
        Если возможно, можно сделать рядом есть рынок, или где дешево больше части, допустим продукты дешевле чем в других местах. Как понял, нужно максимально много тегов добавить, чтобы было проще искать.
        
        Верни ответ СТРОГО в формате JSON:
        {{
            "side": "Right" (или "Left"),
            "district_name": "Алматинский",
            "atmosphere": ["тихий", "спальный", "зеленый двор", "старый центр", ...]
            "tags": ["park", "school", "station", ...]
        }}
        """

        try:
            # Вызов AI с повторами
            text = self._groq_generate_json(prompt)
            analysis = self.ai._parse_json_response(text)

            if analysis:
                # 1. Сохраняем жесткие теги в JSONField
                complex_obj.features = analysis
                self._regenerate_embedding_from_features(complex_obj, kind="residential")

                # 2. Генерируем "умный" текст для вектора
                # Включаем туда результаты анализа, чтобы векторный поиск тоже понимал берег
                side_str = "Левый берег" if analysis.get('side') == 'Left' else "Правый берег"

                rich_text = (
                    f"ЖК {complex_obj.name}. Город {complex_obj.city_uuid}. "
                    f"Район: {analysis.get('district_name')}. {side_str}. "
                    f"Атмосфера: {analysis.get('atmosphere')}. "
                    f"Рядом: {', '.join(analysis.get('tags', []))}. "
                    f"Адрес: {complex_obj.address}."
                )

                embedding = self._get_embedding_sync(rich_text)
                if embedding:
                    complex_obj.embedding = embedding

                complex_obj.save()
                logger.info(f"✅ Enriched {complex_obj.name}: {side_str}, {analysis.get('atmosphere')}")
            else:
                logger.warning(f"⚠️ Empty analysis for {complex_obj.name}")

        except Exception as e:
            logger.error(f"❌ AI Enrichment failed: {e}")

    def _enrich_commercial_complex_with_deep_analysis(self, complex_obj: BICommercialComplex):
        """
        AI-агент для коммерческих объектов: фокус на бизнес-трафике и доступности.
        """
        logger.info(f"🧠 Deep Analyzing Commercial Location: {complex_obj.name}...")

        prompt = f"""
        Ты — эксперт по коммерческой недвижимости Астаны и Алматы.

        Объект: "{complex_obj.name}"
        Адрес: "{complex_obj.address}"

        Твоя задача — классифицировать этот объект для поиска коммерции.

        1. ОПРЕДЕЛИ БЕРЕГ (только для Астаны): 
           - "Left": Есильский район, Нура, район EXPO, Ботанический сад.
           - "Right": Сарыарка, Байконур, Алматинский район.

        2. АТМОСФЕРА (СТРОГО НА РУССКОМ):
           - Используй прилагательные: "деловой", "трафиковый", "активный", "спокойный",
             "центральный", "премиальный", "доступный", "проходимый", "офисный".

        3. ТЕГИ: добавь максимум бизнес-тегов:
           - "высокий трафик", "первая линия", "видимость фасада", "парковка",
             "удобный подъезд", "рядом остановка", "рядом метро", "рядом БЦ",
             "рядом ТРЦ", "рядом госучреждения", "логистика", "грузовой лифт",
             "отдельный вход", "офисный кластер", "street retail", "удобно для клиентов".
           - Также добавь ориентиры и инфраструктуру рядом, если возможно.

        Верни ответ СТРОГО в формате JSON:
        {{
            "side": "Right" (или "Left"),
            "district_name": "Есильский",
            "atmosphere": ["деловой", "трафиковый", ...],
            "tags": ["первая линия", "парковка", ...]
        }}
        """

        try:
            text = self._groq_generate_json(prompt)
            analysis = self.ai._parse_json_response(text)

            if analysis:
                complex_obj.features = analysis
                self._regenerate_embedding_from_features(complex_obj, kind="commercial")

                side_str = "Левый берег" if analysis.get('side') == 'Left' else "Правый берег"
                rich_text = self._build_embedding_text(complex_obj, analysis, kind="commercial", side_str=side_str)

                embedding = self._get_embedding_sync(rich_text)
                if embedding:
                    complex_obj.embedding = embedding

                complex_obj.save()
                logger.info(f"✅ Commercial enriched {complex_obj.name}: {side_str}, {analysis.get('atmosphere')}")
            else:
                logger.warning(f"⚠️ Empty commercial analysis for {complex_obj.name}")

        except Exception as e:
            logger.error(f"❌ Commercial AI Enrichment failed: {e}")

    def _regenerate_embedding_from_features(self, complex_obj: BIComplex, kind: str = "residential"):
        """Генерация вектора из уже существующих features (без запроса классификации)"""
        if not complex_obj.features:
            return

        features = complex_obj.features

        side_str = "Левый берег" if features.get('side') == 'Left' else "Правый берег"
        rich_text = self._build_embedding_text(complex_obj, features, kind=kind, side_str=side_str)

        # Запрос только на эмбеддинг (это дешевле)
        embedding = self._get_embedding_sync(rich_text)
        if embedding:
            complex_obj.embedding = embedding
            complex_obj.save()
            logger.info(f"✅ Embedding saved for {complex_obj.name}")

    def _groq_generate_json(self, prompt: str, retries: int = 3) -> str:
        """Вызов Groq (только для синхронизации БД)"""
        if not self.groq_api_key:
            logger.error("❌ GROQ_API_KEY not configured; skipping AI enrichment")
            return ""

        url = "https://api.groq.com/openai/v1/chat/completions"
        headers = {
            "Authorization": f"Bearer {self.groq_api_key}",
            "Content-Type": "application/json"
        }
        payload = {
            "model": "llama-3.3-70b-versatile",
            "messages": [
                {"role": "user", "content": prompt}
            ],
            "temperature": 0.2,
            "max_tokens": 1200
        }

        for attempt in range(retries):
            try:
                response = requests.post(url, headers=headers, json=payload, timeout=30)
                response.raise_for_status()
                data = response.json()
                return data.get("choices", [{}])[0].get("message", {}).get("content", "") or ""
            except Exception as e:
                wait_time = 2 * (attempt + 1)
                logger.warning(f"Groq request failed (attempt {attempt + 1}/{retries}): {e}")
                time.sleep(wait_time)
        return ""

    @staticmethod
    def _get_embedding_sync(text: str):
        """Эмбеддинг для синхронизаций. Приводим размерность к 768."""
        try:
            result = genai.embed_content(
                model="models/gemini-embedding-001",
                content=text,
                task_type="retrieval_document"
            )
            embedding = result.get('embedding')
            if embedding is None:
                return None

            embedding = list(embedding)
            if len(embedding) == 768:
                return embedding

            logger.warning(
                f"Embedding dimension mismatch (gemini-embedding-001): {len(embedding)}. "
                "Falling back to text-embedding-004."
            )

            fallback = genai.embed_content(
                model="models/text-embedding-004",
                content=text,
                task_type="retrieval_document"
            )
            fallback_embedding = fallback.get('embedding')
            if fallback_embedding is None:
                return None

            fallback_embedding = list(fallback_embedding)
            if len(fallback_embedding) != 768:
                logger.error(
                    f"Embedding dimension mismatch (text-embedding-004): {len(fallback_embedding)}. "
                    "Skipping embedding."
                )
                return None

            return fallback_embedding
        except Exception as e:
            logger.error(f"Embedding error (sync): {e}")
            return None

    def _build_embedding_text(self, complex_obj, features: dict, kind: str, side_str: str) -> str:
        atm_str = ", ".join(features.get('atmosphere', []))
        tags_str = ", ".join(features.get('tags', []))

        if kind == "commercial":
            return (
                f"Коммерческий объект {complex_obj.name}. Город Астана. "
                f"Район: {features.get('district_name')}. {side_str}. "
                f"Атмосфера: {atm_str}. "
                f"Бизнес-инфраструктура: {tags_str}. "
                f"Адрес: {complex_obj.address}."
            )

        return (
            f"ЖК {complex_obj.name}. Город Астана. "
            f"Район: {features.get('district_name')}. {side_str}. "
            f"Атмосфера: {atm_str}. "
            f"Инфраструктура рядом: {tags_str}. "
            f"Адрес: {complex_obj.address}."
        )

    def _sync_units_batch(self, complex_obj, units_data: list, unit_model):
        """Массовое сохранение юнитов (квартиры или помещения)"""
        current_uuids = []

        for u in units_data:
            try:
                # Цена: берем цену со скидкой, если есть
                price = u.get("totalPrice", 0)
                price_disc = u.get("totalPriceWithDiscount")
                final_price = price_disc if price_disc else price

                if not final_price:
                    continue

                photos = [
                    u.get("photoURL1600"),
                ]
                photos = [p for p in photos if p]
                photos = list(dict.fromkeys(photos))

                unit, _ = unit_model.objects.update_or_create(
                    bi_uuid=u.get("uuid"),
                    defaults={
                        "complex": complex_obj,
                        "room_count": u.get("roomCount", 0),
                        "floor": u.get("floor", 0),
                        "max_floor": u.get("maxFloor", 0),
                        "area": u.get("square", 0.0),
                        "price": final_price,
                        "price_discount": price_disc,
                        "deadline": u.get("deadLine", ""),
                        "is_active": True,
                        "photos": photos,
                    }
                )
                current_uuids.append(u.get("uuid"))
            except Exception:
                continue

        # Помечаем проданные как неактивные
        if current_uuids:
            unit_model.objects.filter(complex=complex_obj).exclude(bi_uuid__in=current_uuids).update(is_active=False)
