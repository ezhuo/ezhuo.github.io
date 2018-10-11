#!/bin/bash

pack_ver=php-7.2.10
# ------------------------------------
cur_dir=$(cd `dirname $0`; pwd)
package_dir=${cur_dir}/package
amp_dir=${cur_dir}/amp

# ------------------------------------
echo "PHP安装开始..."
service httpd stop
rm -rf /usr/local/php7

cd $amp_dir
rm -rf $pack_ver
tar -zvxf ${pack_ver}.tar.gz
cd $pack_ver
mkdir -p /usr/local/php7 #建立php安装目录

# groupadd php-fpm
# useradd -s /sbin/nologin -g php-fpm -M php-fpm

echo "PHP开始编译..."

# ./configure \
# --prefix=/usr/local/php7 \
# --with-config-file-path=/usr/local/php7/etc \
# # --with-apxs2=/usr/local/apache2/bin/apxs \
# --with-mysqli=/usr/local/mysql/bin/mysql_config \
# --with-mysql-sock=/var/lib/mysql/mysql.sock \
# --with-pdo-mysql=/usr/local/mysql \
# --enable-mysqlnd \
# --with-xpm-dir=/usr/lib64 \
# --with-gd=/usr/local/gd2 \
# --with-iconv \
# --with-freetype-dir \
# --with-jpeg-dir \
# --with-png-dir \
# --with-zlib \
# --with-libxml \
# --enable-simplexml \
# --enable-xml \
# --with-curl \
# --enable-discard-path \
# --enable-magic-quotes \
# --enable-bcmath \
# --enable-shmop \
# --enable-sysvsem \
# --enable-inline-optimization \
# --with-curlwrappers \
# --enable-mbregex \
# --enable-fpm \
# --with-fpm-user=nobody \
# --with-fpm-group=nobody \
# --with-fpm-systemd \
# --enable-fastcgi \
# --enable-force-cgi-redirect \
# --enable-mbstring \
# --enable-ftp \
# --enable-gd-native-ttf \
# --with-openssl \
# --enable-pcntl \
# --enable-sockets \
# --with-xmlrpc \
# --enable-zip \
# --enable-soap \
# --with-pear \
# --with-gettext \
# --with-mime-magic \
# --enable-suhosin \
# --enable-session \
# --with-mcrypt \
# --with-jpeg \
# --enable-opcache \
# --enable-static \
# --enable-wddx \
# --enable-calendar \
# --without-sqlite \
# --with-mhash \
# --disable-ipv6 \
# --disable-debug \
# --disable-maintainer-zts \
# --disable-safe-mode \
# --disable-fileinfo


./configure \
--prefix=/usr/local/php7 \
--with-config-file-path=/usr/local/php7/etc \
--with-zlib-dir \
--with-freetype-dir \
--enable-mbstring \
--with-libxml-dir=/usr \
--enable-xmlreader \
--enable-xmlwriter \
--enable-soap \
--enable-calendar \
--with-curl \
--with-zlib \
--with-gd \
--with-pdo-sqlite \
--with-pdo-mysql \
--with-mysqli \
--with-mysql-sock \
--enable-mysqlnd \
--disable-rpath \
--enable-inline-optimization \
--with-bz2 \
--with-zlib \
--enable-sockets \
--enable-sysvsem \
--enable-sysvshm \
--enable-pcntl \
--enable-mbregex \
--enable-exif \
--enable-bcmath \
--with-mhash \
--enable-zip \
--with-pcre-regex \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--with-openssl \
--enable-ftp \
--with-kerberos \
--with-gettext \
--with-xmlrpc \
--with-xsl \
--enable-fpm \
--with-fpm-user=nobody \
--with-fpm-group=nobody \
--with-fpm-systemd \
--disable-fileinfo

make #编译
make install #安装

#--------------------------------
echo "PHP开始配置..."
mkdir -p /usr/local/php7/etc
cp php.ini-production /usr/local/php7/etc/php.ini #复制php配置文件到安装目录
rm -rf /etc/php.ini #删除系统自带的配置文件
ln -s /usr/local/php7/etc/php.ini /etc/php.ini #创建配置文件软链接

echo "export PATH=\$PATH:/usr/local/php7/bin" >> /etc/profile
echo "session.save_path = \"/tmp\"" >> /etc/php.ini
echo "date.timezone=PRC" >> /etc/php.ini
echo "expose_php=OFF" >> /etc/php.ini

# -- php-fpm----------------
cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf
echo "pid = run/php-fpm.pid" >> /usr/local/php7/etc/php-fpm.conf
cp ./sapi/fpm/php-fpm.service /usr/lib/systemd/system/
systemctl enable php-fpm

# -- 创建目录----
mkdir -p /var/lib/php/session
chmod 777 /var/lib/php/session

# 设置启用配置
source /etc/profile
echo "php安装结束"

echo "正在启动httpd service"
service httpd restart #重启apache

systemctl start php-fpm

echo "正在启动mysql service"
service mysqld restart #重启mysql