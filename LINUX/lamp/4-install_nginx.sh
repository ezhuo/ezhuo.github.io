#!/bin/bash

# ------------------------------------
cur_dir=$(cd `dirname $0`; pwd)


# 更新 yum 源
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

# 安装
yum install -y nginx

# 复制配置文件到配置目录
cp -r ${cur_dir}/conf.d.nginx/* /etc/nginx/conf.d/
cp -r ${cur_dir}/conf.d.nginx/fastcgi_params /etc/nginx/fastcgi_params
rm -rf /etc/nginx/conf.d/fastcgi_params

# 启动
systemctl start nginx.service