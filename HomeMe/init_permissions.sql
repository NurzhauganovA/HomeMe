-- =============================================================================
-- HomeMe CRM: Инициализация разрешений системы
-- Запускать ПОСЛЕ применения миграций:
--   python manage.py migrate
--   psql -U <user> -d <db> -f init_permissions.sql
-- =============================================================================

-- Очистка перед вставкой (безопасно, если нужно переинициализировать)
-- DELETE FROM dashboard_permission;

INSERT INTO dashboard_permission (codename, name, description, category) VALUES

-- ==============================
-- Объекты недвижимости
-- ==============================
('view_apartments',
 'Просмотр квартир',
 'Доступ к просмотру и поиску жилых квартир в боте',
 'properties'),

('view_commercial',
 'Просмотр коммерческой недвижимости',
 'Доступ к офисам, торговым площадям, складам',
 'properties'),

-- ==============================
-- Тип рынка
-- ==============================
('view_primary_market',
 'Первичный рынок (новостройки)',
 'Доступ к объектам первичного рынка — ЖК и квартиры от застройщика BI Group',
 'market'),

('view_secondary_market',
 'Вторичный рынок',
 'Доступ к объектам вторичного рынка — перепродажа квартир и домов',
 'market'),

-- ==============================
-- Функции бота
-- ==============================
('use_bot',
 'Использование бота',
 'Базовый доступ к функциям бота — без этого разрешения бот не отвечает',
 'bot'),

('search_properties',
 'Поиск объектов',
 'Использование функции поиска недвижимости через бота',
 'bot'),

('manage_favorites',
 'Управление избранным',
 'Добавление и удаление объектов из списка избранного',
 'bot'),

('request_consultation',
 'Запрос консультации',
 'Создание заявки на консультацию с экспертом по недвижимости',
 'bot'),

-- ==============================
-- Контакты
-- ==============================
('view_contacts',
 'Просмотр контактов владельцев',
 'Доступ к телефонным номерам и контактам продавцов / арендодателей',
 'contacts'),

-- ==============================
-- Данные и аналитика
-- ==============================
('export_data',
 'Экспорт данных',
 'Возможность выгрузки подборки объектов в виде файла или ссылки',
 'data'),

('view_analytics',
 'Просмотр аналитики',
 'Доступ к аналитическим данным: динамика рынка, средние цены по районам',
 'data'),

('view_price_history',
 'История цен',
 'Просмотр динамики изменения цен на конкретный объект или район',
 'data')

ON CONFLICT (codename) DO UPDATE SET
    name        = EXCLUDED.name,
    description = EXCLUDED.description,
    category    = EXCLUDED.category;


-- =============================================================================
-- Создание базовых ролей
-- =============================================================================

-- Роль: Базовый пользователь
INSERT INTO dashboard_role
    (name, description, is_active, created_at, updated_at,
     limit_apartments_daily, limit_commercial_daily,
     limit_primary_daily, limit_secondary_daily, limit_total_daily)
VALUES
    ('Базовый', 'Стандартный доступ — ограниченный лимит выдачи объектов',
     true, NOW(), NOW(), 5, 3, 5, 5, 10)
ON CONFLICT (name) DO NOTHING;

-- Роль: Агент
INSERT INTO dashboard_role
    (name, description, is_active, created_at, updated_at,
     limit_apartments_daily, limit_commercial_daily,
     limit_primary_daily, limit_secondary_daily, limit_total_daily)
VALUES
    ('Агент', 'Риелтор или агент — повышенный лимит выдачи',
     true, NOW(), NOW(), 20, 10, 20, 20, 50)
ON CONFLICT (name) DO NOTHING;

-- Роль: VIP
INSERT INTO dashboard_role
    (name, description, is_active, created_at, updated_at,
     limit_apartments_daily, limit_commercial_daily,
     limit_primary_daily, limit_secondary_daily, limit_total_daily)
VALUES
    ('VIP', 'VIP-пользователь — неограниченный доступ',
     true, NOW(), NOW(), 9999, 9999, 9999, 9999, 9999)
ON CONFLICT (name) DO NOTHING;

-- Роль: Реферал (пришёл по ссылке от другого пользователя)
INSERT INTO dashboard_role
    (name, description, is_active, created_at, updated_at,
     limit_apartments_daily, limit_commercial_daily,
     limit_primary_daily, limit_secondary_daily, limit_total_daily)
VALUES
    ('Реферал', 'Пользователь, пришедший по реферальной ссылке друга',
     true, NOW(), NOW(), 5, 3, 5, 5, 10)
ON CONFLICT (name) DO NOTHING;


-- =============================================================================
-- Назначение разрешений базовым ролям
-- =============================================================================

-- Базовый: базовые функции бота + квартиры + оба рынка
INSERT INTO dashboard_role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM dashboard_role r, dashboard_permission p
WHERE r.name = 'Базовый'
  AND p.codename IN ('use_bot', 'search_properties', 'manage_favorites',
                     'view_apartments', 'view_primary_market', 'view_secondary_market')
ON CONFLICT DO NOTHING;

-- Агент: всё кроме аналитики и экспорта
INSERT INTO dashboard_role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM dashboard_role r, dashboard_permission p
WHERE r.name = 'Агент'
  AND p.codename IN ('use_bot', 'search_properties', 'manage_favorites',
                     'request_consultation', 'view_apartments', 'view_commercial',
                     'view_primary_market', 'view_secondary_market', 'view_contacts')
ON CONFLICT DO NOTHING;

-- VIP: все разрешения
INSERT INTO dashboard_role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM dashboard_role r, dashboard_permission p
WHERE r.name = 'VIP'
ON CONFLICT DO NOTHING;

-- Реферал: те же права, что у «Базовый»
INSERT INTO dashboard_role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM dashboard_role r, dashboard_permission p
WHERE r.name = 'Реферал'
  AND p.codename IN ('use_bot', 'search_properties', 'manage_favorites',
                     'view_apartments', 'view_primary_market', 'view_secondary_market')
ON CONFLICT DO NOTHING;


-- =============================================================================
-- Бэкфилл: каждому пользователю бота без роли выдаём «Базовый»
-- Аналог: python manage.py assign_default_roles
-- =============================================================================
UPDATE telegram_bot_botuser
SET role_id = (SELECT id FROM dashboard_role WHERE name = 'Базовый' AND is_active LIMIT 1)
WHERE role_id IS NULL;
