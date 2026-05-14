#!/bin/bash
set -e

APP_DIR=/litecart-app
APACHE_HTML_DIR=/var/www/html
rsync -a --delete ${APP_DIR}/ ${APACHE_HTML_DIR}/public_html/

# Set correct permissions
RUN chown -R www-data:www-data ${APACHE_HTML_DIR}/public_html \
    && chmod -R 755 ${APACHE_HTML_DIR}/public_html \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/cache \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/data \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/images \
    && chmod -R 775 ${APACHE_HTML_DIR}/public_html/logs \
    && chmod -R 755 ${APACHE_HTML_DIR}/public_html/vmods

exec apache2-foreground
