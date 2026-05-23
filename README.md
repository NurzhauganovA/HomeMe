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

Миграции `telegram_bot`: **`0001_initial.py`** + **`0002_squashed_schema.py`** (всё бывшее 0002–0019 в одном файле).

### Если web падает на миграциях

```bash
git pull && cd HomeMe && docker compose build --no-cache web && docker compose up -d
```

Схема уже в PostgreSQL (`bi_complexes` и т.д. есть), а migrate падает с `DuplicateTable`:

```bash
docker compose exec web python manage.py fix_telegram_bot_migrations
docker compose exec web python manage.py migrate
```

Вручную (если команды ещё нет в образе):

```bash
docker compose exec db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c \
  "DELETE FROM django_migrations WHERE app='telegram_bot' AND name NOT IN ('0001_initial','0002_squashed_schema');"
docker compose exec web python manage.py migrate telegram_bot 0002_squashed_schema --fake
docker compose exec web python manage.py migrate
```
