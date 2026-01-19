import logging
from django.utils import timezone
from core.bi_client import EnhancedBIGroupClient
from telegram_bot.models import BIComplex, BIUnit
from core.services.ai_service import EnhancedAIService

logger = logging.getLogger(__name__)


class BISyncService:
    def __init__(self):
        self.client = EnhancedBIGroupClient()
        self.ai = EnhancedAIService()

    def run_full_sync(self):
        """Основной метод запуска"""
        logger.info("🚀 Starting Full BI Group Sync...")

        # 1. Синхронизируем ЖК (RealEstates)
        complexes_data = self.client.get_all_real_estates()
        logger.info(f"🏢 Found {len(complexes_data)} complexes via API")

        for item in complexes_data:
            self._sync_complex(item)

        logger.info("✅ Complexes synced. Starting Units sync...")

        # 2. Синхронизируем Квартиры (Units) для каждого активного ЖК
        # Можно оптимизировать и обновлять не все сразу, если их очень много
        active_complexes = BIComplex.objects.all()

        total_units = 0
        for comp in active_complexes:
            units = self.client.get_placements_for_complex(comp.bi_uuid)
            if units:
                self._sync_units_batch(comp, units)
                total_units += len(units)

        logger.info(f"🎉 Full Sync Complete! Total units available: {total_units}")

    def _sync_complex(self, item: dict):
        """Сохранение/Обновление ЖК"""
        try:
            bi_uuid = item.get("uuid")

            # Маппинг полей из вашего JSON
            defaults = {
                "name": item.get("name"),
                "address": item.get("address", ""),
                "city_uuid": item.get("cityUUID", ""),
                "latitude": item.get("latitude"),
                "longitude": item.get("longitude"),
                "min_price": item.get("minTotalPrice"),
                "deadline": item.get("deadline", ""),
                "image_url": item.get("photoURL400", ""),
                "website": item.get("website", ""),
                # Берем первый класс из списка, если есть
                "class_name": item.get("propertyClassName", [""])[0] if item.get("propertyClassName") else ""
            }

            obj, created = BIComplex.objects.update_or_create(
                bi_uuid=bi_uuid,
                defaults=defaults
            )

            # === AI Обогащение (только для новых или если нет вектора) ===
            if created or obj.embedding is None:
                self._enrich_complex_with_ai(obj)

        except Exception as e:
            logger.error(f"⚠️ Error syncing complex {item.get('name')}: {e}")

    def _sync_units_batch(self, complex_obj: BIComplex, units_data: list):
        """Массовое сохранение квартир одного ЖК"""

        # Сначала пометим все старые как неактивные (или удалим)
        # Стратегия soft-delete: ставим is_active=False, потом обновляем найденные в True
        BIUnit.objects.filter(complex=complex_obj).update(is_active=False)

        for u in units_data:
            try:
                # Цена: приоритет на цену со скидкой
                price = u.get("totalPrice", 0)
                price_disc = u.get("totalPriceWithDiscount")

                BIUnit.objects.update_or_create(
                    bi_uuid=u.get("uuid"),
                    defaults={
                        "complex": complex_obj,
                        "room_count": u.get("roomCount", 0),
                        "floor": u.get("floor", 0),
                        "max_floor": u.get("maxFloor", 0),
                        "area": u.get("square", 0.0),
                        "price": price,
                        "price_discount": price_disc if price_disc else price,
                        "block_name": u.get("blockName", ""),
                        "deadline": u.get("deadLine", ""),
                        "is_active": True
                    }
                )
            except Exception as e:
                continue

    def _enrich_complex_with_ai(self, complex_obj: BIComplex):
        """
        Генерирует вектор и теги для ЖК.
        """
        logger.info(f"🧠 AI Processing for {complex_obj.name}...")

        # 1. Извлекаем теги (тихо, парк, школа) через Gemini
        # Формируем промпт на основе адреса и названия
        description_text = f"{complex_obj.name} {complex_obj.address} {complex_obj.class_name}"

        # Используем существующий метод
        lifestyle = self.ai.extract_lifestyle_preferences(description_text)
        tags_list = lifestyle.get('lifestyle_tags', [])

        # Если пришел None или не список, делаем пустой список
        if not isinstance(tags_list, list):
            tags_list = []

        # Превращаем ['quiet', 'park'] -> {'quiet': True, 'park': True}
        complex_obj.features = {tag: True for tag in tags_list}

        # 2. Генерируем вектор (Embeddings)
        full_text = complex_obj.get_text_for_embedding()
        embedding = self.ai.get_embedding(full_text)

        if embedding is not None:
            complex_obj.embedding = embedding
            complex_obj.save()