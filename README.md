# Apache Configuration and Let's Encrypt SSL Setup

This repository contains a step-by-step guide and scripts for configuring an Apache web server and setting up Let's Encrypt SSL certificates for your website. Proper server configuration is essential for hosting websites, and securing your site with SSL certificates is crucial for protecting user data and ensuring trust.

## Table of Contents

- [Installation](#installation)
- [Creating the Directory](#creating-the-directory)
- [Granting Permissions](#granting-permissions-to-user)
- [Allowing Read Access](#allow-read-access)
- [Enabling Necessary Apache Modules](#enabling-necessary-apache-modules)
- [Apache VirtualHost Configuration](#apache-virtualhost-configuration)
- [Enabling the New Site and Disabling the Default Site](#enable-the-new-site-and-disable-the-default-site)
- [Syntax Check](#syntax-check)
- [Setting Up a Reverse Proxy](#reverse-proxy-config)
- [Firewall Configuration](#check-firewall-status-and-allow-apache)
- [Restarting Apache](#restart-apache)
- [Let's Encrypt SSL Using Certbot](#lets-encrypt-ssl-using-certbot)
- [Donations](#donations)
- [Disclaimer](#disclaimer)
- [Author](#author)

## Installation

To get started with configuring Apache and setting up Let's Encrypt SSL certificates, follow these steps:

1. Install Apache on your server by running the following commands:

   ```sh
   sudo apt update
   sudo apt install apache2
   ```

2. Create the directory structure for your website:

   ```sh
   sudo mkdir -p /var/www/example.com
   ```

3. Grant necessary permissions to manage your website's files:

   ```sh
   sudo chown -R $USER:$USER /var/www/example.com
   ```

4. Allow read access to Apache:

   ```sh
   sudo chmod -R 755 /var/www
   ```

5. Enable essential Apache modules:

   ```sh
   sudo a2enmod proxy proxy_http proxy_ajp rewrite deflate headers proxy_balancer proxy_connect proxy_html ssl remoteip
   ```

6. Configure an Apache VirtualHost for your website as explained in the guide.

7. Enable your new site configuration and disable the default site:

   ```sh
   sudo a2ensite example.com.conf
   sudo a2dissite 000-default.conf
   ```

8. Perform a syntax check for Apache:

   ```sh
   sudo apache2ctl configtest
   ```

9. If you need to set up a reverse proxy, follow the reverse proxy configuration section in the guide.

10. Check your firewall status and allow Apache:

    ```sh
    sudo ufw status
    sudo ufw allow 'Apache Full'
    sudo ufw delete allow 'Apache'
    ```

11. Restart Apache to apply the changes:

    ```sh
    sudo apache2ctl configtest
    sudo systemctl restart apache2
    ```

12. To secure your website with Let's Encrypt SSL certificates, follow the steps described in the guide.

## Donations

If you find this guide helpful and want to show your appreciation, you can support the author by donating via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

## Disclaimer

**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage. Please ensure you have the necessary permissions and dependencies set up before running the script.
