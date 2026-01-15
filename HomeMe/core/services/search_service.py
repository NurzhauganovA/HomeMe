from pgvector.django import CosineDistance
from core.bi_client import BIGroupClient
from telegram_bot.models import SecondaryProperty
from core.dto import PropertyDTO
from core.services.ai_service import AIService


class UnifiedSearchService:
    def __init__(self):
        self.bi_client = BIGroupClient()
        self.ai_service = AIService()

    def search(self, rooms=None, max_price=None, city=None, district=None, source='all', query_text=None) -> list[PropertyDTO]:
        results = []

        # 1. BI Group (API + Фильтры)
        if source in ['all', 'bi_group']:
            bi_results = self.bi_client.search_properties(
                rooms=rooms,
                max_price=max_price,
                city=city,
                district=district,
            )
            results.extend(bi_results)

        # 2. Вторичка (Векторный поиск + Фильтры)
        if source in ['all', 'secondary']:
            qs = SecondaryProperty.objects.filter(is_active=True)

            # Сначала жесткие фильтры (это ускоряет поиск)
            if rooms:
                qs = qs.filter(rooms=rooms)
            if max_price:
                qs = qs.filter(price__lte=max_price)

            # Если есть текст запроса -> Сортируем по смыслу
            if query_text:
                query_vec = self.ai_service.get_embedding(query_text)

                if query_vec:
                    # CosineDistance: чем меньше число, тем ближе смысл (0 = идентично)
                    qs = qs.alias(distance=CosineDistance('embedding', query_vec)) \
                        .order_by('distance')
                else:
                    # Если вектор не создался, просто последние добавленные
                    qs = qs.order_by('-created_at')
            else:
                qs = qs.order_by('-created_at')

            # Берем топ-3 самых подходящих
            for p in qs[:3]:
                dto = PropertyDTO(
                    source="secondary",
                    title=p.title,
                    address=p.address,
                    price=float(p.price),
                    rooms=p.rooms,
                    area=p.area,
                    floor=p.floor,
                    description=p.description,
                    url=f"https://homeme.kz/obj/{p.id}"
                )
                results.append(dto)

        return results