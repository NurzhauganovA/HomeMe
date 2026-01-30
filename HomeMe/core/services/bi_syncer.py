import logging
import json
from django.conf import settings
from telegram_bot.models import BIComplex, BIUnit, BICommercialComplex, BICommercialUnit
from core.bi_client import EnhancedBIGroupClient
from core.services.ai_service import EnhancedAIService

logger = logging.getLogger(__name__)


class BISyncService:
    def __init__(self):
        self.client = EnhancedBIGroupClient()
        self.ai = EnhancedAIService(text_provider="groq")
        self.ASTANA_UUID = self.client.CITY_MAP.get("Astana", "4c0fe725-4b6f-11e8-80cf-bb580b2abfef")
        self.backfill_missing = getattr(settings, "SYNC_BACKFILL_MISSING", False)

    def run_full_sync(self):
        """Полная синхронизация ЖК и квартир с умным обогащением данных"""
        logger.info("🚀 Starting Smart Full Sync...")
        mode = "add-only (skip existing, no AI backfill)"
        if self.backfill_missing:
            mode = "add-only + backfill missing AI for existing"
        logger.info(f"🧾 Sync mode: {mode}")

        # 1. Получаем все ЖК
        complexes_data = self.client.get_all_real_estates()
        logger.info(f"🏢 Found {len(complexes_data)} complexes via API")

        synced_count = 0
        skipped_ai_count = 0
        for item in complexes_data:
            logger.info(f"🔄 Syncing residential: {item.get('name')}")
            ai_status = self._sync_complex_and_units(item)
            synced_count += 1
            if ai_status == 0:
                skipped_ai_count += 1

        # 2. Получаем все коммерческие объекты
        commercial_data = self.client.get_all_real_estates_office()
        logger.info(f"🏢 Found {len(commercial_data)} commercial objects via API")

        commercial_synced = 0
        commercial_skipped = 0
        for item in commercial_data:
            logger.info(f"🔄 Syncing commercial: {item.get('name')}")
            ai_status = self._sync_commercial_complex_and_units(item)
            commercial_synced += 1
            if ai_status == 0:
                commercial_skipped += 1


        logger.info(
            "✅ Smart Sync Complete! "
            f"Synced {synced_count} residential, {commercial_synced} commercial. "
            f"AI Skipped (Saved tokens): {skipped_ai_count + commercial_skipped}"
        )

    def _sync_complex_and_units(self, item: dict):
        """Синхронизация одного ЖК, AI-анализ локации и обновление квартир"""
        try:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != self.ASTANA_UUID:
                return None

            bi_uuid = item.get("uuid")
            name = item.get("name")
            address = item.get("address", "")

            complex_obj, created = BIComplex.objects.get_or_create(
                bi_uuid=bi_uuid,
                defaults={
                    "name": name,
                    "address": address,
                    "city_uuid": item.get("cityUUID", ""),
                    "latitude": item.get("latitude"),
                    "longitude": item.get("longitude"),
                    "url": item.get("website", ""),
                    "image_url": item.get("photoURL400") or item.get("photoURL", ""),
                    "class_name": item.get('propertyClassName', [''])[0] if item.get('propertyClassName') else "",
                    "description": f"ЖК {name}. Адрес: {address}"
                }
            )

            if not created:
                if self.backfill_missing and (not complex_obj.features or complex_obj.embedding is None):
                    logger.info(f"🧠 Backfilling AI for existing residential: {name}")
                else:
                    logger.info(f"⏭️ Exists, skipping residential: {name}")
                    return 0

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
                self._sync_units_batch(complex_obj, placements)

            return status

        except Exception as e:
            logger.error(f"⚠️ Error syncing complex {item.get('name')}: {e}")
            return None

    def _sync_commercial_complex_and_units(self, item: dict):
        """Синхронизация коммерческого объекта, AI-анализ и обновление помещений"""
        try:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != self.ASTANA_UUID:
                return None

            bi_uuid = item.get("uuid")
            name = item.get("name")
            address = item.get("address", "")

            complex_obj, created = BICommercialComplex.objects.get_or_create(
                bi_uuid=bi_uuid,
                defaults={
                    "name": name,
                    "address": address,
                    "city_uuid": item.get("cityUUID", ""),
                    "latitude": item.get("latitude"),
                    "longitude": item.get("longitude"),
                    "url": item.get("website", ""),
                    "image_url": item.get("photoURL400") or item.get("photoURL", ""),
                    "class_name": item.get('propertyClassName', [''])[0] if item.get('propertyClassName') else "",
                    "description": f"Коммерческий объект {name}. Адрес: {address}"
                }
            )

            if not created:
                if self.backfill_missing and (not complex_obj.features or complex_obj.embedding is None):
                    logger.info(f"🧠 Backfilling AI for existing commercial: {name}")
                else:
                    logger.info(f"⏭️ Exists, skipping commercial: {name}")
                    return 0

            status = 0

            if not complex_obj.features:
                logger.info(f"🤖 AI Analysis needed for commercial {name} (No features)...")
                self._enrich_commercial_complex_with_deep_analysis(complex_obj)
                status = 1
            elif complex_obj.embedding is None:
                logger.info(f"🧬 Generating Embedding only for commercial {name} (Features exist)...")
                self._regenerate_commercial_embedding_from_features(complex_obj)
                status = 2
            else:
                logger.info(f"⏭️ SKIPPING AI for commercial {name} (All data present)")
                status = 0

            placements = self.client.get_placements_for_complex_office(bi_uuid)
            if placements:
                self._sync_commercial_units_batch(complex_obj, placements)

            return status

        except Exception as e:
            logger.error(f"⚠️ Error syncing commercial complex {item.get('name')}: {e}")

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
            response = self.ai._generate_with_retry(prompt, json_mode=True)
            text = self.ai._extract_text(response)
            analysis = self.ai._parse_json_response(text)

            if analysis:
                # 1. Сохраняем жесткие теги в JSONField
                complex_obj.features = analysis
                self._regenerate_embedding_from_features(complex_obj)

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

                embedding = self.ai.get_embedding(rich_text)
                if embedding:
                    complex_obj.embedding = embedding

                complex_obj.save()
                logger.info(f"✅ Enriched {complex_obj.name}: {side_str}, {analysis.get('atmosphere')}")
            else:
                logger.warning(f"⚠️ Empty analysis for {complex_obj.name}. Raw: {text[:300]}")

        except Exception as e:
            logger.error(f"❌ AI Enrichment failed: {e}")

    def _enrich_commercial_complex_with_deep_analysis(self, complex_obj: BICommercialComplex):
        """
        AI-агент, который классифицирует коммерческий объект для бизнес-поиска.
        """
        logger.info(f"🧠 Deep Analyzing Commercial Location: {complex_obj.name}...")

        prompt = f"""
        Ты — эксперт по коммерческой недвижимости Астаны и Алматы.

        Объект: "{complex_obj.name}"
        Адрес: "{complex_obj.address}"

        Твоя задача — классифицировать объект для фильтров бизнес-поиска.

        1. ОПРЕДЕЛИ БЕРЕГ (Только для Астаны):
           - "Left": Есильский район, Нура, район EXPO, Ботанический сад.
           - "Right": Сарыарка, Байконур, Алматинский район.

        2. ДЕЛОВАЯ АТМОСФЕРА (СТРОГО НА РУССКОМ):
           - Используй прилагательные: "деловой", "оживленный", "трафиковый",
             "витринный", "престижный", "тихий", "проходимый", "центральный".
           - Добавь дополнительные слова: "первая линия", "близко к БЦ",
             "офисный кластер", "парковка", "транспортная доступность".

        3. ТЕГИ: Добавь список тегов для коммерции (стрит-ритейл, БЦ, трафик, парковка,
           витрина, общественный транспорт, метро/остановка, рядом ТРЦ, офисный поток).
           Нужны максимум полезных и конкретных тегов.

        Верни ответ СТРОГО в формате JSON:
        {{
            "side": "Right" (или "Left"),
            "district_name": "Есильский",
            "atmosphere": ["деловой", "трафиковый", "первая линия", ...],
            "tags": ["стрит-ритейл", "витрина", "парковка", ...]
        }}
        """

        try:
            response = self.ai._generate_with_retry(prompt, json_mode=True)
            text = self.ai._extract_text(response)
            analysis = self.ai._parse_json_response(text)

            if analysis:
                complex_obj.features = analysis
                self._regenerate_commercial_embedding_from_features(complex_obj)

                side_str = "Левый берег" if analysis.get('side') == 'Left' else "Правый берег"

                rich_text = (
                    f"Коммерческий объект {complex_obj.name}. "
                    f"Район: {analysis.get('district_name')}. {side_str}. "
                    f"Атмосфера: {analysis.get('atmosphere')}. "
                    f"Рядом: {', '.join(analysis.get('tags', []))}. "
                    f"Адрес: {complex_obj.address}."
                )

                embedding = self.ai.get_embedding(rich_text)
                if embedding:
                    complex_obj.embedding = embedding

                complex_obj.save()
                logger.info(f"✅ Enriched commercial {complex_obj.name}: {side_str}, {analysis.get('atmosphere')}")
            else:
                logger.warning(f"⚠️ Empty commercial analysis for {complex_obj.name}. Raw: {text[:300]}")

        except Exception as e:
            logger.error(f"❌ Commercial AI Enrichment failed: {e}")

    def _regenerate_embedding_from_features(self, complex_obj: BIComplex):
        """Генерация вектора из уже существующих features (без запроса классификации)"""
        if not complex_obj.features:
            return

        features = complex_obj.features

        # Формируем текст для вектора
        side_str = "Левый берег" if features.get('side') == 'Left' else "Правый берег"
        atm_str = ", ".join(features.get('atmosphere', []))
        tags_str = ", ".join(features.get('tags', []))

        rich_text = (
            f"ЖК {complex_obj.name}. Город Астана. "
            f"Район: {features.get('district_name')}. {side_str}. "
            f"Атмосфера: {atm_str}. "
            f"Инфраструктура рядом: {tags_str}. "
            f"Адрес: {complex_obj.address}."
        )

        # Запрос только на эмбеддинг (это дешевле)
        embedding = self.ai.get_embedding(rich_text)
        if embedding:
            complex_obj.embedding = embedding
            complex_obj.save()
            logger.info(f"✅ Embedding saved for {complex_obj.name}")

    def _regenerate_commercial_embedding_from_features(self, complex_obj: BICommercialComplex):
        """Генерация вектора для коммерческих объектов из features"""
        if not complex_obj.features:
            return

        features = complex_obj.features
        side_str = "Левый берег" if features.get('side') == 'Left' else "Правый берег"
        atm_str = ", ".join(features.get('atmosphere', []))
        tags_str = ", ".join(features.get('tags', []))

        rich_text = (
            f"Коммерческий объект {complex_obj.name}. "
            f"Город Астана. Район: {features.get('district_name')}. {side_str}. "
            f"Деловая атмосфера: {atm_str}. "
            f"Коммерческие теги: {tags_str}. "
            f"Адрес: {complex_obj.address}."
        )

        embedding = self.ai.get_embedding(rich_text)
        if embedding:
            complex_obj.embedding = embedding
            complex_obj.save()
            logger.info(f"✅ Commercial embedding saved for {complex_obj.name}")

    def _sync_units_batch(self, complex_obj: BIComplex, units_data: list):
        """Массовое сохранение квартир"""
        current_uuids = []

        for u in units_data:
            try:
                # Цена: берем цену со скидкой, если есть
                price = u.get("totalPrice", 0)
                price_disc = u.get("totalPriceWithDiscount")
                final_price = price_disc if price_disc else price

                if not final_price:
                    continue

                unit, _ = BIUnit.objects.update_or_create(
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
                        "is_active": True
                    }
                )
                current_uuids.append(u.get("uuid"))
            except Exception:
                continue

        # Помечаем проданные как неактивные
        if current_uuids:
            BIUnit.objects.filter(complex=complex_obj).exclude(bi_uuid__in=current_uuids).update(is_active=False)

    def _sync_commercial_units_batch(self, complex_obj: BICommercialComplex, units_data: list):
        """Массовое сохранение коммерческих помещений"""
        current_uuids = []

        for u in units_data:
            try:
                price = u.get("totalPrice", 0)
                price_disc = u.get("totalPriceWithDiscount")
                final_price = price_disc if price_disc else price

                if not final_price:
                    continue

                BICommercialUnit.objects.update_or_create(
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
                        "is_active": True
                    }
                )
                current_uuids.append(u.get("uuid"))
            except Exception:
                continue

        if current_uuids:
            BICommercialUnit.objects.filter(complex=complex_obj).exclude(
                bi_uuid__in=current_uuids
            ).update(is_active=False)
