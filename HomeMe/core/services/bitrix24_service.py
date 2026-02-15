"""
Сервис для интеграции с Bitrix24 CRM
Отправка заявок по объектам недвижимости
"""

import logging
import requests
from typing import Dict, Optional
from django.conf import settings

logger = logging.getLogger(__name__)


class Bitrix24Service:
    """
    Сервис для работы с Bitrix24 CRM API.
    Отправляет заявки (лиды) по объектам недвижимости.
    """

    def __init__(self):
        self.webhook_url = getattr(settings, 'BITRIX24_WEBHOOK_URL', None)
        self.call_center_number = getattr(settings, 'BITRIX24_CALL_CENTER_NUMBER', '360')
        
        if not self.webhook_url:
            logger.warning("⚠️ BITRIX24_WEBHOOK_URL не настроен. Интеграция с Bitrix24 отключена.")

    def create_lead(
        self,
        user_name: str,
        user_phone: Optional[str],
        user_platform: str,
        property_data: Dict,
        user_id: Optional[str] = None,
        user_username: Optional[str] = None
    ) -> Optional[Dict]:
        """
        Создает лид (заявку) в Bitrix24 CRM
        
        Args:
            user_name: Имя пользователя
            user_phone: Телефон пользователя (опционально)
            user_platform: Платформа ('telegram' или 'whatsapp')
            property_data: Данные объекта недвижимости (PropertyDTO.to_dict())
            user_id: ID пользователя в боте
            user_username: Username пользователя (для Telegram - @username)
            
        Returns:
            Dict с результатом создания лида или None при ошибке
        """
        if not self.webhook_url:
            logger.warning("Bitrix24 webhook URL не настроен")
            return None

        try:
            # Определяем тип объекта
            object_kind = property_data.get('object_kind', 'unknown')
            property_title = property_data.get('title', 'Неизвестный объект')
            property_address = property_data.get('address', '')
            property_price = property_data.get('price', 0)
            property_price_mln = property_data.get('price_millions', 0)
            
            # Определяем, коммерческий ли это объект (по названию и описанию)
            description_lower = property_data.get('description', '').lower()
            title_lower = property_title.lower()
            
            # Основной признак коммерческого объекта - "БЦ" в названии
            is_commercial = (
                'бц' in title_lower or
                'коммерческий' in description_lower or
                ('офис' in description_lower and object_kind == 'unit')
            )
            
            # Для юнитов дополнительно проверяем по количеству комнат
            if object_kind == 'unit' and not is_commercial:
                # Если rooms == 0 и это не комплекс, возможно это коммерческий объект
                if property_data.get('rooms', 0) == 0:
                    is_commercial = True
            
            # Формируем заголовок лида в зависимости от типа объекта
            if object_kind == 'complex':
                # ЖК или коммерческое помещение целиком
                if is_commercial:
                    object_type = "Коммерческое помещение"
                else:
                    object_type = "ЖК (комплекс)"
                title = f"Заявка по {object_type}: {property_title}"
            elif object_kind == 'unit':
                # Конкретная квартира или офис
                if is_commercial:
                    object_type = "Офис/Помещение"
                else:
                    object_type = "Квартира"
                title = f"Заявка по {object_type}: {property_title}"
            else:
                # Fallback для других типов
                title = f"Заявка по объекту: {property_title}"
            
            # Формируем описание лида (без HTML тегов для Bitrix24)
            object_type_label = ""
            if object_kind == 'complex':
                if is_commercial:
                    object_type_label = "ТИП: Коммерческое помещение (комплекс целиком)"
                else:
                    object_type_label = "ТИП: ЖК (жилой комплекс целиком)"
            elif object_kind == 'unit':
                if is_commercial:
                    object_type_label = "ТИП: Офис/Помещение (конкретное помещение)"
                else:
                    object_type_label = "ТИП: Квартира (конкретная квартира)"
            
            description = f"""Заявка на контакт по объекту недвижимости

{object_type_label}

ОБЪЕКТ:
• Название: {property_title}
• Адрес: {property_address}
• Цена: {property_price_mln:.1f} млн ₸ ({property_price:,.0f} ₸)
"""
            
            # Добавляем детали в зависимости от типа объекта
            if object_kind == 'unit':
                # Для конкретной квартиры/офиса показываем детали
                description += f"• Комнат: {property_data.get('rooms', 'N/A')}\n"
                description += f"• Площадь: {property_data.get('area', 'N/A')} м²\n"
                description += f"• Этаж: {property_data.get('floor', 'N/A')}"
                if property_data.get('total_floors'):
                    description += f" из {property_data.get('total_floors')}"
                description += "\n"
            elif object_kind == 'complex':
                # Для комплекса показываем общую информацию
                if property_data.get('area'):
                    description += f"• Площадь: от {property_data.get('area', 'N/A')} м²\n"
                description += f"• Тип: Комплекс целиком\n"
            
            description += f"""
            • Источник: {property_data.get('source', 'unknown')}
            КЛИЕНТ:
            • Имя: {user_name}
            • Платформа: {user_platform}
"""
            
            if user_username:
                description += f"• Username: @{user_username}\n"
            
            if user_phone:
                description += f"• Телефон: {user_phone}\n"
            
            if user_id:
                description += f"• ID пользователя: {user_id}\n"
            
            if property_data.get('url'):
                description += f"\nСсылка на объект: {property_data.get('url')}\n"
            
            # Подготавливаем данные для Bitrix24 API
            # Используем метод crm.lead.add
            payload = {
                'fields': {
                    'TITLE': title,
                    'COMMENTS': description,
                    'SOURCE_ID': 'WEB',  # Источник - веб
                    'STATUS_ID': 'NEW',  # Новый лид
                    'OPENED': 'Y',  # Открыт
                }
            }
            
            # Добавляем контактную информацию, если есть
            if user_phone:
                # Очищаем телефон от лишних символов
                clean_phone = ''.join(filter(str.isdigit, user_phone))
                if clean_phone:
                    payload['fields']['PHONE'] = [{'VALUE': clean_phone, 'VALUE_TYPE': 'WORK'}]
            
            if user_name:
                payload['fields']['NAME'] = user_name
            
            # Добавляем пользовательские поля для объекта недвижимости
            # ВАЖНО: Эти поля должны быть созданы в Bitrix24 заранее
            # Инструкция по созданию полей: см. BITRIX24_SETUP.md
            # Если поля не существуют, Bitrix24 вернет ошибку при их использовании
            # Раскомментируйте следующие строки после создания полей в Bitrix24:
            
            USE_CUSTOM_FIELDS = getattr(settings, 'BITRIX24_USE_CUSTOM_FIELDS', True)
            
            if USE_CUSTOM_FIELDS:
                payload_fields = payload['fields']
                print("DEBUG: Payload для Bitrix24:", payload_fields)  # Выводим payload для отладки
                # Пользовательские поля для удобной фильтрации и работы с данными
                payload['fields']['UF_CRM_PROPERTY_TITLE'] = property_title
                payload['fields']['UF_CRM_PROPERTY_ADDRESS'] = property_address
                payload['fields']['UF_CRM_PROPERTY_PRICE'] = str(property_price)
                payload['fields']['UF_CRM_PROPERTY_SOURCE'] = property_data.get('source', 'unknown')
            
            # Отправляем запрос в Bitrix24
            response = requests.post(
                f"{self.webhook_url}/crm.lead.add",
                json=payload,
                timeout=10
            )
            
            response.raise_for_status()
            result = response.json()
            
            if result.get('result'):
                lead_id = result.get('result')
                logger.info(f"✅ Лид создан в Bitrix24: ID={lead_id}, Объект={property_title}")
                return {
                    'success': True,
                    'lead_id': lead_id,
                    'message': 'Заявка успешно отправлена'
                }
            else:
                error = result.get('error', 'Unknown error')
                logger.error(f"❌ Ошибка создания лида в Bitrix24: {error}")
                return {
                    'success': False,
                    'error': error
                }
                
        except requests.exceptions.RequestException as e:
            logger.error(f"❌ Ошибка при отправке запроса в Bitrix24: {e}")
            return None
        except Exception as e:
            logger.error(f"❌ Неожиданная ошибка при создании лида в Bitrix24: {e}", exc_info=True)
            return None

    def get_call_center_number(self) -> str:
        """Возвращает номер call center для звонков"""
        return self.call_center_number
