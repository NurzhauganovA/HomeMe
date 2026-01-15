import os
import logging
from django.core.management.base import BaseCommand
from telegram import Update, ReplyKeyboardMarkup, KeyboardButton
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler, MessageHandler, filters
from telegram.constants import ParseMode

from core.services.dialog_manager import DialogManager

logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO)


class Command(BaseCommand):
    help = 'Запуск Умного Telegram бота'

    def handle(self, *args, **options):
        token = os.getenv("TELEGRAM_BOT_TOKEN")
        application = ApplicationBuilder().token(token).build()

        # Инициализация менеджера диалогов
        self.dialog_manager = DialogManager()

        application.add_handler(CommandHandler('start', self.handle_message))  # start тоже как обычное сообщение
        application.add_handler(MessageHandler(filters.TEXT, self.handle_message))

        print("🤖 Бот запущен с AI мозгами...")
        application.run_polling()

    async def handle_message(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        user = update.effective_user
        text = update.message.text

        # Передаем в DialogManager
        response = await self.dialog_manager.process_message(
            user_id=user.id,
            platform='telegram',
            text=text,
            user_name=user.first_name
        )

        # 1. Отправляем текст
        keyboard = []
        if response.get('buttons'):
            # Формируем кнопки по 2 в ряд
            buttons = [KeyboardButton(btn) for btn in response['buttons']]
            keyboard = [buttons[i:i + 2] for i in range(0, len(buttons), 2)]

        reply_markup = ReplyKeyboardMarkup(keyboard, resize_keyboard=True) if keyboard else None

        await update.message.reply_text(
            response['text'],
            reply_markup=reply_markup,
            parse_mode=ParseMode.MARKDOWN
        )

        # 2. Отправляем объекты (карточки квартир), если есть
        objects = response.get('objects', [])
        for obj in objects:
            msg = obj.to_telegram_message()
            if obj.image_url:
                try:
                    await update.message.reply_photo(obj.image_url, caption=msg, parse_mode=ParseMode.HTML)
                except:
                    await update.message.reply_text(msg, parse_mode=ParseMode.HTML)
            else:
                await update.message.reply_text(msg, parse_mode=ParseMode.HTML)