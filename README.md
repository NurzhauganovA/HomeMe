# HomeMe

Django-проект в папке **`HomeMe/`** (там же `manage.py`, `Dockerfile`, `docker-compose.yml`).

## Docker

Из **корня репозитория** (после `git pull`):

```bash
docker compose up -d --build
```

Или из папки проекта:

```bash
cd HomeMe && docker compose up -d --build
```

При старте контейнер `web` автоматически выполняет `python manage.py migrate`.

## Миграции (чистая БД)

После удаления volume PostgreSQL или создания новой пустой БД схема поднимается только через Django:

| Приложение      | Файлы |
|-----------------|-------|
| `dashboard`     | `0001_initial`, `0002_initial` |
| `telegram_bot`  | `0001_enable_pgvector`, `0002_initial` |
| `whatsapp_bot`  | `0001_initial` |

Порядок: расширение `vector` → роли/анкеты (`dashboard`) → пользователи и объекты (`telegram_bot`) → связи анкет с `BotUser` → WhatsApp.

Полный сброс данных (осторожно, backup уже должен быть):

```bash
cd HomeMe
docker compose down
docker volume rm homeme_postgres_data   # имя volume смотрите: docker volume ls
docker compose up -d --build
docker compose exec web python manage.py createsuperuser
```

Старый SQL-скрипт `scripts/sql/telegram_bot_pgadmin.sql` для новых установок **не нужен** — только для ручного восстановления legacy-схемы.
