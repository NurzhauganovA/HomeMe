#!/bin/sh

# Остановка при любой ошибке
set -e

echo "Waiting for postgres..."
# Ждем пока БД (хост 'db') станет доступна на порту 5432
while ! nc -z db 5432; do
  sleep 0.5
done
echo "PostgreSQL started"

# Накатываем миграции (только если включено)
if [ "${RUN_MIGRATIONS:-1}" = "1" ]; then
  MIG_DIR="telegram_bot/migrations"
  MIG_COUNT=$(ls -1 "${MIG_DIR}"/*.py 2>/dev/null | wc -l | tr -d ' ')
  echo "Migration files in /app/${MIG_DIR}: ${MIG_COUNT} (expected ~19)"
  if [ ! -f "${MIG_DIR}/0016_dailyusagelog.py" ]; then
    echo "ERROR: incomplete ${MIG_DIR} (missing 0016_dailyusagelog.py and likely 0002–0015)."
    if [ -f "HomeMe/${MIG_DIR}/0016_dailyusagelog.py" ]; then
      echo "Hint: migrations are in ./HomeMe/telegram_bot/migrations (GitHub layout),"
      echo "      but the image was built from the repo root. Use one of:"
      echo "        cd HomeMe && docker compose up -d --build"
      echo "        cd .. && docker compose -f docker-compose.yml up -d --build   # root compose"
    else
      echo "Fix: git pull, then rebuild from the Django project folder (HomeMe/):"
      echo "        cd HomeMe && docker compose build --no-cache && docker compose up -d"
    fi
    exit 1
  fi
  echo "Running migrations..."
  python manage.py migrate
else
  echo "Skipping migrations..."
fi

# Собираем статику (только если включено)
if [ "${RUN_COLLECTSTATIC:-1}" = "1" ]; then
  echo "Collecting static files..."
  python manage.py collectstatic --noinput
else
  echo "Skipping collectstatic..."
fi

# Запускаем команду, переданную в аргументах (или gunicorn по умолчанию)
exec "$@"