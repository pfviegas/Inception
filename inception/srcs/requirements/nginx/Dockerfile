# Use the second-to-last stable version of Debian as the base image.
FROM	debian:bullseye

# Set DEBIAN_FRONTEND to noninteractive to avoid debconf errors
ENV DEBIAN_FRONTEND=noninteractive

#install nginx and openssl
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nginx \
    openssl

# nginx SSL
RUN mkdir /etc/nginx/ssl

# Gera um certificado SSL autoassinado
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/pviegas.crt \
       -keyout /etc/nginx/ssl/pviegas.key \
       -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=pviegas/CN=pviegas.42.fr/"

# copy configuration file
COPY ./tools/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

#the only port allowed
EXPOSE	443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

# Reset DEBIAN_FRONTEND variable to avoid affecting other processes
ENV DEBIAN_FRONTEND=
