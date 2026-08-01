-- =============================================================================
-- HomeMe: синхронизация счётчиков (sequence) с реальными данными.
--
-- Зачем: pg_dump в конце файла выставляет setval(...) на значение, актуальное
-- на момент снятия дампа. Если дамп накатывали на базу, где данных уже больше,
-- счётчик уезжает назад, и следующий INSERT падает с
--   duplicate key value violates unique constraint "..._pkey"
-- Чаще всего это ловит auth_permission при `manage.py migrate`
-- (post_migrate создаёт разрешения для новых моделей).
--
-- Скрипт идемпотентный, выполнять целиком.
-- =============================================================================

DO $$
DECLARE
    rec record;
    seq_name text;
    max_id bigint;
BEGIN
    FOR rec IN
        SELECT c.oid::regclass AS tbl, a.attname AS col
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        JOIN pg_attribute a ON a.attrelid = c.oid
        WHERE c.relkind = 'r'
          AND n.nspname = 'public'
          AND a.attnum > 0
          AND NOT a.attisdropped
          AND pg_get_serial_sequence(c.oid::regclass::text, a.attname) IS NOT NULL
    LOOP
        seq_name := pg_get_serial_sequence(rec.tbl::text, rec.col);
        EXECUTE format('SELECT COALESCE(MAX(%I), 0) FROM %s', rec.col, rec.tbl) INTO max_id;
        PERFORM setval(seq_name, GREATEST(max_id, 1), max_id > 0);
        RAISE NOTICE '% -> %', seq_name, GREATEST(max_id, 1);
    END LOOP;
END $$;

-- Проверка: счётчик должен быть не меньше максимального id
-- SELECT last_value FROM auth_permission_id_seq;
-- SELECT MAX(id) FROM auth_permission;
