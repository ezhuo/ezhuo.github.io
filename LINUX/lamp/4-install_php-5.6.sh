#!/bin/bash

pack_ver=php-5.6.26
# ------------------------------------
cur_dir=$(cd `dirname $0`; pwd)
package_dir=${cur_dir}/package
amp_dir=${cur_dir}/amp

# ------------------------------------
echo "PHP安装开始..."
service httpd stop
rm -rf /usr/local/php5

cd $amp_dir
rm -rf $pack_ver
tar -zvxf ${pack_ver}.tar.gz
cd $pack_ver
mkdir -p /usr/local/php5 #建立php安装目录

echo "PHP开始编译..."
./configure	--prefix=/usr/local/php5 \
--with-config-file-path=/usr/local/php5/etc \
--with-apxs2=/usr/local/apache2/bin/apxs \
--with-mysql=/usr/local/mysql \
--with-mysqli=/usr/local/mysql/bin/mysql_config \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-pdo-mysql=/usr/local/mysql \
--with-iconv \
--with-xpm-dir=/usr/lib64 \
--with-gd=/usr/local/gd2 \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml \
--enable-xml \
--with-curl \
--enable-discard-path \
--enable-magic-quotes \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curlwrappers \
--enable-mbregex \
--enable-fpm \
--enable-fastcgi \
--enable-force-cgi-redirect \
--enable-mbstring \
--enable-ftp \
--enable-gd-native-ttf \
--with-openssl \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--with-pear \
--with-gettext \
--with-mime-magic \
--enable-suhosin \
--enable-session \
--with-mcrypt \
--with-jpeg \
--enable-opcache \
--enable-static \
--enable-wddx \
--enable-calendar \
--without-sqlite \
--disable-ipv6 \
--disable-debug \
--disable-maintainer-zts \
--disable-safe-mode \
--disable-fileinfo

make #编译
make install #安装

#--------------------------------
echo "PHP开始配置..."
mkdir -p /usr/local/php5/etc
cp php.ini-production /usr/local/php5/etc/php.ini #复制php配置文件到安装目录
rm -rf /etc/php.ini #删除系统自带的配置文件
ln -s /usr/local/php5/etc/php.ini /etc/php.ini #创建配置文件软链接

echo "export PATH=\$PATH:/usr/local/php5/bin" >> /etc/profile
echo "session.save_path = \"/tmp\"" >> /etc/php.ini
echo "date.timezone=PRC" >> /etc/php.ini
echo "expose_php=OFF" >> /etc/php.ini

mkdir -p /var/lib/php/session
chmod 777 /var/lib/php/session

# 设置启用配置
source /etc/profile
echo "php安装结束"

echo "正在启动httpd service"
service httpd restart #重启apache

echo "正在启动mysql service"
service mysqld restart #重启mysql

# ---------------------------------------------

# vi /usr/local/php5/etc/php.ini #编辑
# 找到：;open_basedir =
# 修改为：open_basedir = .:/tmp/ #防止php木马跨站，重要!!
# 找到：disable_functions =
# 修改为：disable_functions=passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

# #列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。
# 找到：;date.timezone =
# 修改为：date.timezone=PRC
# 找到：expose_php = On
# 修改为：expose_php = OFF #禁止显示php版本的信息
# 找到：display_errors = On
# 修改为：display_errors = OFF #关闭错误提示

# 配置apache支持php
# vi /usr/local/apache2/conf/httpd.conf #编辑apache配置文件
# 在LoadModule php5_module modules/libphp5.so这一行下面添加、
# AddType application/x-httpd-php .php (注意：php .php这个点前面有一个空格)
# echo "AddType application/x-httpd-php .php" >> /etc/httpd/conf/httpd.conf