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
# схема уже есть в БД:
docker compose exec web python manage.py migrate telegram_bot 0002_squashed_schema --fake
docker compose exec web python manage.py migrate
```
