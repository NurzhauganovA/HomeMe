#!/bin/sh
# Загрузка backup_new.sql (только данные COPY) в существующую таблицу Django.
# Запуск из папки HomeMe (где docker-compose.yml):
#   sh scripts/sql/restore_backup_new.sh
#   sh scripts/sql/restore_backup_new.sh /path/to/backup_new.sql

set -e

BACKUP="${1:-backup_new.sql}"
POSTGRES_USER="${POSTGRES_USER:-homeme_user}"
POSTGRES_DB="${POSTGRES_DB:-homeme}"

if [ ! -f "$BACKUP" ]; then
  echo "Файл не найден: $BACKUP" >&2
  exit 1
fi

COPY_START=$(grep -n '^COPY public.telegram_bot_secondaryproperty' "$BACKUP" | head -1 | cut -d: -f1)
COPY_END=$(grep -n '^\\\.$' "$BACKUP" | head -1 | cut -d: -f1)

if [ -z "$COPY_START" ] || [ -z "$COPY_END" ]; then
  echo "Не найден блок COPY в $BACKUP" >&2
  exit 1
fi

echo "→ Файл: $BACKUP"
echo "→ COPY: строки $COPY_START–$COPY_END"
echo "→ БД: $POSTGRES_DB, пользователь: $POSTGRES_USER"

echo "→ Подготовка таблицы..."
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 <<'SQL'
ALTER TABLE public.telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';
TRUNCATE TABLE public.telegram_bot_secondaryproperty;
SQL

echo "→ Загрузка данных (может занять 1–3 минуты)..."
sed -n "${COPY_START},${COPY_END}p" "$BACKUP" | \
  docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 -q

echo "→ public_description из raw_data..."
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 <<'SQL'
UPDATE public.telegram_bot_secondaryproperty
SET public_description = COALESCE(
    NULLIF(TRIM(raw_data->>'public_description'), ''),
    NULLIF(TRIM(description), ''),
    ''
)
WHERE public_description = '' OR public_description IS NULL;

SELECT COUNT(*) AS total FROM telegram_bot_secondaryproperty;
SELECT COUNT(*) AS commercial_active
FROM telegram_bot_secondaryproperty
WHERE property_type = 'commercial' AND is_active = true;
SQL

echo "✅ Готово."
