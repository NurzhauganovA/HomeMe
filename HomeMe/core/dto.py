from dataclasses import dataclass


@dataclass
class PropertyDTO:
    source: str  # 'bi_group' или 'secondary'
    title: str
    address: str
    price: float
    rooms: int
    area: float
    floor: int
    description: str = ""
    url: str = ""
    image_url: str = ""

    def to_telegram_message(self) -> str:
        """HTML формат для Telegram"""
        price_mln = self.price / 1_000_000
        icon = "🏗" if self.source == 'bi_group' else "🏠"

        return (
            f"{icon} <b>{self.title}</b>\n"
            f"📍 {self.address}\n"
            f"💰 <b>{price_mln:.1f} млн ₸</b>\n"
            f"📐 {self.rooms}-комн, {self.area} м², {self.floor} эт.\n"
            f"<a href='{self.url}'>🔗 Подробнее на сайте</a>"
        )