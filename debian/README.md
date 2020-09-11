# nginx 独立安装版
本镜像会将 nginx 编译安装，并打包在 /usr/local/nginx 目录下。

要使用该 nginx，只需要将 /usr/local/nginx 复制过去即可

[查看官方编译安装文档](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-nginx-dependencies)

## 特性
1. 不支持 openssl。即不支持 https 请求
2. 只支持 alpine 平台，更多平台有待测试，按理 debian 系列都支持
3. 支持 rewrite
4. 支持 zlib

## 基础镜像
alpine:3.9

## build 构建
make build tag=x.x.x  构建并自动上传

make dev-build 该命令会自动将创建的镜像命名为 nginx-standalone

## workdir
/usr/local/nginx

## entrypoint.sh
/usr/local/nginx/entrypoint.sh

## nginx 配置文件
主： /usr/local/nginx/conf/nginx.conf

站： /usr/local/nginx/conf/conf.d/default.conf。 默认站点目录 /var/www，默认将 php 请求转发到 127.0.0.1:9000

## nginx 默认站点目录
/var/www

## 环境变量
### NGINX_SERVER_CONFIG
自定义站点配置文件路径。会自动将 conf/conf.d/default.conf 替换为 ${NGINX_SERVER_CONFIG}/nginx.conf

### WWW_ROOT
仍然使用默认的站点配置，只修改站点根路径。即将默认的配置 root /var/www; 替换为 root ${WWW_ROOT};

### PHP_FPM_SOCKET
自定义 php-fpm 的访问连接，默认是 127.0.0.1:9000