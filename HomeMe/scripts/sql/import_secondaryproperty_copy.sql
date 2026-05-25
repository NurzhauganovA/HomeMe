-- Импорт telegram_bot_secondaryproperty из pgAdmin export (secondaryproperty.txt)
-- Формат: TEXT, разделитель TAB, поля в кавычках (как в вашем файле).
--
-- Перед запуском: расширение vector уже должно быть (migrate 0001_enable_pgvector).
-- Колонка public_description — в Django есть, в старом экспорте нет → заполним из raw_data после COPY.

BEGIN;

-- Опционально: очистить таблицу перед заливкой (раскомментируйте при повторном импорте)
-- TRUNCATE TABLE public.telegram_bot_secondaryproperty RESTART IDENTITY;

-- Если migrate уже добавила public_description, а в DDL pgAdmin её нет — добавить:
ALTER TABLE public.telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';

-- Пустой source_url в экспорте → NOT NULL в схеме
UPDATE public.telegram_bot_secondaryproperty SET source_url = '' WHERE source_url IS NULL;

-- === COPY: порядок колонок = порядок в secondaryproperty.txt / pgAdmin export ===
-- Выполняется из psql с STDIN (см. README в комментарии внизу файла или команды ниже).
--
-- COPY public.telegram_bot_secondaryproperty (
--     id, title, description, address, price, rooms, area, floor, total_floors,
--     city, district, latitude, longitude, owner_phone, owner_name,
--     has_parking, has_balcony, has_renovation, image,
--     is_active, is_verified, created_at, updated_at, views_count, embedding,
--     external_uuid, external_id, property_type, deal_type, condition, repair,
--     construction_year, material, address_note, source_url, photos, raw_data,
--     subtype, rent_type, currency, ceiling_height, rooms_total, area_living,
--     area_kitchen, prices, prices_m2, city_micro_district, coordinates_source
-- ) FROM STDIN WITH (FORMAT text, DELIMITER E'\t', NULL '');

-- После COPY — рекламное описание из JSON ILVO:
UPDATE public.telegram_bot_secondaryproperty
SET public_description = COALESCE(
    NULLIF(TRIM(raw_data->>'public_description'), ''),
    NULLIF(TRIM(description), ''),
    ''
)
WHERE public_description = '' OR public_description IS NULL;

-- Пустые обязательные JSON / URL
UPDATE public.telegram_bot_secondaryproperty SET material = '[]'::jsonb WHERE material IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET photos = '[]'::jsonb WHERE photos IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET raw_data = '{}'::jsonb WHERE raw_data IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET prices = '{}'::jsonb WHERE prices IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET prices_m2 = '{}'::jsonb WHERE prices_m2 IS NULL;
UPDATE public.telegram_bot_secondaryproperty SET source_url = '' WHERE source_url IS NULL;

COMMIT;

-- Проверка:
-- SELECT COUNT(*) FROM telegram_bot_secondaryproperty;
-- SELECT COUNT(*) FROM telegram_bot_secondaryproperty
--   WHERE property_type = 'commercial' AND is_active = true;
