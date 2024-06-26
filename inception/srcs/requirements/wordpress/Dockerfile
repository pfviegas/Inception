# Wordpress Dockerfile
FROM debian:bullseye

# Set DEBIAN_FRONTEND to noninteractive to avoid debconf errors
ENV DEBIAN_FRONTEND=noninteractive

# Set working dir
WORKDIR /var/www/html

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    php-curl	\
    php-fpm	\
    php-mysql	\
    curl

# Install wp-cli (wordpress-client)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# php-fpm configuration
RUN mkdir -p /run/php/ && chmod 755 /run/php/
RUN sed -i 's+listen = /run/php/php7.4-fpm.sock+listen = 9000+g' /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/conf_wordpress.sh /
RUN chmod +x /conf_wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/conf_wordpress.sh"]

# Reset DEBIAN_FRONTEND variable to avoid affecting other processes
ENV DEBIAN_FRONTEND=
