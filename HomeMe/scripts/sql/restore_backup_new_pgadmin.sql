-- ============================================================
-- pgAdmin: загрузка ТОЛЬКО данных из backup_new.sql
-- ============================================================
-- НЕ выполняйте весь backup_new.sql целиком — там CREATE TABLE
-- и индексы, они уже есть после Django migrate.
--
-- Шаг 1: выполните ЭТОТ файл (Query Tool).
-- Шаг 2: см. инструкцию в README ниже — блок COPY из backup_new.sql.

ALTER TABLE public.telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';

TRUNCATE TABLE public.telegram_bot_secondaryproperty;

-- После TRUNCATE в pgAdmin:
-- Query Tool → откройте backup_new.sql
-- Скопируйте строки от:
--   COPY public.telegram_bot_secondaryproperty (...)
-- до строки:
--   \.
-- (в файле примерно строки 92–6645)
-- Вставьте во второй Query Tool и Execute.
--
-- Или на сервере: sh scripts/sql/restore_backup_new.sh

-- Шаг 3: после COPY выполните:
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
