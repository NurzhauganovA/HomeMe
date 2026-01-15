from pgvector.django import CosineDistance
from django.db.models import Q
from core.bi_client import BIGroupClient
from telegram_bot.models import SecondaryProperty
from core.dto import PropertyDTO
from core.services.ai_service import AIService
from core.location_resolver import resolve_location, infer_city_from_district, collect_location_keywords


class UnifiedSearchService:
    def __init__(self):
        self.bi_client = BIGroupClient()
        self.ai_service = AIService()

    def search(self, rooms=None, max_price=None, city=None, district=None, source='all', query_text=None,
               location_keywords=None, lifestyle_tags=None) -> list[PropertyDTO]:
        results = []

        # Нормализуем город по району, чтобы "EXPO" привязывался к Астане
        resolved_location = resolve_location(city, district)
        if not city and district:
            city = infer_city_from_district(district) or city

        # 1. BI Group (API + Фильтры)
        if source in ['all', 'bi_group']:
            bi_results = self.bi_client.search_properties(
                rooms=rooms,
                max_price=max_price,
                city=city,
                district=district,
                location=resolved_location,
                location_keywords=location_keywords,
            )
            results.extend(bi_results)

        # 2. Вторичка (Векторный поиск + Фильтры)
        if source in ['all', 'secondary']:
            qs = SecondaryProperty.objects.filter(is_active=True)

            # Сначала жесткие фильтры
            if rooms:
                qs = qs.filter(rooms=rooms)
            if max_price:
                qs = qs.filter(price__lte=max_price)

            # Фильтр по району/локации (текстовый, т.к. нет координат)
            combined_keywords = collect_location_keywords(resolved_location, district)
            if location_keywords:
                combined_keywords.extend([kw for kw in location_keywords if kw])
            if combined_keywords:
                location_query = Q()
                for kw in combined_keywords:
                    location_query |= Q(address__icontains=kw) | Q(title__icontains=kw) | Q(description__icontains=kw)
                qs = qs.filter(location_query)

            # Если есть текст запроса -> Сортируем по смыслу
            embedding_pieces = []
            if query_text:
                embedding_pieces.append(query_text)
            if district:
                embedding_pieces.append(str(district))
            if lifestyle_tags:
                embedding_pieces.append(" ".join(lifestyle_tags))
            if combined_keywords:
                embedding_pieces.append(" ".join(combined_keywords))

            embedding_text = " ; ".join(embedding_pieces).strip() if embedding_pieces else None
            if embedding_text:
                query_vec = self.ai_service.get_embedding(embedding_text)

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