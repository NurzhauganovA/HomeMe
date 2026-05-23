-- Схема telegram_bot для pgAdmin (managed=False в Django).
-- Выполните на своей БД, затем:
--   docker compose exec web python manage.py migrate telegram_bot 0001_initial --fake
--   docker compose exec web python manage.py migrate telegram_bot 0002_squashed_schema
--   docker compose exec web python manage.py migrate

CREATE EXTENSION IF NOT EXISTS vector;

-- Пример: колонки, которых может не быть после старых деплоев
ALTER TABLE telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';

ALTER TABLE telegram_bot_botuser
    ADD COLUMN IF NOT EXISTS referral_code varchar(32) UNIQUE,
    ADD COLUMN IF NOT EXISTS invited_by_id uuid REFERENCES telegram_bot_botuser(id) ON DELETE SET NULL,
    ADD COLUMN IF NOT EXISTS username varchar(100),
    ADD COLUMN IF NOT EXISTS role_id bigint REFERENCES dashboard_role(id) ON DELETE SET NULL;

-- Таблицы bi_*, daily usage, product events — создайте по текущим models.py
-- или снимите DDL с рабочего стенда: pg_dump --schema-only -t bi_complexes ...
