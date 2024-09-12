#!/bin/bash

# Atualizar pacotes
sudo apt-get update

# Instalar pacotes necessários
sudo apt-get install -y apache2 mysql-server php php-mysql php-gd php-mbstring libapache2-mod-php

# Configurar o MySQL
sudo mysql -u root <<EOF
CREATE DATABASE mantis;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'teupaiandadeuno';
GRANT ALL PRIVILEGES ON mantis.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

# Clonar repositório
cd /var/www/
sudo git clone https://github.com/UlissesRibeiro/teste-cad-usuario.git
sudo mv teste-cad-usuario cadastro

# Baixar o Mantis BugTracker
sudo wget https://mantisbt.org/builds/mantisbt-2.26.3-master-2.26-0d44c3652.tar.gz
sudo tar -xvf mantisbt-2.26.3-master-2.26-0d44c3652.tar.gz
sudo mv mantisbt-2.26.3-master-2.26-0d44c3652 mantis
sudo chown www-data:www-data -R mantis/


sudo tee /etc/apache2/sites-available/cadastro.conf <<EOF
<VirtualHost *:80>
    ServerName cadastro.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/cadastro
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo tee /etc/apache2/sites-available/mantis.conf <<EOF
<VirtualHost *:80>
    ServerName mantis-labo.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/mantis
    <Directory /var/www/mantis>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo chown www-data:www-data -R mantis/

sudo a2ensite cadastro.conf
sudo a2ensite mantis.conf
sudo a2enmod rewrite

sudo a2dissite 000-default.conf

sudo systemctl start apache2
sudo systemctl enable apache2
