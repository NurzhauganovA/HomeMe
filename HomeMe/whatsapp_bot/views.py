import json
import logging
import asyncio
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from asgiref.sync import async_to_sync

from whatsapp_bot.services import send_whatsapp_message
from core.services.dialog_manager import EnhancedDialogManager

logger = logging.getLogger(__name__)


@csrf_exempt
def whatsapp_webhook(request):
    if request.method == 'GET':
        mode = request.GET.get('hub.mode')
        token = request.GET.get('hub.verify_token')
        challenge = request.GET.get('hub.challenge')
        if mode == 'subscribe' and token == settings.WHATSAPP_VERIFY_TOKEN:
            return HttpResponse(challenge, status=200)
        return HttpResponse('Forbidden', status=403)

    if request.method == 'POST':
        try:
            body = json.loads(request.body)
            if 'object' in body and 'entry' in body:
                for entry in body['entry']:
                    for change in entry['changes']:
                        value = change['value']
                        if 'messages' in value:
                            message_data = value['messages'][0]
                            phone_number = message_data['from']
                            profile_name = value.get('contacts', [{}])[0].get('profile', {}).get('name', 'Гость')

                            if message_data['type'] == 'text':
                                text_body = message_data['text']['body']

                                # --- ЗАПУСК AI ЛОГИКИ ---
                                manager = EnhancedDialogManager()

                                # Django View синхронная, поэтому вызываем async код через async_to_sync
                                response = async_to_sync(manager.process_message)(
                                    user_id=phone_number,
                                    platform='whatsapp',
                                    text=text_body,
                                    user_name=profile_name
                                )

                                # 1. Отправляем текстовый ответ
                                send_whatsapp_message(phone_number, response['text'])

                                # 2. Отправляем объекты
                                objects = response.get('objects', [])
                                for obj in objects:
                                    # В WhatsApp отправляем просто текстом с ссылкой (для простоты MVP)
                                    # Или можно реализовать отправку картинок отдельно
                                    msg = obj.to_whatsapp_text()
                                    send_whatsapp_message(phone_number, msg)

            return HttpResponse('EVENT_RECEIVED', status=200)
        except Exception as e:
            logger.error(f"Error: {e}")
            return HttpResponse('Internal Error', status=500)

    return HttpResponse('Method not allowed', status=405)