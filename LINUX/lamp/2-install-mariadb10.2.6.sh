#!/bin/bash

# 没有经过测试 log:20180115,毋用
pack_ver=mariadb-10.2.12
# ------------------------------------
cur_dir=$(cd `dirname $0`; pwd)
package_dir=${cur_dir}/package
amp_dir=${cur_dir}/amp

# ------------------------------------
echo "MYSQL安装开始..."
cd $amp_dir
rm -rf ${package_dir}/cmake-3.6.2/CMakeCache.txt
groupdel mysql
userdel mysql
groupadd mysql #添加mysql组
useradd -g mysql mysql -s /bin/false #创建用户mysql并加入到mysql组，不允许mysql用户直接登录系统

rm -rf /home/mysql
rm -rf /usr/local/mysql
rm -rf /var/lib/mysql
mkdir -p /home/mysql/data #创建MySQL数据库存放目录
mkdir -p /usr/local/mysql #创建MySQL安装目录
mkdir -p /var/lib/mysql
chown -R mysql:mysql /usr/local/mysql
chown -R mysql:mysql /home/mysql/data #设置MySQL数据库目录权限
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /home/mysql/data

# ------------------------------------
cd $package_dir
rm -rf boost_1_59_0
tar zxvf boost_1_59_0.tar.gz

cd $amp_dir
rm -rf $pack_ver
tar zxvf ${pack_ver}.tar.gz
cd $pack_ver

echo "mariadb开始编译..."
cmake \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DSYSCONFDIR=/etc \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/var/lib/mysql/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_BOOST=${package_dir}/boost_1_59_0 #-enable-thread-safe-client

make #编译
make install #安装

# ------------------------------------
echo "MYSQL开始配置..."
#拷贝配置文件(注意：/etc目录下面默认有一个my.cnf，直接覆盖即可)
cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
echo "datadir=/home/mysql/data" >> /etc/my.cnf

#初始化DB命令
/usr/local/mysql/bin/mysqld --initialize
ln -s /home/mysql/data /usr/local/mysql/data

cp /usr/local/mysql/support-files/mysql.server /etc/rc.d/init.d/mysqld #把Mysql加入系统启动
chmod 755 /etc/init.d/mysqld #增加执行权限
chkconfig mysqld on #加入开机启动

#vi /etc/rc.d/init.d/mysqld #编辑
echo "basedir=/usr/local/mysql" >> /etc/rc.d/init.d/mysqld
echo "datadir=/home/mysql/data" >> /etc/rc.d/init.d/mysqld

# 设置权限
chown -R mysql:mysql /home/mysql/data
chmod -R 755 /home/mysql/data
#下面这两行把myslq的库文件链接到系统默认的位置，这样你在编译类似PHP等软件时可以不用指定mysql的库文件地址。
#ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
ln -s /usr/local/mysql/lib/libmysqlclient.a /usr/local/mysql/lib/libmysqlclient_r.a
ln -s /usr/local/mysql/lib/libmysqlclient.so /usr/local/mysql/lib/libmysqlclient_r.so

#centos 7的systemctl 管理
#\cp -rf ${cur_dir}/mysql/mysql.service /etc/systemd/system/mysql.service 
#ln -sf /etc/systemd/system/mysql.service /etc/systemd/system/mysqld.service 

#修改密码
/usr/local/mysql/bin/mysqladmin -u root -p password "123456"

#vi /etc/profile #把mysql服务加入系统环境变量：在最后添加下面这一行
echo "export PATH=\$PATH:/usr/local/mysql/bin" >> /etc/profile
source /etc/profile
echo "MYSQL安装结束."

#mysql_secure_installation #设置Mysql密码
#pkill mysqld