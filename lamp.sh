#!/bin/bash

# Update system packages
sudo apt-get update  -y
sudo apt-get upgrade -y

# Install Apache
sudo apt-get install apache2 -y

# Install MySQL
sudo apt-get install mysql-server -y

# Install PHP
sudo apt-get install php libapache2-mod-php php-mysql -y

# Configure Apache to serve from /var/www/html
sudo sed -i 's|/var/www|/var/www/html|g' /etc/apache2/apache2.conf

# Create the website files
echo "<html>
<head>
    <title>Hello World!</title>
</head>
<body>
    <h1>Hello World!</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Configure MySQL
MYSQL_ROOT_PASSWORD="mypassword"
MYSQL_DATABASE="mydatabase"
MYSQL_USER="myuser"
MYSQL_PASSWORD="mypassword"

sudo mysql -u root <<-EOF
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost';
    FLUSH PRIVILEGES;
EOF

# Modify the website to use the MySQL database
echo "<?php
\$servername = 'localhost';
\$username = '${MYSQL_USER}';
\$password = '${MYSQL_PASSWORD}';
\$dbname = '${MYSQL_DATABASE}';

\$conn = new mysqli(\$servername, \$username, \$password, \$dbname);
if (\$conn->connect_error) {
    die('Connection failed: ' . \$conn->connect_error);
}

\$ip = \$_SERVER['REMOTE_ADDR'];
\$time = date('Y-m-d H:i:s');
echo 'Hello World! Your IP address is ' . \$ip . '. Current time is ' . \$time;

\$conn->close();
?>" | sudo tee /var/www/html/info.php

# Restart Apache
sudo systemctl restart apache2

# Display completion message
echo "Web server and MySQL configuration completed successfully!"
