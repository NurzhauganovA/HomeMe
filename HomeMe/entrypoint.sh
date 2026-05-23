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
  if [ ! -f "${MIG_DIR}/0016_dailyusagelog.py" ]; then
    echo "ERROR: incomplete ${MIG_DIR} (missing 0016_dailyusagelog.py and likely 0002–0015)."
    echo "Fix: git pull on the server, then rebuild: docker compose build --no-cache web && docker compose up -d"
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