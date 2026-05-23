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

Миграции `telegram_bot`: `0001_initial` + `0002_squashed_schema` (без CREATE TABLE для BI и т.д.).

**Схема таблиц** — в PostgreSQL (pgAdmin), модели с **`managed = False`**.  
См. `HomeMe/scripts/sql/telegram_bot_pgadmin.sql`.

После SQL на сервере:

```bash
docker compose stop web
docker compose run --rm -e RUN_MIGRATIONS=0 -e RUN_COLLECTSTATIC=0 web \
  python manage.py migrate telegram_bot 0002_squashed_schema
docker compose up -d
```

Если `0001_initial` ещё не помечена, а таблицы уже есть: сначала `--fake` для `0001_initial`.
