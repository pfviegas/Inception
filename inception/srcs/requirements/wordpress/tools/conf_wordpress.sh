#!/bin/bash

sleep 1

# Wordpress Download and config file creation
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp config create --allow-root --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$DB_HOST" --path="/var/www/html"
    sed -i -e "s/db1/$MYSQL_DATABASE/1" -e "s/user/$MYSQL_USER/1" -e "s/pwd/$MYSQL_PASSWORD/1" /var/www/html/wp-config.php
fi

# Wordpress Installation and Wordpress User creation
if [ ! "$(wp core is-installed --allow-root)" ]; then
    wp core install --url="$DOMAIN_NAME/" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    wp user create "$WP_USR" "$WP_EMAIL" --role=author --user_pass="$WP_PWD" --allow-root
fi

# Starts PHP-FPM
exec /usr/sbin/php-fpm7.4 -F

sleep 2
