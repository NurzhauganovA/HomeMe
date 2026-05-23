#!/bin/sh

set -e

echo "Waiting for postgres..."
while ! nc -z db 5432; do
  sleep 0.5
done
echo "PostgreSQL started"

if [ "${RUN_MIGRATIONS:-1}" = "1" ]; then
  MIG_DIR="telegram_bot/migrations"
  if [ ! -f "${MIG_DIR}/0002_squashed_schema.py" ]; then
    echo "ERROR: missing ${MIG_DIR}/0002_squashed_schema.py"
    exit 1
  fi
  echo "Running migrations (telegram_bot tables: managed=False, schema in PostgreSQL)..."
  python manage.py migrate --noinput
else
  echo "Skipping migrations..."
fi

if [ "${RUN_COLLECTSTATIC:-1}" = "1" ]; then
  echo "Collecting static files..."
  python manage.py collectstatic --noinput
else
  echo "Skipping collectstatic..."
fi

exec "$@"
