#!/bin/bash
set -e

APP_DIR=/litecart-app
APACHE_HTML_DIR=/var/www/html

echo "Copying application files to Apache directory..."
rsync -a ${APP_DIR}/ ${APACHE_HTML_DIR}/public_html/

echo "Setting permissions for Apache directory..."
# Set correct permissions
chown -R www-data:www-data ${APACHE_HTML_DIR}/public_html \
    && chmod -R 755 ${APACHE_HTML_DIR}/public_html \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/cache \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/data \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/images \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/logs \
    && chmod -R 755 ${APACHE_HTML_DIR}/public_html/vmods

echo "Starting Apache server..."
exec apache2-foreground
