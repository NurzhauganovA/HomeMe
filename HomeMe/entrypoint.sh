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
  if [ ! -f "${MIG_DIR}/0002_squashed_schema.py" ]; then
    echo "ERROR: missing ${MIG_DIR}/0002_squashed_schema.py (need 0001_initial + 0002_squashed_schema)."
    echo "Fix: git pull && docker compose build --no-cache web && docker compose up -d"
    exit 1
  fi
  MIG_COUNT=$(ls -1 "${MIG_DIR}"/*.py 2>/dev/null | wc -l | tr -d ' ')
  echo "Migration files in /app/${MIG_DIR}: ${MIG_COUNT}"
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