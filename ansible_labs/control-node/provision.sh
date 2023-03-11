#!/bin/sh

echo "Inicio da instalação do Ansible"

apt install ansible -y > /dev/null 2>&1

cp -rfv /vagrant/hosts /etc/
