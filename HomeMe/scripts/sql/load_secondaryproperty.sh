#!/bin/sh
# Загрузка secondaryproperty.txt (pgAdmin export) в PostgreSQL Docker.
# Запуск из папки HomeMe (где docker-compose.yml):
#   sh scripts/sql/load_secondaryproperty.sh /path/to/secondaryproperty.txt
#
# Пример:
#   sh scripts/sql/load_secondaryproperty.sh ./secondaryproperty.txt

set -e

DATA_FILE="${1:?Укажите путь к secondaryproperty.txt}"

if [ ! -f "$DATA_FILE" ]; then
  echo "Файл не найден: $DATA_FILE" >&2
  exit 1
fi

# Имя БД/пользователя из .env (подставьте при необходимости)
POSTGRES_USER="${POSTGRES_USER:-homeme_user}"
POSTGRES_DB="${POSTGRES_DB:-homeme}"

echo "→ Подготовка схемы (public_description)..."
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 <<'SQL'
ALTER TABLE public.telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';
SQL

echo "→ COPY данных (может занять время для большого файла)..."
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 <<SQL
COPY public.telegram_bot_secondaryproperty (
    id, title, description, address, price, rooms, area, floor, total_floors,
    city, district, latitude, longitude, owner_phone, owner_name,
    has_parking, has_balcony, has_renovation, image,
    is_active, is_verified, created_at, updated_at, views_count, embedding,
    external_uuid, external_id, property_type, deal_type, condition, repair,
    construction_year, material, address_note, source_url, photos, raw_data,
    subtype, rent_type, currency, ceiling_height, rooms_total, area_living,
    area_kitchen, prices, prices_m2, city_micro_district, coordinates_source
) FROM STDIN WITH (FORMAT text, DELIMITER E'\t', NULL '');
SQL
< "$DATA_FILE"

echo "→ post-update (public_description, пустые JSON)..."
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v ON_ERROR_STOP=1 <<'SQL'
UPDATE public.telegram_bot_secondaryproperty
SET public_description = COALESCE(
    NULLIF(TRIM(raw_data->>'public_description'), ''),
    NULLIF(TRIM(description), ''),
    ''
)
WHERE public_description = '' OR public_description IS NULL;

UPDATE public.telegram_bot_secondaryproperty SET material = '[]'::jsonb WHERE material IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET photos = '[]'::jsonb WHERE photos IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET raw_data = '{}'::jsonb WHERE raw_data IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET prices = '{}'::jsonb WHERE prices IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET prices_m2 = '{}'::jsonb WHERE prices_m2 IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET source_url = '' WHERE source_url IS NULL;

SELECT COUNT(*) AS total FROM telegram_bot_secondaryproperty;
SELECT COUNT(*) AS commercial_active FROM telegram_bot_secondaryproperty
  WHERE property_type = 'commercial' AND is_active = true;
SQL

echo "✅ Готово."
