#!/bin/bash

cur_dir=$(cd `dirname $0`; pwd)
package_dir=${cur_dir}/package

#------------------------------

# rpm -e --allmatches mariadb* mysql MySQL-python perl-DBD-MySQL dovecot exim qt-MySQL perl-DBD-MySQL dovecot qt-MySQL mysql-server mysql-connector-odbc php-mysql mysql-bench libdbi-dbd-mysql mysql-devel-5.0.77-3.el5 httpd php mod_auth_mysql mailman squirrelmail php-pdo php-common php-mbstring php-cli

yum remove -y mariadb* mysql MySQL-python perl-DBD-MySQL dovecot exim qt-MySQL perl-DBD-MySQL dovecot qt-MySQL mysql-server mysql-connector-odbc php-mysql mysql-bench libdbi-dbd-mysql mysql-devel-5.0.77-3.el5 httpd php mod_auth_mysql mailman squirrelmail php-pdo php-common php-mbstring php-cli
yum install -y make autoconf automake gcc gcc-c++ zlib-devel openssl openssl-devel pcre pcre-devel keyutils patch perl perl-Data-Dumper kernel kernel-headers mpfr cpp glibc glibc-devel libgomp libstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel libsepol-devel libselinux-devel krb5 krb5-devel zlib-devel
yum install -y freetype freetype-devel php-common php-gd compat* ncurses* libtool* libpng* libXpm* libjpeg*
yum install -y libxml2 libxml2-devel patch glib2 glib2-devel bzip2 bzip2-devel libjpeg libjpeg-devel libpng libpng-devel  ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel  openldap openldap-devel nss_ldap openldap-clients openldap-servers libcurl.x86_64 libcurl-devel.x86_64

yum remove -y apr-util-devel apr apr-util-mysql apr-docs apr-devel apr-util apr-util-docs

# yum -y install apr* cmake boost boost-doc boost-devel
# yum -y install gcc gcc-c++  make zlib zlib-devel pcre pcre-devel  libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers

# 安装常用的组件
yum install -y net-tools telnet htop

# ------------------------------------
cd $package_dir
rm -rf libmcrypt-2.5.8
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure
make
make install

# ------------------------------------
cd $package_dir
rm -rf cmake-3.6.2
tar zxvf cmake-3.6.2.tar.gz
cd cmake-3.6.2
./configure
make
make install

# --------------------------------
cd $package_dir
rm -rf apr-1.5.2
tar zxvf apr-1.5.2.tar.gz
cd apr-1.5.2
./configure --prefix=/usr/local/apr
make
make install

# --------------------------------
cd $package_dir
rm -rf apr-util-1.5.4
tar zxvf apr-util-1.5.4.tar.gz
cd apr-util-1.5.4
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config
make
make install

# --------------------------------
yum install -y pcre pcre-devel libjpeg libjpeg-devel libpng libpng-devel libXpm-devel.x86_64

cd $package_dir
rm -rf libgd-2.2.2
tar zxvf libgd-2.2.2.tar.gz
cd libgd-2.2.2
./configure --prefix=/usr/local/gd2
make
make install