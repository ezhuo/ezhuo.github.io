

# 全局加载JS

* 在 angular-cli.json 中的 styles 和 scripts 添加相关文件即可。但编译时该文件是以 src目录为起点，所以要以../node_modules 。
* 编译过后将会生成 script.****.js 和 style.****.js

# 模块中加JS

* 在NgModule加载三方JS后，使用import * as $ from 'jquery' 导入后。
* 编译过后，三方包将会直接加入到该模块中 