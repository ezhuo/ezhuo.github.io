#!/bin/bash

cur_dir=$(cd `dirname $0`; pwd)
mysql_dir=${cur_dir}/conf.d.mysql
nginx_dir=${cur_dir}/conf.d.nginx

vi /etc/sysconfig/selinux
SELINUX=disabled

yum update -y
yum install -y wget mc lynx zip unzip

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh epel-release-latest-7*.rpm

wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7*.rpm

rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

cp -r ${cur_dir}/conf.d.mysql/MariaDB.repo /etc/yum.repos.d/MariaDB.repo

# vi /etc/yum.repos.d/remi.repo
# [remi-php56]
# enabled=1

#yum install mod_geoip mod_ssl mod_python

# 安装数据库
#yum install mysql mysql-devel -mysql-server mysql-libs compat-mysql51 mysql-common
yum install -y MariaDB-server MariaDB-client MariaDB-common MariaDB-devel

# 安装 apache nginx
yum install -y httpd httpd-devel nginx

# 安装PHP56
yum remove -y --enablerepo=remi,remi-php56 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common
yum install -y --enablerepo=remi,remi-php56 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common

# 安装PHP7
yum remove -y --enablerepo=remi,remi-php72 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common
yum install -y --enablerepo=remi,remi-php72 php php-opcache php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pdo php-pear php-fpm php-cli php-xml php-bcmath php-process php-gd php-common

# nginx 配置文件到配置目录
cp -r ${cur_dir}/conf.d.nginx/* /etc/nginx/conf.d/
cp -r ${cur_dir}/conf.d.nginx/fastcgi_params /etc/nginx/fastcgi_params
rm -rf /etc/nginx/conf.d/fastcgi_params

systemctl enable httpd.service
# systemctl start  httpd.service

systemctl enable nginx.service
# systemctl start  nginx.service

systemctl enable mysql.service
# systemctl start  mysql.service

systemctl enable php-fpm.service
# systemctl start  php-fpm.service

# ------------------------

reboot

mysql_secure_installation

lynx 127.0.0.1

yum install phpMyAdmin

systemctl restart  httpd.service