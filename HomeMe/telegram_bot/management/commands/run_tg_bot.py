"""
Enhanced Telegram Bot
Профессиональная команда для запуска Telegram бота с AI-интеграцией.
"""

import os
import logging
import asyncio
from asgiref.sync import sync_to_async
from django.core.management.base import BaseCommand
from telegram import (
    Update,
    ReplyKeyboardMarkup,
    KeyboardButton,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
    InputMediaPhoto
)
from telegram.error import BadRequest
from telegram.ext import (
    ApplicationBuilder,
    ContextTypes,
    CommandHandler,
    MessageHandler,
    CallbackQueryHandler,
    filters
)
from telegram.constants import ParseMode, ChatAction

from core.services.dialog_manager import EnhancedDialogManager
from core.services.bitrix24_service import Bitrix24Service
from telegram_bot.models import BotUser, UserSession, FavoriteProperty

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Запуск профессионального Telegram бота с AI'

    def __init__(self):
        super().__init__()
        self.dialog_manager = None
        self.bitrix24_service = Bitrix24Service()

    async def handle_voice(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработчик голосовых сообщений"""
        user = update.effective_user
        voice = update.message.voice

        # Получаем файл от телеграма (это еще не байты, это ссылка на файл)
        voice_file = await context.bot.get_file(voice.file_id)

        # Передаем в DialogManager
        # Обрати внимание: мы передаем объект файла, скачивание будет внутри менеджера
        response = await self.dialog_manager.process_voice(
            user_id=user.id,
            platform='telegram',
            voice_file_object=voice_file,
            user_name=user.first_name
        )

        await self.send_response(update, response)

    async def send_response(self, update: Update, response: dict):
        """Унифицированная отправка ответа"""
        await self._send_text_response(update, response)
        await self._send_property_cards(update, response)

    def handle(self, *args, **options):
        """Главная точка входа"""
        token = os.getenv("TELEGRAM_BOT_TOKEN")

        if not token:
            self.stdout.write(self.style.ERROR('❌ TELEGRAM_BOT_TOKEN not found in environment'))
            return

        # Инициализация
        application = ApplicationBuilder().token(token).concurrent_updates(16).build()

        application.add_handler(MessageHandler(filters.VOICE, self.handle_voice))
        application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, self.handle_message))

        self.dialog_manager = EnhancedDialogManager()

        # Регистрация хэндлеров
        self._register_handlers(application)

        # Запуск
        self.stdout.write(self.style.SUCCESS('🤖 HomeMe Telegram Bot запущен с AI...'))
        logger.info("=" * 50)
        logger.info("🚀 HomeMe Telegram Bot Started")
        logger.info("🧠 AI: Enhanced Multi-Stage Analysis")
        logger.info("📍 Location: Dynamic Resolution")
        logger.info("🔍 Search: Intelligent Multi-Source")
        logger.info("=" * 50)

        application.run_polling(allowed_updates=Update.ALL_TYPES)

    def _register_handlers(self, application):
        """Регистрация всех обработчиков"""

        # Команды
        application.add_handler(CommandHandler('start', self.command_start))
        application.add_handler(CommandHandler('help', self.command_help))
        application.add_handler(CommandHandler('reset', self.command_reset))
        application.add_handler(CommandHandler('stats', self.command_stats))

        # Callback кнопки
        application.add_handler(CallbackQueryHandler(self.handle_callback))

        # Текстовые сообщения
        application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, self.handle_message))

        # Обработка ошибок
        application.add_error_handler(self.error_handler)

    async def command_start(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /start"""
        await self.handle_message(update, context)

    async def command_help(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /help"""
        help_text = (
            "🤖 <b>HomeMe AI - Помощь</b>\n\n"
            "Я умный помощник по поиску недвижимости в Казахстане.\n\n"
            "<b>Что я умею:</b>\n"
            "🔍 Искать квартиры по любым параметрам\n"
            "📍 Понимать локации (даже 'рядом с EXPO')\n"
            "🎯 Учитывать lifestyle ('тихо', 'для семьи')\n"
            "🏢 Рассказывать о районах\n"
            "👨‍💼 Связывать с экспертами\n\n"
            "<b>Примеры запросов:</b>\n"
            "• 'Двушка в Астане до 40 млн'\n"
            "• 'Квартира рядом с EXPO'\n"
            "• 'Тихая квартира для семьи с парком'\n"
            "• 'Расскажи про левый берег'\n\n"
            "<b>Команды:</b>\n"
            "/start - Начать сначала\n"
            "/reset - Сбросить поиск\n"
            "/stats - Моя статистика\n"
            "/help - Эта помощь"
        )

        await update.message.reply_text(help_text, parse_mode=ParseMode.HTML)

    async def command_reset(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /reset - сброс параметров поиска"""
        user = update.effective_user

        try:
            from asgiref.sync import sync_to_async
            from telegram_bot.models import UserSession

            bot_user = await sync_to_async(BotUser.objects.get)(
                user_id=str(user.username),
                platform='telegram'
            )
            session = await sync_to_async(lambda: bot_user.session)()
            await sync_to_async(session.clear_search_params)()

            await update.message.reply_text(
                "✅ Параметры поиска сброшены!\n\n"
                "Начнем с чистого листа. Что вы ищете?"
            )
        except Exception as e:
            logger.error(f"Error resetting session: {e}")
            await update.message.reply_text("Произошла ошибка. Попробуйте /start")

    async def command_stats(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Команда /stats - статистика пользователя"""
        user = update.effective_user

        try:
            from asgiref.sync import sync_to_async

            bot_user = await sync_to_async(BotUser.objects.get)(
                user_id=str(user.username),
                platform='telegram'
            )

            stats_text = (
                f"📊 <b>Ваша статистика</b>\n\n"
                f"👤 Имя: {bot_user.name}\n"
                f"🔍 Всего поисков: {bot_user.total_searches}\n"
                f"💬 Сообщений: {bot_user.total_messages}\n"
                f"📅 С нами с: {bot_user.created_at.strftime('%d.%m.%Y')}\n"
                f"⏰ Последняя активность: {bot_user.last_active_at.strftime('%d.%m.%Y %H:%M')}"
            )

            await update.message.reply_text(stats_text, parse_mode=ParseMode.HTML)

        except Exception as e:
            logger.error(f"Error getting stats: {e}")
            await update.message.reply_text("Не удалось получить статистику")

    async def handle_message(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Главный обработчик текстовых сообщений"""
        user = update.effective_user
        text = update.message.text

        logger.info(f"📨 Message from {user.first_name} (@{user.username}): {text[:50]}...")

        # Показываем индикатор печатания
        await update.message.chat.send_action(ChatAction.TYPING)

        try:
            # Обработка через Dialog Manager
            response = await self.dialog_manager.process_message(
                user_id=user.id,
                platform='telegram',
                text=text,
                user_name=user.first_name
            )

            # Показываем typing если AI еще думает
            if response.get('show_typing'):
                await update.message.chat.send_action(ChatAction.TYPING)
                await asyncio.sleep(0.5)  # Небольшая задержка для реалистичности

            # Отправляем текстовый ответ
            await self._send_text_response(update, response)

            # Отправляем объекты (если есть)
            await self._send_property_cards(update, response)

        except Exception as e:
            logger.error(f"❌ Error handling message: {e}", exc_info=True)
            await update.message.reply_text(
                "😔 Произошла ошибка. Попробуйте снова или используйте /help"
            )

    async def _send_text_response(self, update: Update, response: dict):
        """Отправляет текстовый ответ с кнопками"""
        text = response.get('text', 'Что-то пошло не так...')
        buttons = response.get('buttons', [])
        parse_mode = response.get('parse_mode', ParseMode.MARKDOWN)

        # Формируем клавиатуру
        keyboard = None
        if buttons:
            keyboard_buttons = []
            row = []
            for i, btn_text in enumerate(buttons):
                row.append(KeyboardButton(btn_text))
                # По 2 кнопки в ряд
                if (i + 1) % 2 == 0:
                    keyboard_buttons.append(row)
                    row = []
            # Добавляем оставшиеся кнопки
            if row:
                keyboard_buttons.append(row)

            keyboard = ReplyKeyboardMarkup(
                keyboard_buttons,
                resize_keyboard=True,
                one_time_keyboard=False
            )

        try:
            await self._send_text_chunks(update, text, keyboard, parse_mode)
        except BadRequest as e:
            logger.warning(f"⚠️ Parse error, fallback to plain text: {e}")
            await self._send_text_chunks(update, text, keyboard, "plain")

    async def _send_text_chunks(self, update: Update, text: str, keyboard, parse_mode):
        max_len = 3500
        if len(text) <= max_len:
            await self._send_one_text(update, text, keyboard, parse_mode)
            return

        parts = []
        remaining = text
        while len(remaining) > max_len:
            cut = remaining.rfind("\n", 0, max_len)
            if cut == -1:
                cut = max_len
            parts.append(remaining[:cut].strip())
            remaining = remaining[cut:].strip()
        if remaining:
            parts.append(remaining)

        for i, part in enumerate(parts):
            is_last = i == len(parts) - 1
            await self._send_one_text(update, part, keyboard if is_last else None, parse_mode)

    async def _send_one_text(self, update: Update, text: str, keyboard, parse_mode):
        if parse_mode == "plain":
            await update.message.reply_text(
                text,
                reply_markup=keyboard,
                disable_web_page_preview=False
            )
        else:
            await update.message.reply_text(
                text,
                reply_markup=keyboard,
                parse_mode=parse_mode
            )

    async def _send_property_cards(self, update: Update, response: dict):
        """Отправляет карточки объектов недвижимости"""
        objects = response.get('objects', [])

        if not objects:
            return

        logger.info(f"📤 Sending {len(objects)} property cards...")

        for idx, obj in enumerate(objects, 1):
            try:
                # Показываем прогресс для больших списков
                if len(objects) > 3 and idx % 2 == 0:
                    await update.message.chat.send_action(ChatAction.UPLOAD_PHOTO)

                # Формируем сообщение
                msg = obj.to_telegram_message()

                # Inline кнопки для действий
                # Если объект из избранного — показываем кнопку удаления
                if getattr(obj, 'favorite_id', None):
                    inline_keyboard = [
                        [InlineKeyboardButton("🗑 Удалить из избранного", callback_data=f"delete_fav_{obj.favorite_id}")]
                    ]
                else:
                    inline_keyboard = [
                        [InlineKeyboardButton("💾 Сохранить", callback_data=f"save_{obj.source}_{idx}")]
                    ]
                    # Кнопка "Контакты" только для объектов BI Group
                    if obj.source == 'bi_group':
                        inline_keyboard[0].append(
                            InlineKeyboardButton("👤 Контакты", callback_data=f"contact_{obj.source}_{idx}")
                        )
                reply_markup = InlineKeyboardMarkup(inline_keyboard)

                # Отправляем с фото или без
                image_urls = getattr(obj, "image_urls", None) or []
                if image_urls:
                    try:
                        media_group = []
                        max_photos = 5
                        for i, url in enumerate(image_urls[:max_photos]):
                            if i == 0:
                                media_group.append(InputMediaPhoto(media=url, caption=msg, parse_mode=ParseMode.HTML))
                            else:
                                media_group.append(InputMediaPhoto(media=url))

                        await update.message.reply_media_group(media_group)
                        await update.message.reply_text(
                            "Выберите действие:",
                            parse_mode=ParseMode.HTML,
                            reply_markup=reply_markup,
                            disable_web_page_preview=False
                        )
                    except Exception as e:
                        logger.warning(f"⚠️ Failed to send media group: {e}")
                        sent_photo = False
                        for url in image_urls:
                            try:
                                await update.message.reply_photo(
                                    url,
                                    caption=msg,
                                    parse_mode=ParseMode.HTML,
                                    reply_markup=reply_markup
                                )
                                sent_photo = True
                                break
                            except Exception as photo_exc:
                                logger.warning(f"⚠️ Failed to send photo {url}: {photo_exc}")

                        if not sent_photo:
                            await update.message.reply_text(
                                msg,
                                parse_mode=ParseMode.HTML,
                                reply_markup=reply_markup,
                                disable_web_page_preview=False
                            )
                elif obj.image_url:
                    try:
                        await update.message.reply_photo(
                            obj.image_url,
                            caption=msg,
                            parse_mode=ParseMode.HTML,
                            reply_markup=reply_markup
                        )
                    except Exception as e:
                        logger.warning(f"⚠️ Failed to send photo: {e}")
                        # Fallback: отправляем без фото
                        await update.message.reply_text(
                            msg,
                            parse_mode=ParseMode.HTML,
                            reply_markup=reply_markup,
                            disable_web_page_preview=False
                        )
                else:
                    await update.message.reply_text(
                        msg,
                        parse_mode=ParseMode.HTML,
                        reply_markup=reply_markup,
                        disable_web_page_preview=False
                    )

                # Небольшая задержка между отправками
                if idx < len(objects):
                    await asyncio.sleep(0.3)

            except Exception as e:
                logger.error(f"❌ Error sending property card {idx}: {e}")
                continue

    async def handle_callback(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Обработчик inline кнопок"""
        query = update.callback_query
        await query.answer()

        callback_data = query.data
        logger.info(f"🔘 Callback: {callback_data}")

        # Разбираем callback_data
        parts = callback_data.split('_')
        action = parts[0]

        if action == 'delete' and len(parts) >= 3 and parts[1] == 'fav':
            # callback_data = "delete_fav_{uuid}"
            # UUID содержит дефисы, не подчёркивания — parts[2] будет полным UUID
            fav_uuid = parts[2]
            try:
                user = query.from_user
                bot_user = await sync_to_async(BotUser.objects.get)(
                    user_id=str(user.id),
                    platform='telegram'
                )
                deleted_count, _ = await sync_to_async(
                    FavoriteProperty.objects.filter(id=fav_uuid, user=bot_user).delete
                )()
                if deleted_count:
                    await query.message.reply_text("✅ Объект удалён из избранного.")
                    # Редактируем кнопки исходного сообщения, чтобы убрать кнопку удаления
                    try:
                        await query.message.edit_reply_markup(reply_markup=None)
                    except Exception:
                        pass
                else:
                    await query.message.reply_text("Объект не найден в избранном.")
            except BotUser.DoesNotExist:
                await query.message.reply_text("❌ Пользователь не найден. Пожалуйста, начните с /start")
            except Exception as e:
                logger.error(f"Failed to delete favorite: {e}")
                await query.message.reply_text("Не удалось удалить объект из избранного.")

        elif action == 'save':
            try:
                user = query.from_user
                bot_user = await sync_to_async(BotUser.objects.get)(
                    user_id=str(user.id),
                    platform='telegram'
                )
                session = await sync_to_async(UserSession.objects.get)(user=bot_user)
                params = session.search_params or {}
                last_objects = params.get('last_objects') or []

                source = "_".join(parts[1:-1]) if len(parts) > 2 else "unknown"
                idx = int(parts[-1]) if len(parts) > 1 else 0
                if idx < 1 or idx > len(last_objects):
                    await query.message.reply_text("Не удалось найти объект для сохранения.")
                    return

                data = last_objects[idx - 1]
                object_kind = data.get('object_kind') or 'unknown'
                object_id = data.get('object_id') or f"{data.get('title')}|{data.get('address')}"

                favorite, created = await sync_to_async(FavoriteProperty.objects.get_or_create)(
                    user=bot_user,
                    object_kind=object_kind,
                    object_id=object_id,
                    defaults={
                        "source": data.get('source', source),
                        "data": data
                    }
                )

                if created:
                    await query.message.reply_text(
                        "✅ Объект добавлен в избранное!\n"
                        "Все сохраненные объекты доступны в разделе 'Избранное'"
                    )
                else:
                    await query.message.reply_text("⭐ Этот объект уже в избранном.")
            except Exception as e:
                logger.error(f"Failed to save favorite: {e}")
                await query.message.reply_text("Не удалось сохранить объект.")

        elif action == 'contact':
            try:
                user = query.from_user
                bot_user = await sync_to_async(BotUser.objects.get)(
                    user_id=str(user.id),
                    platform='telegram'
                )
                session = await sync_to_async(UserSession.objects.get)(user=bot_user)
                params = session.search_params or {}
                last_objects = params.get('last_objects') or []

                source = "_".join(parts[1:-1]) if len(parts) > 2 else "unknown"
                idx = int(parts[-1]) if len(parts) > 1 else 0
                
                if idx < 1 or idx > len(last_objects):
                    await query.message.reply_text("Не удалось найти объект.")
                    return

                property_data = last_objects[idx - 1]
                
                # Проверяем, что это объект BI Group
                if property_data.get('source') != 'bi_group':
                    await query.message.reply_text(
                        "❌ Кнопка 'Контакты' доступна только для объектов BI Group."
                    )
                    return

                # Получаем информацию о пользователе
                user_name = bot_user.name or user.first_name or "Пользователь"
                # Пытаемся получить телефон из разных источников
                user_phone = getattr(bot_user, 'phone', None) or getattr(user, 'phone_number', None)
                user_id = str(user.id)
                user_username = getattr(user, 'username', None)  # Username из Telegram (@username), может быть None

                # Создаем заявку в Bitrix24
                bitrix_result = await sync_to_async(
                    self.bitrix24_service.create_lead,
                    thread_sensitive=False
                )(
                    user_name=user_name,
                    user_phone=user_phone,
                    user_platform='telegram',
                    property_data=property_data,
                    user_id=user_id,
                    user_username=user_username
                )

                # Получаем номер call center
                call_center_number = self.bitrix24_service.get_call_center_number()
                
                # Формируем сообщение
                if bitrix_result and bitrix_result.get('success'):
                    message_text = (
                        f"✅ <b>Заявка отправлена!</b>\n\n"
                        f"📋 Ваша заявка по объекту <b>{property_data.get('title', 'недвижимости')}</b> "
                        f"успешно отправлена в CRM систему.\n\n"
                        f"📞 <b>Моментальный звонок:</b>\n"
                        f"Позвоните в call center застройщика BI Group:\n"
                        f"<b>{call_center_number}</b>\n\n"
                        f"Наш менеджер свяжется с вами в ближайшее время!"
                    )
                else:
                    # Если Bitrix24 не настроен или произошла ошибка, все равно показываем контакты
                    message_text = (
                        f"📞 <b>Контакты по объекту</b>\n\n"
                        f"Объект: <b>{property_data.get('title', 'недвижимость')}</b>\n\n"
                        f"Для получения информации и моментального звонка:\n"
                        f"Позвоните в call center застройщика BI Group:\n"
                        f"<b>{call_center_number}</b>\n\n"
                        f"Наш менеджер поможет вам с выбором!"
                    )

                # Создаем кнопку для звонка
                # call_keyboard = [
                #     [
                #         InlineKeyboardButton(
                #             f"📞 Позвонить {call_center_number}",
                #             url=f"tel:{call_center_number}"
                #         )
                #     ]
                # ]
                # reply_markup = InlineKeyboardMarkup(call_keyboard)
                #
                await query.message.reply_text(
                    message_text,
                    parse_mode=ParseMode.HTML,
                    reply_markup=None,  # Убираем кнопку, так как многие клиенты не поддерживают tel: ссылки
                )

            except BotUser.DoesNotExist:
                await query.message.reply_text(
                    "❌ Пользователь не найден. Пожалуйста, начните с команды /start"
                )
            except Exception as e:
                logger.error(f"❌ Ошибка при обработке запроса контактов: {e}", exc_info=True)
                call_center_number = self.bitrix24_service.get_call_center_number()
                await query.message.reply_text(
                    f"Ваша заявка отправлена в CRM систему.\n\n"
                    f"Вы можете ждать звонка от менеджера, или позвонить самостоятельно:\n\n"
                    f"📞 <b>Контакты</b>\n\n"
                    f"Позвоните в call center застройщика BI Group:\n"
                    f"Телефон: <b>{call_center_number}</b>\n\n",
                    parse_mode=ParseMode.HTML
                )

        elif action not in ('delete',):
            await query.message.reply_text("Неизвестное действие")

    async def error_handler(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        """Глобальный обработчик ошибок"""
        logger.error(f"❌ Error: {context.error}", exc_info=True)

        try:
            if update and update.effective_message:
                await update.effective_message.reply_text(
                    "😔 Произошла непредвиденная ошибка.\n"
                    "Мы уже работаем над ее исправлением.\n\n"
                    "Попробуйте:\n"
                    "• /reset - сбросить параметры\n"
                    "• /start - начать заново\n"
                    "• /help - помощь"
                )
        except Exception as e:
            logger.error(f"❌ Error in error handler: {e}")