#!/bin/bash

pack_ver=httpd-2.4.25
# ------------------------------------
cur_dir=$(cd `dirname $0`; pwd)
package_dir=${cur_dir}/package
amp_dir=${cur_dir}/amp
# ------------------------------------
echo "httpd安装开始..."
service httpd stop

rm -rf /usr/local/apache2
rm -rf /etc/init.d/httpd
mkdir -p /usr/local/apache2 #创建安装目录

cd $amp_dir
rm -rf $pack_ver
tar -zvxf ${pack_ver}.tar.gz
cd $pack_ver

echo "httpd开始编译..."
./configure \
--prefix=/usr/local/apache2 \
--with-apr=/usr/local/apr \
--with-apr-util=/usr/local/apr-util \
--with-ssl \
--enable-ssl \
--enable-module=so \
--enable-rewrite \
--enable-cgid \
--enable-cgi

make #编译
make install #安装

# --开始配置----------------------------------
echo "httpd开始配置..."
rm -rf /etc/httpd
ln -s /usr/local/apache2 /etc/httpd

echo "export PATH=\$PATH:/usr/local/apache2/bin" >> /etc/profile
#把apache加入到系统启动
rm -rf /etc/rc.d/init.d/httpd
cp /usr/local/apache2/bin/apachectl /etc/rc.d/init.d/httpd 
echo "#chkconfig:2345 10 90" >> /etc/init.d/httpd
echo "#descrption:Activates/Deactivates Apache Web Server" >> /etc/init.d/httpd

mkdir -p /etc/httpd/conf.modules.d
cp -r ${cur_dir}/conf.modules.d/* /etc/httpd/conf.modules.d/
echo "Include conf.modules.d/*.conf" >> /etc/httpd/conf/httpd.conf

mkdir -p /etc/httpd/conf.d
cp -r ${cur_dir}/conf.d/* /etc/httpd/conf.d/
echo "IncludeOptional conf.d/*.conf" >> /etc/httpd/conf/httpd.conf

chown daemon.daemon -R /usr/local/apache2/htdocs #更改目录所有者
chmod 700 /usr/local/apache2/htdocs -R #更改apache网站目录权限

source /etc/profile
chkconfig httpd on #设置开机启动

echo "httpd安装结束."
echo "httpd正在启动..."
/etc/init.d/httpd restart
service httpd restart

# ---------------------------------------------

# vi /usr/local/apache2/conf/httpd.conf #编辑配置文件
# 找到：#ServerName www.example.com:80
# 修改为：ServerName localhost:80
# 找到：DirectoryIndex index.html
# 修改为：DirectoryIndex index.html index.php
# 找到：Options Indexes FollowSymLinks
# 修改为：Options FollowSymLinks #不显示目录结构
# 找到AllowOverride None
# 修改为：AllowOverride All #开启apache支持伪静态，有两处都做修改
# LoadModule rewrite_module modules/mod_rewrite.so #取消前面的注释，开启apache支持伪静态
# echo "ServerName localhost:80" >> /etc/httpd/conf/httpd.conf