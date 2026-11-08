# Official PHP 8.2 CLI Base Image
FROM php:8.2-cli

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential system dependencies and libraries for PDF tools & GD
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libsqlite3-dev \
    sqlite3 \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd zip pdo_sqlite bcmath \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install official Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Create Hugging Face standard non-root user (UID 1000)
RUN useradd -m -u 1000 user || true

# Set working directory
WORKDIR /app

# Copy application source code
COPY . /app

# Ensure SQLite database directory & file exist with full read/write permissions
RUN mkdir -p /app/database /app/storage /app/bootstrap/cache \
    && touch /app/database/database.sqlite \
    && chmod -R 777 /app/storage /app/bootstrap/cache /app/database

# Install PHP composer dependencies (production mode)
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Hugging Face Spaces environment defaults
ENV PORT=7860 \
    APP_ENV=production \
    APP_DEBUG=false \
    DB_CONNECTION=sqlite \
    DB_DATABASE=/app/database/database.sqlite \
    PHP_CLI_SERVER_WORKERS=4

# Expose mandatory Hugging Face port 7860
EXPOSE 7860

# Clean CRLF carriage returns from entrypoint script and grant execution permissions
RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# Run entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
