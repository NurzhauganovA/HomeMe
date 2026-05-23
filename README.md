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

Миграции в git: `HomeMe/telegram_bot/migrations/` (файлы `0001` … `0018`).  
Не путать с `telegram_bot/` в корне репо — такой папки в git нет.
