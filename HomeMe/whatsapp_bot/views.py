import json
import logging
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

from whatsapp_bot.models import WhatsAppUser
from whatsapp_bot.services import send_whatsapp_message

logger = logging.getLogger(__name__)


@csrf_exempt
def whatsapp_webhook(request):
    """
    Основной вход для WhatsApp API.
    Обрабатывает два типа запросов:
    1. GET - для верификации (подтверждение URL в Meta).
    2. POST - прием входящих сообщений.
    """

    if request.method == 'POST':
        try:
            body = json.loads(request.body)

            # Проверка структуры Meta JSON
            if 'object' in body and 'entry' in body:
                for entry in body['entry']:
                    for change in entry['changes']:
                        value = change['value']

                        if 'messages' in value:
                            message_data = value['messages'][0]
                            phone_number = message_data['from']

                            # 1. Получаем имя профиля (Meta иногда его отдает)
                            profile_name = value.get('contacts', [{}])[0].get('profile', {}).get('name', 'Гость')

                            # 2. Сохраняем или получаем пользователя (User Management)
                            user, created = WhatsAppUser.objects.get_or_create(
                                phone_number=phone_number,
                                defaults={'name': profile_name}
                            )

                            if created:
                                logger.info(f"Новый пользователь: {profile_name} ({phone_number})")

                            # 3. Обработка текста
                            if message_data['type'] == 'text':
                                text_body = message_data['text']['body']
                                print(f"Входящее: {text_body}")

                                # ПРОСТАЯ ЛОГИКА ОТВЕТА (ЭХО)
                                # Позже здесь будет Router Intents (по ТЗ: поиск, консультация и т.д.)
                                response_text = f"Привет, {user.name}! Я получил твоё сообщение: '{text_body}'.\nСкоро я научусь искать квартиры!"

                                send_whatsapp_message(phone_number, response_text)

            return HttpResponse('EVENT_RECEIVED', status=200)

        except Exception as e:
            logger.error(f"Error: {e}")
            return HttpResponse('Internal Error', status=500)

    # 1. ВЕРИФИКАЦИЯ (GET)
    if request.method == 'GET':
        mode = request.GET.get('hub.mode')
        token = request.GET.get('hub.verify_token')
        challenge = request.GET.get('hub.challenge')

        if mode and token:
            if mode == 'subscribe' and token == settings.WHATSAPP_VERIFY_TOKEN:
                print("WEBHOOK VERIFIED")
                return HttpResponse(challenge, status=200)
            else:
                return HttpResponse('Forbidden', status=403)

    return HttpResponse('Method not allowed', status=405)