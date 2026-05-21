"""
BI Group CRM Lead Service
Отправка заявок пользователей напрямую в CRM застройщика BI Group.
Endpoint: POST /siteApplications (apigw.bi.group)
"""
from __future__ import annotations

import logging
import time
from typing import Optional, Dict

import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

from django.conf import settings

logger = logging.getLogger(__name__)


class BIGroupLeadService:
    """
    Сервис для отправки лидов (заявок) напрямую в CRM застройщика BI Group.

    Поддерживает:
    - Retry-логику (3 попытки с экспоненциальной задержкой)
    - Логирование в БД через модель BIGroupLeadLog
    - Graceful fallback: ошибки не блокируют пользователя
    """

    # Таймаут и retry настройки
    CONNECT_TIMEOUT = 5   # секунды
    READ_TIMEOUT = 10     # секунды
    MAX_RETRIES = 3
    BACKOFF_FACTOR = 1.5  # 0s, 1.5s, 3s

    def __init__(self):
        self.api_url = getattr(
            settings,
            'BI_GROUP_LEAD_API_URL',
            'https://apigw.bi.group/siteApplications'
        )
        self.api_token = getattr(settings, 'BI_GROUP_LEAD_API_TOKEN', None)
        self.source_tag = getattr(settings, 'BI_GROUP_LEAD_SOURCE', 'telegram_bot')
        self._session = self._build_session()

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    def send_lead(
        self,
        *,
        user_name: str,
        user_phone: Optional[str],
        complex_uuid: Optional[str] = None,
        complex_name: Optional[str] = None,
        property_data: Optional[Dict] = None,
        user_tg_username: Optional[str] = None,
        user_tg_id: Optional[str] = None,
        comment: str = '',
    ) -> Dict:
        """
        Отправляет лид в CRM BI Group.

        Аргументы:
            user_name:        Имя пользователя
            user_phone:       Номер телефона (может быть None — тогда заявка без тел.)
            complex_uuid:     UUID ЖК из API BI Group
            complex_name:     Название ЖК
            property_data:    Полный dict PropertyDTO (опционально, для comment)
            user_tg_username: @username без '@' (Telegram)
            user_tg_id:       Числовой ID пользователя Telegram
            comment:          Дополнительный комментарий

        Возвращает:
            {'success': True, 'response': {...}} или {'success': False, 'error': '...'}
        """
        payload = self._build_payload(
            user_name=user_name,
            user_phone=user_phone,
            complex_uuid=complex_uuid,
            complex_name=complex_name,
            property_data=property_data,
            user_tg_username=user_tg_username,
            user_tg_id=user_tg_id,
            comment=comment,
        )

        logger.info(
            "📤 BI Group lead: отправка → %s | пользователь=%s | ЖК=%s",
            self.api_url,
            user_name,
            complex_name or complex_uuid or '—',
        )

        result = self._post_with_retry(payload)
        self._log_to_db(payload=payload, result=result)
        return result

    # ------------------------------------------------------------------
    # Private helpers
    # ------------------------------------------------------------------

    def _build_payload(self, *, user_name, user_phone, complex_uuid,
                       complex_name, property_data, user_tg_username,
                       user_tg_id, comment) -> Dict:
        """Формирует тело запроса по схеме BI Group siteApplications."""
        # Базовые поля (обязательные по API BI Group)
        payload: Dict = {
            'name': user_name or 'Пользователь Telegram',
            'phone': self._clean_phone(user_phone) if user_phone else '',
            'source': self.source_tag,
        }

        # UUID и название ЖК
        if complex_uuid:
            payload['realEstateUUID'] = complex_uuid
        if complex_name:
            payload['projectName'] = complex_name

        # Формируем комментарий из данных объекта
        if not comment and property_data:
            comment = self._build_comment(property_data, user_tg_username, user_tg_id)
        if comment:
            payload['comment'] = comment

        # Telegram-идентификаторы (BI Group принимает доп. поля в ext/meta)
        meta: Dict = {}
        if user_tg_id:
            meta['telegram_id'] = str(user_tg_id)
        if user_tg_username:
            meta['telegram_username'] = f'@{user_tg_username}'
        if meta:
            payload['meta'] = meta

        return payload

    @staticmethod
    def _clean_phone(phone: str) -> str:
        """Оставляет только цифры и ведущий '+'."""
        digits = ''.join(c for c in phone if c.isdigit())
        if len(digits) == 10:
            digits = '7' + digits  # добавляем код Казахстана
        return '+' + digits if digits else phone

    @staticmethod
    def _build_comment(property_data: Dict, tg_username, tg_id) -> str:
        parts = [
            f"Объект: {property_data.get('title', '')}",
            f"Адрес: {property_data.get('address', '')}",
        ]
        price = property_data.get('price_millions') or property_data.get('price')
        if price:
            try:
                parts.append(f"Цена: {float(price):.1f} млн ₸")
            except (ValueError, TypeError):
                pass
        if tg_username:
            parts.append(f"Telegram: @{tg_username}")
        if tg_id:
            parts.append(f"TG ID: {tg_id}")
        return '\n'.join(p for p in parts if p.split(': ', 1)[-1].strip())

    def _build_session(self) -> requests.Session:
        session = requests.Session()
        retry = Retry(
            total=self.MAX_RETRIES,
            backoff_factor=self.BACKOFF_FACTOR,
            status_forcelist=[429, 500, 502, 503, 504],
            allowed_methods=['POST'],
        )
        adapter = HTTPAdapter(max_retries=retry)
        session.mount('https://', adapter)
        session.mount('http://', adapter)
        return session

    def _get_headers(self) -> Dict:
        headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'User-Agent': 'HomeMe-TelegramBot/1.0',
        }
        if self.api_token:
            headers['Authorization'] = f'Bearer {self.api_token}'
        return headers

    def _post_with_retry(self, payload: Dict) -> Dict:
        last_error = None
        for attempt in range(1, self.MAX_RETRIES + 1):
            try:
                resp = self._session.post(
                    self.api_url,
                    json=payload,
                    headers=self._get_headers(),
                    timeout=(self.CONNECT_TIMEOUT, self.READ_TIMEOUT),
                )
                if resp.status_code in (200, 201):
                    body = self._safe_json(resp)
                    logger.info(
                        "✅ BI Group lead принят (попытка %d): %s", attempt, body
                    )
                    return {'success': True, 'response': body, 'status_code': resp.status_code}
                else:
                    last_error = f"HTTP {resp.status_code}: {resp.text[:200]}"
                    logger.warning(
                        "⚠️ BI Group lead: HTTP %d (попытка %d/%d): %s",
                        resp.status_code, attempt, self.MAX_RETRIES, resp.text[:200],
                    )
            except requests.exceptions.Timeout as exc:
                last_error = f"Timeout: {exc}"
                logger.warning("⏱ BI Group lead timeout (попытка %d/%d)", attempt, self.MAX_RETRIES)
            except requests.exceptions.RequestException as exc:
                last_error = str(exc)
                logger.warning("🔴 BI Group lead ошибка (попытка %d/%d): %s", attempt, self.MAX_RETRIES, exc)

            if attempt < self.MAX_RETRIES:
                time.sleep(self.BACKOFF_FACTOR ** attempt)

        logger.error("❌ BI Group lead: все %d попытки исчерпаны. Последняя ошибка: %s", self.MAX_RETRIES, last_error)
        return {'success': False, 'error': last_error or 'Unknown error'}

    @staticmethod
    def _safe_json(response: requests.Response) -> dict:
        try:
            return response.json()
        except Exception:
            return {'raw': response.text[:500]}

    @staticmethod
    def _log_to_db(payload: Dict, result: Dict) -> None:
        """Сохраняет лог в БД асинхронно (best-effort, ошибки игнорируются)."""
        try:
            from dashboard.models import BIGroupLeadLog
            BIGroupLeadLog.objects.create(
                phone=payload.get('phone', ''),
                name=payload.get('name', ''),
                complex_uuid=payload.get('realEstateUUID', ''),
                complex_name=payload.get('projectName', ''),
                source=payload.get('source', ''),
                meta=payload.get('meta', {}),
                comment=payload.get('comment', ''),
                success=result.get('success', False),
                error_message=result.get('error', ''),
                response_data=result.get('response', {}),
            )
        except Exception as exc:
            logger.debug("BIGroupLeadLog DB write skipped: %s", exc)
