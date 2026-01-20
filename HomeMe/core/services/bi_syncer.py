import logging
import json
from django.conf import settings
from telegram_bot.models import BIComplex, BIUnit
from core.bi_client import EnhancedBIGroupClient
from core.services.ai_service import EnhancedAIService

logger = logging.getLogger(__name__)


class BISyncService:
    def __init__(self):
        self.client = EnhancedBIGroupClient()
        self.ai = EnhancedAIService()
        self.ASTANA_UUID = self.client.CITY_MAP.get("Astana", "4c0fe725-4b6f-11e8-80cf-bb580b2abfef")

    def run_full_sync(self):
        """Полная синхронизация ЖК и квартир с умным обогащением данных"""
        logger.info("🚀 Starting Smart Full Sync...")

        # 1. Получаем все ЖК
        complexes_data = self.client.get_all_real_estates()
        logger.info(f"🏢 Found {len(complexes_data)} complexes via API")

        synced_count = 0
        for item in complexes_data:
            if self._sync_complex_and_units(item):
                synced_count += 1

        logger.info(f"✅ Smart Sync Complete! Synced {synced_count} complexes in Astana.")

    def _sync_complex_and_units(self, item: dict):
        """Синхронизация одного ЖК, AI-анализ локации и обновление квартир"""
        try:
            item_city_uuid = item.get("cityUUID")
            if item_city_uuid != self.ASTANA_UUID:
                return False

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
                "description": f"ЖК {name}. Адрес: {address}"
            }

            complex_obj, created = BIComplex.objects.update_or_create(
                bi_uuid=bi_uuid,
                defaults=defaults
            )

            if created:
                logger.info(f"✨ New Complex Created: {name}")
            else:
                pass

            # --- AI ОБОГАЩЕНИЕ (Feedback Loop) ---
            # Запускаем анализ, если ЖК новый ИЛИ у него пустые features ИЛИ нет вектора
            if created or not complex_obj.features or complex_obj.embedding is None:
                self._enrich_complex_with_deep_analysis(complex_obj)

            # Синхронизация квартир
            placements = self.client.get_placements_for_complex(bi_uuid)
            if placements:
                self._sync_units_batch(complex_obj, placements)

        except Exception as e:
            logger.error(f"⚠️ Error syncing complex {item.get('name')}: {e}")

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
                logger.warning(f"⚠️ Empty analysis for {complex_obj.name}")

        except Exception as e:
            logger.error(f"❌ AI Enrichment failed: {e}")

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
