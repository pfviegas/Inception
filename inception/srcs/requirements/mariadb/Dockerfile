# Use the second-to-last stable version of Debian as the base image.
FROM debian:bullseye

# Update and install MariaDB server
RUN apt-get update -y && \
    apt-get install -y mariadb-server

# Copy the configuration script and make it executable
COPY ./tools/conf_mariadb.sh /
RUN chmod +x /conf_mariadb.sh

# Initialize the MariaDB data directory
RUN mysql_install_db

# Expose the MariaDB port
EXPOSE 3306

# Set the entrypoint to the configuration script
ENTRYPOINT ["/conf_mariadb.sh"]

# Default command to start the MariaDB server
CMD ["mysqld", "--bind-address=0.0.0.0"]
