import requests
import logging
from django.conf import settings

logger = logging.getLogger(__name__)


def send_whatsapp_message(phone_number, text):
    """
    Отправляет текстовое сообщение пользователю через WhatsApp Cloud API.
    """
    url = f"https://graph.facebook.com/v17.0/{settings.WHATSAPP_ID_PHONE}/messages"

    headers = {
        "Authorization": f"Bearer {settings.WHATSAPP_API_TOKEN}",
        "Content-Type": "application/json",
    }

    # Формируем payload согласно документации Meta
    payload = {
        "messaging_product": "whatsapp",
        "to": phone_number,
        "type": "text",
        "text": {
            "body": text
        }
    }

    try:
        response = requests.post(url, headers=headers, json=payload)
        response.raise_for_status()  # Вызовет ошибку, если статус не 200
        logger.info(f"Message sent to {phone_number}: {response.json()}")
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Failed to send message: {e}")
        if response is not None:
            logger.error(f"Response content: {response.text}")
        return None