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