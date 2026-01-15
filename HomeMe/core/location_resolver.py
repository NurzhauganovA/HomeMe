import math
from typing import Any, Dict, List, Optional

# Маппинг "человеческих" районов к координатам и алиасам.
# Используем чтобы понимать запросы вроде "рядом с EXPO" или "левый берег".
LOCATION_PRESETS: List[Dict[str, Any]] = [
    {
        "city": "Astana",
        "slug": "expo",
        "center": (51.0909, 71.4167),
        "radius_km": 5.0,
        "aliases": ["expo", "exро", "экспо", "astana expo"],
        "keywords": ["expo", "mega silk way", "mega silkway", "мега силк", "nazarbayev university"],
    },
    {
        "city": "Astana",
        "slug": "left_bank",
        "center": (51.1280, 71.4300),
        "radius_km": 7.5,
        "aliases": ["левый берег", "левберег", "левый", "esil", "yesil", "yessil", "есиль", "esilsky"],
        "keywords": ["левый", "esil", "есиль", "байтерек", "akorda", "хан шатыр", "ханшатыр", "turan"],
    },
    {
        "city": "Astana",
        "slug": "right_bank",
        "center": (51.1625, 71.4440),
        "radius_km": 6.5,
        "aliases": ["правый берег", "правберег", "старый город", "старый центр"],
        "keywords": ["правый", "старый", "сарыарка", "абая", "кенесары"],
    },
    {
        "city": "Astana",
        "slug": "mega_silk_way",
        "center": (51.0962, 71.4035),
        "radius_km": 3.5,
        "aliases": ["mega silk way", "мега силк", "мега silk", "silk way", "mega silkway"],
        "keywords": ["mega silk", "mega silk way", "мега силк", "mega silkway"],
    },
]


def _norm(text: Optional[str]) -> str:
    return text.lower().strip() if text else ""


def haversine_km(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """Возвращает расстояние между точками в км."""
    r = 6371  # радиус Земли
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    d_phi = math.radians(lat2 - lat1)
    d_lambda = math.radians(lon2 - lon1)

    a = math.sin(d_phi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(d_lambda / 2) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return r * c


def resolve_location(city: Optional[str], district: Optional[str]) -> Optional[Dict[str, Any]]:
    """
    Возвращает словарь с центром района и алиасами.
    Если city не указан, подбираем район по алиасам.
    """
    if not district:
        return None

    city_norm = _norm(city)
    district_norm = _norm(district)

    # Сначала пробуем по городу
    for loc in LOCATION_PRESETS:
        if city_norm and _norm(loc["city"]) != city_norm:
            continue
        if any(alias in district_norm for alias in loc["aliases"]):
            return loc

    # Если город не указан, ищем по всем
    if not city_norm:
        for loc in LOCATION_PRESETS:
            if any(alias in district_norm for alias in loc["aliases"]):
                return loc

    return None


def infer_city_from_district(district: Optional[str]) -> Optional[str]:
    """Определяет город по алиасам района (например, EXPO -> Astana)."""
    loc = resolve_location(None, district)
    return loc["city"] if loc else None


def within_location(lat: Optional[float], lon: Optional[float], location: Dict[str, Any]) -> bool:
    """Проверяет, попадает ли точка в радиус района."""
    if lat is None or lon is None:
        return False
    center_lat, center_lon = location["center"]
    return haversine_km(lat, lon, center_lat, center_lon) <= location["radius_km"]


def text_matches_location(text: Optional[str], location: Dict[str, Any]) -> bool:
    """Фолбэк: поиск по ключевым словам в названии/адресе."""
    if not text:
        return False
    normalized = _norm(text)
    for keyword in location.get("keywords", []):
        if keyword in normalized:
            return True
    for alias in location.get("aliases", []):
        if alias in normalized:
            return True
    return False


def collect_location_keywords(location: Optional[Dict[str, Any]], fallback: Optional[str] = None) -> List[str]:
    """Собирает ключевые слова для поиска по тексту."""
    if not location:
        return [fallback] if fallback else []
    keywords = set(location.get("keywords", [])) | set(location.get("aliases", []))
    if fallback:
        keywords.add(_norm(fallback))
    return [k for k in keywords if k]
