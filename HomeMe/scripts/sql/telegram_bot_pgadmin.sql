-- =============================================================================
-- HomeMe: дополнение схемы telegram_bot под models.py (managed=False)
-- Выполнить в pgAdmin на вашей БД целиком (можно по блокам).
-- =============================================================================

CREATE EXTENSION IF NOT EXISTS vector;

-- -----------------------------------------------------------------------------
-- 1. telegram_bot_botuser (у вас уже есть username, role_id — не хватает рефералов)
-- -----------------------------------------------------------------------------
ALTER TABLE telegram_bot_botuser
    ADD COLUMN IF NOT EXISTS referral_code varchar(32),
    ADD COLUMN IF NOT EXISTS invited_by_id uuid;

CREATE INDEX IF NOT EXISTS telegram_bot_botuser_referral_code_idx
    ON telegram_bot_botuser (referral_code)
    WHERE referral_code IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS telegram_bot_botuser_referral_code_key
    ON telegram_bot_botuser (referral_code)
    WHERE referral_code IS NOT NULL;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'telegram_bot_botuser_invited_by_id_fkey'
    ) THEN
        ALTER TABLE telegram_bot_botuser
            ADD CONSTRAINT telegram_bot_botuser_invited_by_id_fkey
            FOREIGN KEY (invited_by_id) REFERENCES telegram_bot_botuser (id)
            ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;
    END IF;
END $$;

-- username / role_id — если ещё нет (на старых БД)
ALTER TABLE telegram_bot_botuser
    ADD COLUMN IF NOT EXISTS username varchar(100),
    ADD COLUMN IF NOT EXISTS role_id bigint;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'telegram_bot_botuser_role_id_fkey'
    ) THEN
        ALTER TABLE telegram_bot_botuser
            ADD CONSTRAINT telegram_bot_botuser_role_id_fkey
            FOREIGN KEY (role_id) REFERENCES dashboard_role (id)
            ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS telegram_bot_botuser_username_idx
    ON telegram_bot_botuser (username);

-- -----------------------------------------------------------------------------
-- 2. telegram_bot_usersession
-- -----------------------------------------------------------------------------
ALTER TABLE telegram_bot_usersession
    ADD COLUMN IF NOT EXISTS state varchar(50) NOT NULL DEFAULT 'START';

-- -----------------------------------------------------------------------------
-- 3. telegram_bot_lead — поля аналитики (ТЗ п.6)
-- -----------------------------------------------------------------------------
ALTER TABLE telegram_bot_lead
    ADD COLUMN IF NOT EXISTS lead_source varchar(40) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS developer varchar(120) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS residential_complex varchar(255) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS district varchar(120) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS property_type_label varchar(80) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS market_type_label varchar(80) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS budget_display varchar(160) NOT NULL DEFAULT '';

CREATE INDEX IF NOT EXISTS telegram_bot_lead_lead_source_idx
    ON telegram_bot_lead (lead_source);

-- -----------------------------------------------------------------------------
-- 4. telegram_bot_secondaryproperty — ILVO + внешние поля
-- -----------------------------------------------------------------------------
ALTER TABLE telegram_bot_secondaryproperty
    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS external_uuid varchar(100),
    ADD COLUMN IF NOT EXISTS external_id bigint,
    ADD COLUMN IF NOT EXISTS property_type varchar(50),
    ADD COLUMN IF NOT EXISTS subtype varchar(100),
    ADD COLUMN IF NOT EXISTS deal_type varchar(50),
    ADD COLUMN IF NOT EXISTS rent_type varchar(50),
    ADD COLUMN IF NOT EXISTS currency varchar(10),
    ADD COLUMN IF NOT EXISTS condition varchar(50),
    ADD COLUMN IF NOT EXISTS repair varchar(50),
    ADD COLUMN IF NOT EXISTS construction_year integer,
    ADD COLUMN IF NOT EXISTS ceiling_height double precision,
    ADD COLUMN IF NOT EXISTS rooms_total integer,
    ADD COLUMN IF NOT EXISTS area_living double precision,
    ADD COLUMN IF NOT EXISTS area_kitchen double precision,
    ADD COLUMN IF NOT EXISTS material jsonb NOT NULL DEFAULT '[]'::jsonb,
    ADD COLUMN IF NOT EXISTS prices jsonb NOT NULL DEFAULT '{}'::jsonb,
    ADD COLUMN IF NOT EXISTS prices_m2 jsonb NOT NULL DEFAULT '{}'::jsonb,
    ADD COLUMN IF NOT EXISTS address_note varchar(500),
    ADD COLUMN IF NOT EXISTS city_micro_district varchar(100),
    ADD COLUMN IF NOT EXISTS source_url varchar(200) NOT NULL DEFAULT '',
    ADD COLUMN IF NOT EXISTS photos jsonb NOT NULL DEFAULT '[]'::jsonb,
    ADD COLUMN IF NOT EXISTS raw_data jsonb NOT NULL DEFAULT '{}'::jsonb,
    ADD COLUMN IF NOT EXISTS coordinates_source varchar(20);

CREATE UNIQUE INDEX IF NOT EXISTS telegram_bot_secondaryproperty_external_uuid_key
    ON telegram_bot_secondaryproperty (external_uuid)
    WHERE external_uuid IS NOT NULL;

CREATE INDEX IF NOT EXISTS telegram_bot_secondaryproperty_external_uuid_idx
    ON telegram_bot_secondaryproperty (external_uuid);

CREATE INDEX IF NOT EXISTS telegram_bot_secondaryproperty_external_id_idx
    ON telegram_bot_secondaryproperty (external_id);

CREATE INDEX IF NOT EXISTS telegram_bot_secondaryproperty_property_type_idx
    ON telegram_bot_secondaryproperty (property_type);

CREATE INDEX IF NOT EXISTS telegram_bot_secondaryproperty_deal_type_idx
    ON telegram_bot_secondaryproperty (deal_type);

-- description: в models blank=True; старая БД могла быть NOT NULL — оставляем как есть

-- -----------------------------------------------------------------------------
-- 5. telegram_bot_favoriteproperty
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS telegram_bot_favoriteproperty (
    id uuid PRIMARY KEY,
    source varchar(20) NOT NULL,
    object_kind varchar(20) NOT NULL,
    object_id varchar(100) NOT NULL,
    data jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    user_id uuid NOT NULL REFERENCES telegram_bot_botuser (id)
        ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX IF NOT EXISTS telegram_bot_favoriteproperty_user_id_source_idx
    ON telegram_bot_favoriteproperty (user_id, source);

CREATE INDEX IF NOT EXISTS telegram_bot_favoriteproperty_object_kind_object_id_idx
    ON telegram_bot_favoriteproperty (object_kind, object_id);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'unique_favorite_object'
    ) THEN
        ALTER TABLE telegram_bot_favoriteproperty
            ADD CONSTRAINT unique_favorite_object
            UNIQUE (user_id, object_kind, object_id);
    END IF;
END $$;

-- -----------------------------------------------------------------------------
-- 6. telegram_bot_botproductevent — продуктовая аналитика
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS telegram_bot_botproductevent (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    event_type varchar(40) NOT NULL,
    payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    property_type varchar(32) NOT NULL DEFAULT '',
    market_type varchar(32) NOT NULL DEFAULT '',
    created_at timestamptz NOT NULL DEFAULT NOW(),
    user_id uuid NOT NULL REFERENCES telegram_bot_botuser (id)
        ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX IF NOT EXISTS telegram_bot_botproductevent_event_type_created_at_idx
    ON telegram_bot_botproductevent (event_type, created_at DESC);

CREATE INDEX IF NOT EXISTS telegram_bot_botproductevent_user_id_created_at_idx
    ON telegram_bot_botproductevent (user_id, created_at DESC);

-- -----------------------------------------------------------------------------
-- 7. telegram_bot_dailyusagelog — лимиты выдачи
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS telegram_bot_dailyusagelog (
    id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    date date NOT NULL,
    objects_shown integer NOT NULL DEFAULT 0,
    bonus_limit_daily integer NOT NULL DEFAULT 0,
    apartments_shown integer NOT NULL DEFAULT 0,
    commercial_shown integer NOT NULL DEFAULT 0,
    primary_shown integer NOT NULL DEFAULT 0,
    secondary_shown integer NOT NULL DEFAULT 0,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    updated_at timestamptz NOT NULL DEFAULT NOW(),
    user_id uuid NOT NULL REFERENCES telegram_bot_botuser (id)
        ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    CONSTRAINT telegram_bot_dailyusagelog_user_id_date_uniq UNIQUE (user_id, date)
);

CREATE INDEX IF NOT EXISTS telegram_bot_dailyusagelog_user_id_date_idx
    ON telegram_bot_dailyusagelog (user_id, date);

-- -----------------------------------------------------------------------------
-- 8. BI Group — первичный рынок (если таблиц ещё нет)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bi_complexes (
    id uuid PRIMARY KEY,
    bi_uuid varchar(100) NOT NULL UNIQUE,
    name varchar(255) NOT NULL,
    address varchar(500) NOT NULL DEFAULT '',
    description text NOT NULL DEFAULT '',
    latitude double precision,
    longitude double precision,
    city_uuid varchar(100) NOT NULL,
    class_name varchar(100) NOT NULL DEFAULT '',
    deadline varchar(50) NOT NULL DEFAULT '',
    min_price numeric(15, 2),
    min_area double precision,
    max_area double precision,
    url varchar(200) NOT NULL DEFAULT '',
    image_url varchar(200) NOT NULL DEFAULT '',
    features jsonb NOT NULL DEFAULT '{}'::jsonb,
    embedding vector(768),
    updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS bi_complexes_bi_uuid_idx ON bi_complexes (bi_uuid);
CREATE INDEX IF NOT EXISTS bi_complexes_city_uuid_idx ON bi_complexes (city_uuid);

CREATE TABLE IF NOT EXISTS bi_units (
    id uuid PRIMARY KEY,
    bi_uuid varchar(100) NOT NULL UNIQUE,
    room_count integer NOT NULL,
    floor integer NOT NULL,
    max_floor integer,
    area double precision NOT NULL,
    price numeric(15, 2) NOT NULL,
    price_discount numeric(15, 2),
    block_name varchar(100) NOT NULL DEFAULT '',
    deadline varchar(50) NOT NULL DEFAULT '',
    is_active boolean NOT NULL DEFAULT true,
    photos jsonb NOT NULL DEFAULT '[]'::jsonb,
    complex_id uuid NOT NULL REFERENCES bi_complexes (id)
        ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX IF NOT EXISTS bi_units_bi_uuid_idx ON bi_units (bi_uuid);
CREATE INDEX IF NOT EXISTS bi_commerci_price_d_227ae2_idx ON bi_units (price_discount, room_count);
CREATE INDEX IF NOT EXISTS bi_commerci_area_c15c5d_idx ON bi_units (area);

CREATE TABLE IF NOT EXISTS bi_commercial_complexes (
    id uuid PRIMARY KEY,
    bi_uuid varchar(100) NOT NULL UNIQUE,
    name varchar(255) NOT NULL,
    address varchar(500) NOT NULL DEFAULT '',
    description text NOT NULL DEFAULT '',
    latitude double precision,
    longitude double precision,
    city_uuid varchar(100) NOT NULL,
    class_name varchar(100) NOT NULL DEFAULT '',
    deadline varchar(50) NOT NULL DEFAULT '',
    min_price numeric(15, 2),
    min_area double precision,
    max_area double precision,
    url varchar(200) NOT NULL DEFAULT '',
    image_url varchar(200) NOT NULL DEFAULT '',
    features jsonb NOT NULL DEFAULT '{}'::jsonb,
    embedding vector(768),
    updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS bi_commercial_units (
    id uuid PRIMARY KEY,
    bi_uuid varchar(100) NOT NULL UNIQUE,
    room_count integer NOT NULL,
    floor integer NOT NULL,
    max_floor integer,
    area double precision NOT NULL,
    price numeric(15, 2) NOT NULL,
    price_discount numeric(15, 2),
    block_name varchar(100) NOT NULL DEFAULT '',
    deadline varchar(50) NOT NULL DEFAULT '',
    is_active boolean NOT NULL DEFAULT true,
    photos jsonb NOT NULL DEFAULT '[]'::jsonb,
    complex_id uuid NOT NULL REFERENCES bi_commercial_complexes (id)
        ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE INDEX IF NOT EXISTS bi_commercial_units_bi_uuid_idx ON bi_commercial_units (bi_uuid);
CREATE INDEX IF NOT EXISTS bi_commercial_units_price_discount_room_count_idx
    ON bi_commercial_units (price_discount, room_count);
CREATE INDEX IF NOT EXISTS bi_commercial_units_area_idx ON bi_commercial_units (area);

-- -----------------------------------------------------------------------------
-- 9. Проверка: колонки botuser (должны быть referral_code, invited_by_id)
-- -----------------------------------------------------------------------------
-- SELECT column_name, data_type
-- FROM information_schema.columns
-- WHERE table_schema = 'public' AND table_name = 'telegram_bot_botuser'
-- ORDER BY ordinal_position;
