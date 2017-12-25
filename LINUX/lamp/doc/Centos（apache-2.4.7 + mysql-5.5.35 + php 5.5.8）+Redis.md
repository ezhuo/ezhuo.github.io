Centos编译安装 LAMP （apache-2.4.7 + mysql-5.5.35 + php 5.5.8）+ Redis
软件源代码包存放位置：/usr/local/src
源码包编译安装位置：/usr/local/软件名字

修改源：

1、进入存放源配置的文件夹
cd /etc/yum.repos.d

2、备份默认源
mv ./CentOS-Base.repo ./CentOS-Base.repo.bak

3、使用wget下载163的源
wget http://mirrors.163.com/.help/CentOS-Base-163.repo

4、把下载下来的文件CentOS-Base-163.repo设置为默认源
mv CentOS-Base-163.repo CentOS-Base.repo

安装git(关于git常用命令见  http://www.cnblogs.com/whoamme/p/3531387.html)
yum install git
　　
#一、关闭SELINUX
　　vi /etc/selinux/config
　　#SELINUX=enforcing #注释掉
　　#SELINUXTYPE=targeted #注释掉
　　SELINUX=disabled #增加
　　:wq 保存，关闭
　　shutdown -r now #重启系统
 
#二、下载软件包

　　1、下载apache
　　wget  apache.dataguru.cn/httpd/httpd-2.4.7.tar.gz

　　2、下载mysql
　　wget http://mirrors.sohu.com/mysql/MySQL-5.5/mysql-5.5.35.tar.gz

　　3、下载php 5.5.8
　　wget cn2.php.net/get/php-5.5.8.tar.gz/from/this/mirror

　　4、下载cmake(MySQL编译工具)
　　wget  http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz

　　5、下载libmcrypt(PHPlibmcrypt模块)
　　wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz

　　6、下载apr(Apache库文件)
　　wget mirror.bit.edu.cn/apache/apr/apr-1.5.0.tar.gz

　　7、下载apr-util(Apache库文件)
　　wget mirror.bit.edu.cn/apache/apr/apr-util-1.5.3.tar.gz

#三、安装

预备：编译工具及库文件（使用CentOS yum命令安装）
yum install make apr* autoconf automake gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd kernel keyutils patch perl kernel-headers compat* mpfr cpp glibc libgomp libstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel libsepol-devel libselinux-devel krb5-devel zlib-devel libXpm* freetype libjpeg* libpng* php-common php-gd ncurses* libtool* libxml2 libxml2-devel patch

1、安装libmcrypt

　　cd /usr/local/src
　　tar zxvf libmcrypt-2.5.7.tar.gz #解压
　　cd libmcrypt-2.5.7 #进入目录
　　./configure #配置
　　make #编译
　　make install #安装

　　2、安装cmake

　　cd /usr/local/src
　　tar zxvf cmake-2.8.7.tar.gz
　　cd cmake-2.8.7
　　./configure
　　make #编译
　　make install #安装

　　3、安装apr

    首先卸载旧版本 
　　yum remove apr-util-devel apr apr-util-mysql apr-docs apr-devel apr-util apr-util-docs
　　cd /usr/local/src
　　tar zxvf apr-1.5.0.tar.gz
　　cd apr-1.5.0
　　./configure --prefix=/usr/local/apr
　　make
　　make install

　　4、安装apr-util

　　tar zxvf apr-util-1.5.3.tar.gz
　　cd apr-util-1.5.3
　　./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config
　　make
　　make install

　　5、安装mysql

　　回到cmake目录，删除cmakecache.txt文件

　　rm -f CMakeCache.txt
　　groupadd mysql #添加mysql组
　　useradd -g mysql mysql -s /bin/false #创建用户mysql并加入到mysql组，不允许mysql用户直接登录系统
　　mkdir -p /data/mysql #创建MySQL数据库存放目录
　　chown -R mysql:mysql /data/mysql #设置MySQL数据库目录权限
　　mkdir -p /usr/local/mysql #创建MySQL安装目录
　　cd /usr/local/src
　　tar zxvf mysql-5.5.21.tar.gz #解压
　　cd mysql-5.5.21　　
　　cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc #配置
　　make #编译
　　make install #安装

　　cd /usr/local/mysql
　　cp ./support-files/my-huge.cnf /etc/my.cnf #拷贝配置文件(注意：/etc目录下面默认有一个my.cnf，直接覆盖即可)
　　vi /etc/my.cnf #编辑配置文件,在 [mysqld] 部分增加
　　datadir = /data/mysql #添加MySQL数据库路径
　　./scripts/mysql_install_db --user=mysql #生成mysql系统数据库
　　cp ./support-files/mysql.server /etc/rc.d/init.d/mysqld #把Mysql加入系统启动
　　chmod 755 /etc/init.d/mysqld #增加执行权限
　　chkconfig mysqld on #加入开机启动
　　vi /etc/rc.d/init.d/mysqld #编辑
　　basedir = /usr/local/mysql #MySQL程序安装路径
　　datadir = /data/mysql #MySQl数据库存放目录
　　service mysqld start #启动
　　vi /etc/profile #把mysql服务加入系统环境变量：在最后添加下面这一行
　　export PATH=$PATH:/usr/local/mysql/bin
　　下面这两行把myslq的库文件链接到系统默认的位置，这样你在编译类似PHP等软件时可以不用指定mysql的库文件地址。

　　ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
　　ln -s /usr/local/mysql/include/mysql /usr/include/mysql

　　shutdown -r now #需要重启系统，等待系统重新启动之后继续在终端命令行下面操作
　　mysql_secure_installation #设置Mysql密码

　　根据提示按Y 回车输入2次密码

　　或者直接修改密码/usr/local/mysql/bin/mysqladmin -u root -p password "123456" #修改密码
　　service mysqld restart #重启
　　到此，mysql安装完成!

 

 6、安装apache2

    cd /usr/local/src
　　tar -zvxf httpd-2.4.1.tar.gz
　　cd httpd-2.4.1
　　mkdir -p /usr/local/apache2 #创建安装目录
　　./configure --prefix=/usr/local/apache2 --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util --with-ssl --enable-ssl --enable-module=so --enable-rewrite --enable-cgid --enable-cgi #配置
　　make #编译
　　make install #安装
　　/usr/local/apache2/bin/apachectl -k start #启动
　　vi /usr/local/apache2/conf/httpd.conf #编辑配置文件
　　找到：#ServerName www.example.com:80
　　修改为：ServerName www.osyunwei.com:80
　　找到：DirectoryIndex index.html
　　修改为：DirectoryIndex index.html index.php
　　找到：Options Indexes FollowSymLinks
　　修改为：Options FollowSymLinks #不显示目录结构
　　找到AllowOverride None
　　修改为：AllowOverride All #开启apache支持伪静态，有两处都做修改
　　LoadModule rewrite_module modules/mod_rewrite.so #取消前面的注释，开启apache支持伪静态
　　vi /etc/profile #添加apache服务系统环境变量
　　在最后添加下面这一行
　　export PATH=$PATH:/usr/local/apache2/bin
　　cp /usr/local/apache2/bin/apachectl /etc/rc.d/init.d/httpd #把apache加入到系统启动
　　vi /etc/init.d/httpd #编辑文件
　　在#!/bin/sh下面添加以下两行

　　#chkconfig:2345 10 90
　　#descrption:Activates/Deactivates Apache Web Server
　　chown daemon.daemon -R /usr/local/apache2/htdocs #更改目录所有者
　　chmod 700 /usr/local/apache2/htdocs -R #更改apache网站目录权限
　　chkconfig httpd on #设置开机启动
　　/etc/init.d/httpd start
　　service httpd restart

7、安装PHP5

    cd /usr/local/src
　　tar -zvxf php-5.3.10.tar.gz
　　cd php-5.3.10
　　mkdir -p /usr/local/php5 #建立php安装目录
　  ./configure --prefix=/usr/local/php5 --with-config-file-path=/usr/local/php5/etc --with-apxs2=/usr/local/apache2/bin/apxs --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-gd --with-iconv --with-freetype --with-jpeg --with-png --with-zlib --with-libxml --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-force-cgi-redirect --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-pear --with-gettext --with-mime-magic --enable-suhosin --enable-session --with-mcrypt --with-jpeg --enable-fpm   #配置
　　make #编译
　　make install #安装
　　mkdir /usr/local/php5/etc
　　cp php.ini-production /usr/local/php5/etc/php.ini #复制php配置文件到安装目录
　　rm -rf /etc/php.ini #删除系统自带的配置文件
　　ln -s /usr/local/php5/etc/php.ini /etc/php.ini #创建配置文件软链接
　　vi /usr/local/php5/etc/php.ini #编辑
　　找到：;open_basedir =
　　修改为：open_basedir = .:/tmp/ #防止php木马跨站，重要!!
　　找到：disable_functions =
　　修改为：disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,
ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,
disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,
posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, 
posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

　　#列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。
　　找到：;date.timezone =
　　修改为：date.timezone = PRC
　　找到：expose_php = On
　　修改为：expose_php = OFF #禁止显示php版本的信息
　　找到：display_errors = On
　　修改为：display_errors = OFF #关闭错误提示

　　配置apache支持php

　　vi /usr/local/apache2/conf/httpd.conf #编辑apache配置文件
　　在LoadModule php5_module modules/libphp5.so这一行下面添加、
　　AddType application/x-httpd-php .php (注意：php .php这个点前面有一个空格)
　　service httpd restart #重启apache
　　service mysqld restart #重启mysql

至此，基本的LAMP环境编译完成，可以写一个测试文件测试一下。
   

四、安装redis服务以及php redis扩展

　　1、安装tcl　　
　　　　wget -c http://prdownloads.sourceforge.net/tcl/tcl8.6.1-src.tar.gz
　　　　tar -zxvf tcl8.6.1-src.tar.gz
　　　　cd tcl8.6.1/unix
　　　　./configure
　　　　make && make install

　　2、安装redis服务　　　　
　　　　wget -c http://download.redis.io/releases/redis-2.6.16.tar.gz
　　　　tar -zxvf redis-2.6.16.tar.gz
　　　　cd redis-2.6.16
　　　　make（如果是linux32位，使用 make CFLAGS="-march=i686"）
　　　　make test
　　　　make install

　　3、启动redis服务:

　　　　vim /usr/local/src/redis-2.6.16/redis.conf //将daemonize 设置为yes
　　　　/usr/local/bin/redis-server /usr/local/src/redis-2.6.16/redis.conf
　　　　ps aux|grep redis  查看进程
　　　　
　　4、使用 redis-cli 连接，当然也可以使用telnet
　　测试：
　　　　[root@localhost redis-2.6.16]# redis-cli
　　　　redis 127.0.0.1:6379> set name silenceper
　　　　OK
　　　　redis 127.0.0.1:6379> get name
　　　　"silenceper"
　　　　redis 127.0.0.1:6379>
　　　　
　　　　关闭 可以使用命令redis-cli shutdown
　　　　redis-cli –help 查看更多选项

　　　　关于redis 2.4 配置文件中文说明说明:
　　　　https://github.com/silenceper/my/blob/master/config/redis2.4.chinese
　　　　redis 命令手册：
　　　　http://redis.readthedocs.org/en/latest/

　　5、使用phpRedisAdmin 管理redis 　　

　　　　git clone https://github.com/ErikDubbelboer/phpRedisAdmin.git　　　　
　　　　将程序放到apache 的源代码目录中，配置好vhost，访问后发现是白屏，测试vhost是可以正常访问的。
　　　　查看了一下includes/common.inc.php源代码：
　　　　require dirname(__FILE__) . '/../vendor/autoload.php';
　　　　少了一个vendor目录，问了一下三金锅，三金锅说此程序依赖predis而不是redis的php扩展，需要下载predis放到vendor目录下。。。
　　　   
　　　　cd phpRedisAdmin
　　　　git clone https://github.com/nrk/predis.git  vendor
　　　　
 　　
　　6、安装php redis扩展　　　
　　　　
　　　　git clone git://github.com/nicolasff/phpredis.git
　　　　cd phpredis 
　　　　/usr/local/php5/bin/phpize
　　　　./configure --with-php-config=/usr/local/php5/bin/php-config --enable-redis 
 　　　  make
　　　　make install
 
 　　　 配置php.ini
　　　  vim /usr/local/php5/etc/php.ini
　　　  　　
　　　  修改  extension_dir = "/usr/local/php5/lib/php/extensions/no-debug-zts-20121212/"
　　　  添加 extension=redis.so                      //开启redis扩展  
 　　
　　　  重启apache服务器，/usr/local/php5/bin/php -m
          可以看到有了redis 扩展了