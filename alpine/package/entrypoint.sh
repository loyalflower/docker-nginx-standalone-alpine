#!/bin/sh

BASEDIR=$(cd "$(dirname "$0")"; pwd)

# 覆盖默认的nginx配置
if  [ "${NGINX_SERVER_CONFIG}" != "" ]
then
    ln -s ${NGINX_SERVER_CONFIG}/nginx.conf /usr/local/nginx/conf/conf.d/default.conf
fi

# 只替换根目录
if [ "${WWW_ROOT}" != "" ]
then
    sed -i "s/\/var\/www/${WWW_ROOT//\//\\/}/g" /usr/local/nginx/conf/conf.d/default.conf
fi

if [ "${PHP_FPM_SOCKET}" != "" ]
then
    sed -i "s/fastcgi_pass 127.0.0.1:9000;/fastcgi_pass ${PHP_FPM_SOCKET//\//\\/};/g" /usr/local/nginx/conf/conf.d/default.conf
fi


if [ "${1}" != "" ]; then
	exec "$@"
else
    ${BASEDIR}/nginx-portable start
fi
