#!/bin/bash

# Check if the MariaDB data directory for $MYSQL_DATABASE doesn't exist
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    # Start the MariaDB service
    service mariadb start

    # Wait for the service to start
    sleep 2

    # Run mysql_secure_installation with heredoc to input the following answers:
    # Change the root password? [Y/n]
    # New password:
    # Re-enter new password:
    # Remove anonymous users? [Y/n]
    # Disallow root login remotely? [Y/n]
    # Remove test database and access to it? [Y/n]
    # Reload privilege tables now? [Y/n]
    mysql_secure_installation << EOF
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
Y
Y
Y
EOF
    # Wait to apply the changes
    sleep 1

    # Create the database and user, grant privileges
    mysql -u root <<-EOSQL
        CREATE DATABASE $MYSQL_DATABASE;
        CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
        GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
        FLUSH PRIVILEGES;
EOSQL

    # Stop the MariaDB service
    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
else
    sleep 2
    echo "Database already exists."
fi

echo "Mariadb ready..."

# Start the MariaDB service with any provided command-line arguments
exec "$@"
