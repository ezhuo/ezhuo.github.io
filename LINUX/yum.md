yum安装命令的使用方法

yum安装常用软件的命令
#yum check-update 
#yum remove 软件包名 
#yum install 软件包名 
#yum update 软件包名
 

yum命令常见使用方法 
yum -y install 包名（支持*） ：自动选择y，全自动
yum install 包名（支持*） ：手动选择y or n
yum remove 包名（不支持*）
rpm -ivh 包名（支持*）：安装rpm包
rpm -e 包名（不支持*）：卸载rpm包
 

参数

            	             
说明

            
check-update	显示可升级的软件包
clean	删除下载后的旧的header。和clean all相同
clean oldheaders	删除旧的headers
clean packages	删除下载后的软件包
info	显示可用软件包信息
info 软件包名	显示指定软件包信息
install 软件包名	安装指定软件包
list	显示可用软件包
list installed	显示安装了的软件包
list updates	显示可升级的软件包
provides 软件包名	显示软件包所包含的文件
remove 软件包名	删除制定的软件包，确认判定指定软件包的依存关系。 
             
search 关键字	利用关键字搜索软件包。搜索对象是，RPM文件名，Packager（包）， Dummary， Description的各型 
             
update	升级所有的可升级的软件包
update 软件包名	升级指定的软件包

yum -y install httpd 　 ← 在线安装httpd Apache服务器及相关组件
yum -y install php 　 ← 在线安装PHP
yum -y install mysql-server 　 ← 安装MySQL 
yum -y install php-mysql 　 ← 安装php-mysql



升级常用库文件 
yum -y install gcc gcc-c++ autoconf
yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel curl curl-devel ncurses ncurses-devel


安装make命令 
yum -y install make

安装vi 
yum -y install vim-enhanced
装完命令是vim，加个链接
ln -s /usr/bin/vim /bin/vi

安装locate 
yum -y install mlocate

安装patch 
yum -y install patch 

安装同步时间的 
yum install -y ntp
ntpdate ntp.api.bz

yum安装后的文件在哪里？ 
查看/etc/yum.conf
有个cachedir设置，默认是在/var/cache/yum
默认不保存下载的文件，安装完后就自动删除的。
要保存的话，修改keepcache，将0改为1。
即：
cachedir=/var/cache/yum
keepcache=1

 

什么是 yum？ 
　　yum 是 yellowdog updater modified 的缩写。yellowdog 是个 Linux 的 distribution，RH 将这种升级技术利用到自己的 distribution 形成了现在的 yum，感觉上 yum 和 apt 的原理类似，但是 apt 是编译代码，执行效率远高于使用 python 写成的 yum。这是 yum 的主页。
　　yum 的理念是使用一个中央仓库(repository)管理一部分甚至一个 distribution 的应用程式相互关系，根据计算出来的软件依赖关系进行相关的升级、安装、删除等等操作，减少了 Linux 用户一直头痛的 dependencies 的问题。这一点上，yum 和 apt 相同。apt 原为 debian 的 deb 类型软件管理所使用，但是现在也能用到 RH 门下的 rpm 了。
　　一般这类软件通过一个或多个配置文档描述对应的 repository 的网络地址，通过 http 或 ftp 协议在需要的时候从 repository 获得必要的信息，下载相关的软件包。这样，本地用户通过建立不同的 repository 的描述说明，在有 Internet 连接时就能方便进行系统的升级维护工作。另外，假如需要使用代理，能够用 http_proxy 和 ftp_proxy 这些 shell 里面标准环境变量的设定。
　　repository 是用 yum-arch 或 createrepo 命令创建的，也能够用别人已有的 repository 作为映像，这里部探讨怎样建立一个 repository。
　　yum 的基本操作
　　yum 的基本操作包括软件的安装(本地，网络)，升级(本地，网络)，卸载，另外更有一定的查询功能。
　　设定好了本地的 yum 之后，就能够很方便的进行安装(现在假设就用 fc5 自带的 yum 进行安装)，如我们需要安装虚拟机 bochs，能够使用
　　# yum install bochs
　　假如本地有相关的 rpm 文档，能够用
　　# yum localinstall ur.rpm
　　前者导致 yum 搜索现有 repository 中的数据(一般先会连接到这些 repository 下载更新数据)，假如发现有此软件，则会通过分析其 dependencies 然后下载并安装所需软件。
　　假如需要卸载，能够使用
　　# yum remove bochs
　　或
　　# yum erase bochs
　　这也会消解对应的 dependencies，如删除 firefox 会把 R 同时删掉，因为 R 依赖于 firefox
　　更新某个软件能够用
　　# yum update firefox
　　假如不带后面的程式名，将会升级任何能够升级的软件。过时的软件假如需要处理(如删掉)能够添加 --obsolete 参数，或使用 upgrade。假如需要更自动化一些的操作(避免回答一些问题)还能够增加一些参数，如
　　# yum -y upgrade
　　假如做完一次系统级的升级，将会下载大量 rpm 等等东西，这将占用较多的硬盘，能够使用
　　# yum clean packages
　　将相关的 rpm 文档删除，其他的一些有 headers, packages, cache, metadata, all
　　查看什么 rpm 提供某个程式能够使用
　　$ yum provides /bin/rpm
　　而使用
　　$ yum list rpm
　　会列出 rpm 相关的信息，而
　　$ yum list info
　　给出周详的说明，能够用
　　$ yum search rpm
　　获得一切能找到的和 rpm 相关的程式，搜索的对象是每个程式的描述部分。
　　更周详的参数说明请查阅相关的 man pages。在 yum-utils 里面能够找到叫 yumdownloader 的程式。使用他能够方便下载，如 srpm 等包
　　$ yumdownloader --source firefox