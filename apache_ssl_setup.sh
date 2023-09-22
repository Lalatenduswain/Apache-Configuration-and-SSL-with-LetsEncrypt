#!/bin/bash

# Script for Apache Configuration and Let's Encrypt SSL Setup

# Ensure script is run as root or with sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo." 
   exit 1
fi

# Update system packages
apt update

# Install Apache
apt install -y apache2

# Create a directory for your website
mkdir -p /var/www/example.com

# Set permissions for the web directory
chown -R $USER:$USER /var/www/example.com
chmod -R 755 /var/www

# Enable necessary Apache modules
a2enmod proxy proxy_http proxy_ajp rewrite deflate headers proxy_balancer proxy_connect proxy_html ssl remoteip

# Create Apache VirtualHost configuration file
cat <<EOF > /etc/apache2/sites-available/example.com.conf
<VirtualHost *:80>
    ServerAdmin mail@example.com
    ServerName example.com
    ServerAlias www.example.com
    DocumentRoot /var/www/example.com
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<Directory /var/www/example.com>
    Options -Indexes
</Directory>
EOF

# Enable the new site and disable the default site
a2ensite example.com.conf
a2dissite 000-default.conf

# Perform a syntax check for Apache
apache2ctl configtest

# Restart Apache
systemctl restart apache2

# Set up a reverse proxy if needed (customize as per your requirements)
# Create or modify /etc/apache2/sites-enabled/example.com-le-ssl.conf

# Check firewall status and allow Apache
ufw status
ufw allow 'Apache Full'
ufw delete allow 'Apache'

# Restart Apache again
systemctl restart apache2

# Install Certbot for Let's Encrypt
apt install -y certbot python-certbot-apache

# Create SSL certificate for your domain
certbot --apache -d example.com -d www.example.com

# Check the Certbot timer service
systemctl status certbot.timer

# Test certificate autorenewal
certbot renew --dry-run

echo "Apache Configuration and Let's Encrypt SSL Setup complete!"
