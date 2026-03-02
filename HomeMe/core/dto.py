"""
Enhanced Data Transfer Objects (DTO)
Профессиональные модели данных для передачи информации о недвижимости
между слоями приложения.
"""

from dataclasses import dataclass, field
from typing import Optional, List, Dict, Union
from datetime import datetime
from urllib.parse import quote


@dataclass
class PropertyDTO:
    """
    Унифицированный DTO для объекта недвижимости.
    Работает как для BI Group API, так и для вторичного рынка.
    """

    # Обязательные поля
    source: str  # 'bi_group' или 'secondary'
    title: str
    address: str
    price: float  # В тенге
    rooms: int
    area: float  # Площадь в м²
    floor: int

    # Опциональные поля
    description: str = ""
    url: str = ""
    image_url: str = ""
    image_urls: List[str] = field(default_factory=list)
    object_id: Optional[str] = None
    object_kind: Optional[str] = None  # "unit", "complex", "secondary"

    # Дополнительные метаданные
    total_floors: Optional[int] = None
    building_type: Optional[str] = None  # "new", "secondary"
    property_class: Optional[str] = None  # "Стандарт", "Комфорт lite", "Комфорт", "Комфорт+", "Бизнес", "Бизнес+", "Премиум"
    deadline: Optional[str] = None  # Срок сдачи для новостроек

    # Геолокация
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    district: Optional[str] = None
    city: Optional[str] = None

    # Условия продажи
    has_installment: bool = False
    has_mortgage: bool = False
    mortgage_banks: List[str] = field(default_factory=list)

    # Контакты (только для вторички)
    owner_phone: Optional[str] = None
    owner_name: Optional[str] = None

    # Удобства
    has_parking: bool = False
    has_balcony: bool = False
    has_renovation: bool = False

    # Служебные поля
    relevance_score: float = 0.0  # Оценка релевантности (для ранжирования)
    matched_keywords: List[str] = field(default_factory=list)
    created_at: Optional[datetime] = None

    # ID записи в избранном (устанавливается только при просмотре избранного)
    favorite_id: Optional[str] = None

    @property
    def price_per_sqm(self) -> float:
        """Цена за квадратный метр"""
        if self.area > 0:
            return self.price / self.area
        return 0.0

    @property
    def price_millions(self) -> float:
        """Цена в миллионах тенге"""
        return self.price / 1_000_000

    @property
    def is_new_building(self) -> bool:
        """Новостройка или нет"""
        return self.source == 'bi_group' or self.building_type == 'new'

    def to_telegram_message(self) -> str:
        """
        Форматирует объект для отправки в Telegram (HTML).
        Красивый, информативный формат с эмодзи.
        """
        icon = "🏗" if self.is_new_building else "🏠"

        # Заголовок
        msg = f"{icon} <b>{self.title}</b>\n"

        # Адрес
        msg += f"📍 {self.address}\n"

        # Цена
        price_mln = self.price_millions
        price_sqm = self.price_per_sqm / 1000  # в тысячах
        msg += f"💰 <b>{price_mln:.1f} млн ₸</b> ({price_sqm:.0f}к/м²)\n"

        # Параметры
        if self.object_kind == "complex":
            if self.area and self.area > 0:
                msg += f"📐 от {self.area:.0f} м²\n"
        else:
            msg += f"📐 {self.rooms}-комн, {self.area:.0f} м², {self.floor} эт."
            if self.total_floors:
                msg += f"/{self.total_floors}"
            msg += "\n"

        # Класс жилья
        if self.property_class and self.source == 'bi_group':
            class_icon = self._get_class_icon(self.property_class)
            msg += f"{class_icon} <b>{self.property_class}</b>\n"

        # Дополнительная информация
        if self.description:
            msg += f"ℹ️ {self.description[:100]}\n"

        amenities = self._format_amenities()
        if amenities:
            msg += f"✨ {amenities}\n"

        if self.source == "secondary":
            if self.owner_phone:
                contact_name = f" ({self.owner_name})" if self.owner_name else ""
                msg += f"📞 {self.owner_phone}{contact_name}\n"

        # Ссылка
        if self.url:
            msg += f"<a href='{self.url}'>🔗 Подробнее на сайте</a>"

        if self.address:
            query = quote(f"{self.title}, {self.address}")
            link = f"https://2gis.kz/astana/search/{query}"
            prefix = "\n" if self.url else ""
            msg += f"{prefix}<a href='{link}'>🗺 2GIS</a>"
        elif self.latitude is not None and self.longitude is not None:
            link = f"https://2gis.kz/astana/geo/{self.latitude},{self.longitude}"
            prefix = "\n" if self.url else ""
            msg += f"{prefix}<a href='{link}'>🗺 2GIS</a>"

        return msg

    def to_whatsapp_message(self) -> str:
        """
        Форматирует объект для отправки в WhatsApp (Markdown).
        """
        icon = "🏗" if self.is_new_building else "🏠"

        msg = f"{icon} *{self.title}*\n"
        msg += f"📍 {self.address}\n"

        price_mln = self.price_millions
        price_sqm = self.price_per_sqm / 1000
        msg += f"💰 *{price_mln:.1f} млн ₸* ({price_sqm:.0f}к/м²)\n"

        if self.object_kind == "complex":
            if self.area and self.area > 0:
                msg += f"📐 от {self.area:.0f} м²\n"
        else:
            msg += f"📐 {self.rooms}-комн, {self.area:.0f} м², {self.floor} эт."
            if self.total_floors:
                msg += f"/{self.total_floors}"
            msg += "\n"

        # Класс жилья
        if self.property_class and self.source == 'bi_group':
            class_icon = self._get_class_icon(self.property_class)
            msg += f"{class_icon} *{self.property_class}*\n"

        if self.description:
            msg += f"ℹ️ {self.description[:100]}\n"

        amenities = self._format_amenities()
        if amenities:
            msg += f"✨ {amenities}\n"

        if self.source == "secondary":
            if self.owner_phone:
                contact_name = f" ({self.owner_name})" if self.owner_name else ""
                msg += f"📞 {self.owner_phone}{contact_name}\n"

        if self.url:
            msg += f"\n🔗 Подробнее: {self.url}"

        return msg

    def to_dict(self) -> Dict:
        """Конвертирует в словарь для JSON/API"""
        return {
            "source": self.source,
            "title": self.title,
            "address": self.address,
            "price": self.price,
            "price_millions": self.price_millions,
            "price_per_sqm": self.price_per_sqm,
            "rooms": self.rooms,
            "area": self.area,
            "floor": self.floor,
            "total_floors": self.total_floors,
            "description": self.description,
            "url": self.url,
            "image_url": self.image_url,
            "image_urls": self.image_urls,
            "object_id": self.object_id,
            "object_kind": self.object_kind,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "district": self.district,
            "city": self.city,
            "is_new_building": self.is_new_building,
            "has_installment": self.has_installment,
            "has_mortgage": self.has_mortgage,
            "relevance_score": self.relevance_score,
            "favorite_id": self.favorite_id,
        }

    @classmethod
    def from_dict(cls, data: Dict):
        allowed = {
            "source",
            "title",
            "address",
            "price",
            "rooms",
            "area",
            "floor",
            "description",
            "url",
            "image_url",
            "image_urls",
            "total_floors",
            "building_type",
            "property_class",
            "deadline",
            "latitude",
            "longitude",
            "district",
            "city",
            "has_installment",
            "has_mortgage",
            "mortgage_banks",
            "owner_phone",
            "owner_name",
            "relevance_score",
            "matched_keywords",
            "created_at",
            "object_id",
            "object_kind",
            "favorite_id",
        }
        payload = {k: v for k, v in (data or {}).items() if k in allowed}
        return cls(**payload)

    def __str__(self) -> str:
        """Строковое представление для логирования"""
        return (f"PropertyDTO(source={self.source}, title={self.title[:30]}..., "
                f"price={self.price_millions:.1f}M, rooms={self.rooms})")

    def __repr__(self) -> str:
        return self.__str__()

    def _format_amenities(self) -> str:
        items = []
        if self.has_parking:
            items.append("Парковка")
        if self.has_balcony:
            items.append("Балкон")
        if self.has_renovation:
            items.append("С ремонтом")
        if self.has_installment:
            items.append("Рассрочка")
        if self.has_mortgage:
            items.append("Ипотека")
        return " | ".join(items)

    def _get_class_icon(self, class_name: str) -> str:
        """Возвращает иконку для класса жилья"""
        class_icons = {
            "Премиум": "💎",
            "Бизнес+": "⭐",
            "Бизнес": "✨",
            "Комфорт+": "🌟",
            "Комфорт": "🏠",
            "Комфорт lite": "🏘",
            "Стандарт": "🏢",
        }
        return class_icons.get(class_name, "🏠")


@dataclass
class SearchCriteria:
    """
    DTO для критериев поиска.
    Унифицированное представление всех параметров поиска.
    """

    # Базовые параметры
    rooms: Optional[List[int]] = None  # Список комнат для множественного выбора (например, [2, 3] или [4, 5])
    min_price: Optional[float] = None
    max_price: Optional[float] = None
    min_area: Optional[float] = None
    max_area: Optional[float] = None

    # Локация
    city: Optional[str] = None
    district: Optional[str] = None
    geo_center: Optional[tuple] = None  # (lat, lon)
    geo_radius_km: Optional[float] = None

    # Lifestyle и предпочтения
    lifestyle_tags: List[str] = field(default_factory=list)
    semantic_keywords: List[str] = field(default_factory=list)
    exclusion_keywords: List[str] = field(default_factory=list)

    # Дополнительные фильтры
    floor_preferences: List[str] = field(default_factory=list)  # ["not_first", "not_last"]
    property_type: Optional[str] = None  # "new_building", "secondary", "any"

    # Для векторного поиска
    embedding_text: Optional[str] = None

    # Метаданные
    query_text: str = ""  # Оригинальный запрос пользователя
    confidence: float = 0.0

    def to_dict(self) -> Dict:
        """Конвертирует в словарь"""
        return {
            "rooms": self.rooms,
            "min_price": self.min_price,
            "max_price": self.max_price,
            "min_area": self.min_area,
            "max_area": self.max_area,
            "city": self.city,
            "district": self.district,
            "lifestyle_tags": self.lifestyle_tags,
            "semantic_keywords": self.semantic_keywords,
            "property_type": self.property_type,
            "query_text": self.query_text
        }

    def __str__(self) -> str:
        parts = []
        if self.city:
            parts.append(f"city={self.city}")
        if self.district:
            parts.append(f"district={self.district}")
        if self.rooms:
            parts.append(f"rooms={self.rooms}")
        if self.max_price:
            parts.append(f"max_price={self.max_price / 1_000_000:.0f}M")
        return f"SearchCriteria({', '.join(parts)})"


@dataclass
class SearchResult:
    """
    DTO для результата поиска.
    Включает найденные объекты и метаданные о поиске.
    """

    properties: List[PropertyDTO]
    total_found: int
    search_criteria: SearchCriteria

    # Метаданные поиска
    search_time_ms: float = 0.0
    sources_used: List[str] = field(default_factory=list)  # ["bi_group", "secondary"]

    # Статистика
    bi_group_count: int = 0
    secondary_count: int = 0

    # AI метаданные
    ai_analysis_complete: bool = False
    location_resolved: bool = False
    lifestyle_matched: bool = False

    def __post_init__(self):
        """Автоматически подсчитывает статистику"""
        self.bi_group_count = sum(1 for p in self.properties if p.source == 'bi_group')
        self.secondary_count = sum(1 for p in self.properties if p.source == 'secondary')
        self.total_found = len(self.properties)

    def to_dict(self) -> Dict:
        """Конвертирует в словарь для API"""
        return {
            "properties": [p.to_dict() for p in self.properties],
            "total_found": self.total_found,
            "search_criteria": self.search_criteria.to_dict(),
            "search_time_ms": self.search_time_ms,
            "sources_used": self.sources_used,
            "bi_group_count": self.bi_group_count,
            "secondary_count": self.secondary_count,
            "ai_analysis_complete": self.ai_analysis_complete
        }

    def __str__(self) -> str:
        return (f"SearchResult(total={self.total_found}, "
                f"bi_group={self.bi_group_count}, secondary={self.secondary_count})")


@dataclass
class UserPreferences:
    """
    DTO для сохраненных предпочтений пользователя.
    Используется для персонализации поиска.
    """

    user_id: str
    platform: str  # "telegram" или "whatsapp"

    # Сохраненные предпочтения
    preferred_city: Optional[str] = None
    preferred_districts: List[str] = field(default_factory=list)
    budget_range: Optional[tuple] = None  # (min, max)
    preferred_rooms: Optional[int] = None

    # Lifestyle профиль
    lifestyle_profile: List[str] = field(default_factory=list)

    # История взаимодействий
    viewed_properties: List[str] = field(default_factory=list)  # UUIDs
    favorite_properties: List[str] = field(default_factory=list)

    # Метаданные
    last_search_at: Optional[datetime] = None
    created_at: Optional[datetime] = None

    def to_dict(self) -> Dict:
        """Конвертирует в словарь для сохранения в БД"""
        return {
            "user_id": self.user_id,
            "platform": self.platform,
            "preferred_city": self.preferred_city,
            "preferred_districts": self.preferred_districts,
            "budget_range": self.budget_range,
            "preferred_rooms": self.preferred_rooms,
            "lifestyle_profile": self.lifestyle_profile,
            "viewed_properties": self.viewed_properties,
            "favorite_properties": self.favorite_properties
        }