#!/bin/sh

# Остановка при любой ошибке
set -e

echo "Waiting for postgres..."
# Ждем пока БД (хост 'db') станет доступна на порту 5432
while ! nc -z db 5432; do
  sleep 0.5
done
echo "PostgreSQL started"

# Накатываем миграции
echo "Running migrations..."
python manage.py migrate

# Собираем статику (для админки и дашборда)
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Запускаем команду, переданную в аргументах (или gunicorn по умолчанию)
exec "$@"