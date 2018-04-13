# 日志：2016-12-28号更新


* 1. 将sh1.0 复制到 /usr/local/src 目录下
* 2. 解压 sh1.0
* 3. 按顺序执行
* 4. 安装完毕后，更改MYSQL 密码

```bash
1、修改 /etc/my.cnf，在 [mysqld] 小节下添加一行：
sql_mode=NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
skip-grant-tables=1
保存退出后

service mysqld restart
mysql
use mysql;
update user set authentication_string = password('root@root'), password_expired = 'N', password_last_changed = now() where user = 'root';
修改/etc/my.cnf 注释：skip-grant-tables=1
service mysqld restart
MySQL 5.7 在初始安装后（CentOS7 操作系统）会生成随机初始密码，
并在 /var/log/mysqld.log 中有记录，可以通过 cat 命令查看，找 password 关键字
```

* 安装完成后，有时会找不到服务

```
请执行 source /etc/profile ，使所有的环境变量生效
```

* 请启用opcache服务

# BUG解决

* linux安装mysql出现Could NOT find Curses (missing CURSES_LIBRARY CURSES_INCLUDE_PATH)解决方法
```
编译 mysql5.6.22
出现以下错误提示：
— Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH)
CMake Error at cmake/readline.cmake:82 (MESSAGE):
Curses library not found.  Please install appropriate package,
remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.
Call Stack (most recent call first):
cmake/readline.cmake:126 (FIND_CURSES)
cmake/readline.cmake:216 (MYSQL_USE_BUNDLED_LIBEDIT)
CMakeLists.txt:250 (MYSQL_CHECK_READLINE)
— Configuring incomplete, errors occurred!
解决方法：
[root@localhost mysql-5.5.11]# rm CMakeCache.txt
[root@localhost mysql-5.5.11]# yum install ncurses-devel
Warning: Bison executable not found in PATH
— Configuring done
— Generating done
— Build files have been written to: /software/mysql-5.5.11
[root@localhost mysql-5.5.11]# yum install bison
[root@localhost mysql-5.5.11]# make && make install
编译完成。
```