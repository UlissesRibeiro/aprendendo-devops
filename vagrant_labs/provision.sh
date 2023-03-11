#!/bin/bash
echo "Instalando Apache e configurando setup!"
apt install apache2 -y > /dev/null 2>&1
cp -rfv /vagrant/html/ /var/www/
service apache2 start