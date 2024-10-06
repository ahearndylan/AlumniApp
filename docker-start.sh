#!/bin/bash

# Stop on the first sign of trouble
set -e

# Collect static files
echo "Collect static files"
python manage.py collectstatic --noinput

# Apply database migrations
echo "Apply database migrations"
python manage.py migrate

# Initialize environment
echo "Initializing data"
python manage.py initialize_groups

# The line to create an admin user should be manually handled if needed

# Start Gunicorn server
echo "Starting Gunicorn server"
gunicorn config.wsgi:application --bind 0.0.0.0:8000
