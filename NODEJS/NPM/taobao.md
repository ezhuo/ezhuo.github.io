#  淘宝镜像
    请先使用以下命令，将npm 默认的URL设置为淘宝，不要使用cnpm，可能会引起包依赖出问题

## 设置淘宝镜像
    npm config set registry https://registry.npm.taobao.org
    npm config set disturl https://npm.taobao.org/dist

## 取消淘宝镜像
    编辑删除
    npm config edit 
    找到上面注册的两行删掉

    命令删除
    npm config delete registry
    npm config delete disturl