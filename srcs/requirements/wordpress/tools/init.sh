#!/bin/bash
set -e


until mariadb -h"$MYSQL_HOST" -u"$MYSQL_USER" --password="$MYSQL_PASSWORD" -e "SELECT 1" &>/dev/null; do
    echo "Waiting for MariaDB..."
    sleep 2
done
echo "MariaDB ready."

cd /var/www/html

# Download WordPress if not present
if [ ! -f wp-load.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
    if [ ! -f wp-config.php ]; then
    wp config create --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST"
    fi  
fi

# Install WordPress if not installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email
fi

# Create second user if it doesn't exist
if ! wp user get "${WP_USER_USER}" --allow-root &>/dev/null; then
    wp user create "${WP_USER_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASS}" --role=editor --allow-root || true
fi

# Configure Redis if REDIS_HOST is set
if [ -n "$REDIS_HOST" ]; then
    echo "Configuring Redis..."
    # Add Redis constants to wp-config.php if not present
    if ! grep -q "WP_REDIS_HOST" wp-config.php; then
        sed -i "/\/\* That's all, stop editing!/i \
define('WP_REDIS_HOST', '${REDIS_HOST}');\ndefine('WP_REDIS_PORT', ${REDIS_PORT:-6379});\ndefine('WP_REDIS_PASSWORD', '${REDIS_PASSWORD}');\n" wp-config.php
    fi
    # Install and activate redis-cache plugin
    if ! wp plugin is-installed redis-cache --allow-root 2>/dev/null; then
        wp plugin install redis-cache --allow-root
    fi
    wp plugin activate redis-cache --allow-root 2>/dev/null || true
    wp redis enable --allow-root 2>/dev/null || true
    echo "Redis configured."
fi

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

exec "$@"