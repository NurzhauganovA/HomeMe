#!/bin/sh

set -e

echo "Waiting for postgres..."
while ! nc -z db 5432; do
  sleep 0.5
done
echo "PostgreSQL started"

if [ "${RUN_MIGRATIONS:-1}" = "1" ]; then
  echo "Running migrations..."
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
