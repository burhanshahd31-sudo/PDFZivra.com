#!/bin/sh
set -e

cd /app

# 1. Setup .env file if missing
if [ ! -f /app/.env ]; then
    cp /app/.env.example /app/.env
fi

# 2. Ensure SQLite database file exists and is accessible
mkdir -p /app/database
if [ ! -f /app/database/database.sqlite ]; then
    touch /app/database/database.sqlite
fi

# Ensure storage, cache, and database are writable by any user (including UID 1000)
chmod -R 777 /app/storage /app/bootstrap/cache /app/database /app/database/database.sqlite

# 3. Ensure Application Key is generated
if ! grep -q "APP_KEY=base64:" /app/.env; then
    php artisan key:generate --force
fi

# 4. Run SQLite Migrations and Seed Pre-loaded Tools/Forms/Admin
php artisan migrate --force
php artisan db:seed --force || true
php artisan storage:link || true

# 5. Clear and optimize caches for maximum production speed
php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true

echo "=========================================================="
echo " PDF Master 100% Free Platform Live on Port 7860"
echo "=========================================================="

# 6. Start PHP built-in server binding to 0.0.0.0:7860
exec php artisan serve --host=0.0.0.0 --port=7860
