#!/usr/bin/env bash

echo "Start backend server"
until cd /app/backend/server
do
    echo "Waiting for server volume..."
done

# Run makemigrations
until ./manage.py makemigrations
do
    echo "Waiting for database to be ready for migrations..."
    sleep 2
done

# Run migrations
until ./manage.py migrate
do
    echo "Waiting for database to be ready..."
    sleep 2
done

# Collect static files
./manage.py collectstatic --noinput

# Start the server with Gunicorn
gunicorn server.wsgi --bind 0.0.0.0:8000 --workers 4 --threads 4
