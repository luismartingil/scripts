#!/bin/bash
#
# Bash script to install phpmyadmin in Centos.
# Author: luismartingil
# Year: 2012
#
# Centos installation script

# Installing the phpmyadmin
sudo rpm -ivh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum update
sudo yum install -y phpMyAdmin
sudo service httpd restart
sudo sed -i 's/Allow from 127.0.0.1/Allow from All/g' /etc/httpd/conf.d/phpMyAdmin.conf
# Logs, please
sudo sed -i 's/LogLevel warn/LogLevel debug/g' /etc/httpd/conf/httpd.conf
sudo service httpd restart

echo 'looks like you made it!'