# 日志：2016-12-28号更新

* 1. 将sh1.0 复制到 /usr/local/src 目录下
* 2. 解压 sh1.0
* 3. 按顺序执行
* 4. 安装完毕后，更改MYSQL 密码

```bash
1、修改 /etc/my.cnf，在 [mysqld] 小节下添加一行：
skip-grant-tables=1
service mysqld restart
mysql
use mysql;
update user set authentication_string = password('root@root'), password_expired = 'N', password_last_changed = now() where user = 'root';
修改/etc/my.cnf 注释：skip-grant-tables=1
service mysqld restart
MySQL 5.7 在初始安装后（CentOS7 操作系统）会生成随机初始密码，
并在 /var/log/mysqld.log 中有记录，可以通过 cat 命令查看，找 password 关键字
```
*   安装完成后，有时会找不到服务