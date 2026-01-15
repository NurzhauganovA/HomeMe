"""
Динамический географический резолвер на базе AI.
Вместо хардкода использует Gemini для понимания любых локаций.
"""

import math
import logging
from typing import Dict, List, Optional, Tuple
import json

logger = logging.getLogger(__name__)


class DynamicLocationResolver:
    """
    AI-powered географический резолвер.
    Понимает ЛЮБЫЕ запросы локаций без предустановленных словарей.
    """

    # Базовые координаты городов (фиксированные)
    CITY_COORDINATES = {
        'Astana': (51.1694, 71.4491),
        'Almaty': (43.2220, 76.8512),
        'Shymkent': (42.3417, 69.5901),
        'Atyrau': (47.1164, 51.8820)
    }

    # Радиусы поиска по умолчанию (км)
    DEFAULT_SEARCH_RADIUS = {
        'landmark': 3.0,  # EXPO, Mega и т.д.
        'district': 7.0,  # Есильский район
        'area': 5.0,  # Левый берег
        'city': 15.0  # Весь город
    }

    def __init__(self, ai_service):
        """
        Args:
            ai_service: Instance of EnhancedAIService для AI-запросов
        """
        self.ai = ai_service
        self._cache = {}  # Кэш для частых запросов

    def resolve_any_location(self, user_query: str, city_hint: Optional[str] = None) -> Optional[Dict]:
        """
        ГЛАВНЫЙ МЕТОД: Резолвит ЛЮБУЮ локацию через AI.

        Args:
            user_query: Запрос пользователя ("рядом с EXPO", "левый берег", "Ботанический сад")
            city_hint: Подсказка о городе (если известен из контекста)

        Returns:
            Dict с полной информацией о локации или None
        """
        cache_key = f"{city_hint}:{user_query}"
        if cache_key in self._cache:
            logger.info(f"📦 Location cache hit: {cache_key}")
            return self._cache[cache_key]

        # Используем AI для интерпретации локации
        location_data = self.ai.resolve_location_intelligence(user_query, {'city': city_hint})

        if not location_data or location_data.get('confidence', 0) < 0.35:
            logger.warning(f"⚠️ Could not resolve location: {user_query}")
            return None

        # Обогащаем данные координатами и радиусом
        enriched = self._enrich_location_data(location_data)

        self._cache[cache_key] = enriched
        return enriched

    def _enrich_location_data(self, ai_data: Dict) -> Dict:
        """
        Обогащает AI-данные координатами и параметрами поиска.
        """
        city = ai_data.get('city')
        district = ai_data.get('district')
        landmarks = ai_data.get('nearby_landmarks', [])
        coords_estimate = ai_data.get('coordinates_estimate', {})

        # Определяем центр и радиус
        if coords_estimate and coords_estimate.get('lat'):
            center = (coords_estimate['lat'], coords_estimate['lon'])
            radius = ai_data.get('radius_km', self.DEFAULT_SEARCH_RADIUS['landmark'])
        elif district and city:
            center = self.CITY_COORDINATES.get(city)
            radius = self.DEFAULT_SEARCH_RADIUS['district']
        elif city:
            center = self.CITY_COORDINATES.get(city)
            radius = self.DEFAULT_SEARCH_RADIUS['city']
        else:
            center = None
            radius = None

        return {
            **ai_data,
            'center_coordinates': center,
            'search_radius_km': radius,
            'search_type': self._determine_search_type(ai_data),
            'keywords_for_text_search': self._extract_search_keywords(ai_data)
        }

    def _determine_search_type(self, data: Dict) -> str:
        """Определяет тип локационного поиска"""
        if data.get('nearby_landmarks'):
            return 'landmark'
        elif data.get('district'):
            return 'district'
        elif data.get('city'):
            return 'city'
        return 'unknown'

    def _extract_search_keywords(self, data: Dict) -> List[str]:
        """Собирает все ключевые слова для текстового поиска"""
        keywords = set()

        if data.get('district'):
            keywords.add(data['district'])

        if data.get('district_normalized'):
            keywords.add(data['district_normalized'])

        for landmark in data.get('nearby_landmarks', []):
            keywords.add(landmark)

        # Добавляем вариации
        if 'EXPO' in keywords:
            keywords.update(['Экспо', 'EXPO', 'expo', 'Expo'])

        return list(keywords)

    @staticmethod
    def haversine_distance(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
        """Расстояние между двумя точками в км"""
        R = 6371  # радиус Земли в км

        phi1 = math.radians(lat1)
        phi2 = math.radians(lat2)
        delta_phi = math.radians(lat2 - lat1)
        delta_lambda = math.radians(lon2 - lon1)

        a = (math.sin(delta_phi / 2) ** 2 +
             math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2) ** 2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

        return R * c

    def is_within_location(self, lat: float, lon: float, location_data: Dict) -> bool:
        """
        Проверяет, находится ли точка (lat, lon) внутри локации.
        """
        center = location_data.get('center_coordinates')
        radius = location_data.get('search_radius_km')

        if not center or not radius:
            return False

        distance = self.haversine_distance(lat, lon, center[0], center[1])
        return distance <= radius

    def text_matches_location(self, text: str, location_data: Dict) -> bool:
        """
        Проверяет, упоминается ли локация в тексте (fallback для объектов без координат).
        """
        if not text:
            return False

        text_lower = text.lower()
        keywords = location_data.get('keywords_for_text_search', [])

        for keyword in keywords:
            if keyword.lower() in text_lower:
                return True

        return False


# ========== УТИЛИТЫ ==========

def create_location_filter_for_search(location_data: Optional[Dict]) -> Dict:
    """
    Создает параметры фильтрации для передачи в search сервисы.

    Returns:
        Dict с ключами: coordinates, radius, text_keywords, city, district
    """
    if not location_data:
        return {}

    return {
        'coordinates': location_data.get('center_coordinates'),
        'radius_km': location_data.get('search_radius_km'),
        'text_keywords': location_data.get('keywords_for_text_search', []),
        'city': location_data.get('city'),
        'district': location_data.get('district'),
        'location_type': location_data.get('search_type'),
        'confidence': location_data.get('location_confidence', 0)
    }


def merge_location_with_user_filters(location_filter: Dict, user_params: Dict) -> Dict:
    """
    Объединяет локационные фильтры с пользовательскими параметрами.
    """
    merged = {**user_params}

    if location_filter.get('city') and not merged.get('city'):
        merged['city'] = location_filter['city']

    if location_filter.get('district'):
        merged['district'] = location_filter['district']

    # Добавляем геоданные для умного поиска
    merged['_geo_center'] = location_filter.get('coordinates')
    merged['_geo_radius'] = location_filter.get('radius_km')
    merged['_location_keywords'] = location_filter.get('text_keywords', [])

    return merged