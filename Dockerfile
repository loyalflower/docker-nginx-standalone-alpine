# 绿色版的nginx
FROM alpine:3.9

LABEL maintainer="NGINX Docker <zengwanzhong@movee.cn>"

ENV PCRE_VER 8.42
ENV ZLIB_VER 1.2.11

COPY package /usr/local/nginx

WORKDIR /usr/local/nginx

RUN set -xe \
	# 设置为国内镜像源
	&& cp /etc/apk/repositories /etc/apk/repositories.bak \
	&& echo "http://mirrors.aliyun.com/alpine/v3.9/main/" > /etc/apk/repositories \
	# 安装编译依赖
	&& apk add --no-cache --virtual .build-deps \ 
        autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c \
    # nginx pcre依赖
    && cd depends \
    && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VER}.tar.gz \
    && tar -zxf pcre-${PCRE_VER}.tar.gz \
    && rm -f pcre-${PCRE_VER}.tar.gz \
    && cd pcre-${PCRE_VER} \
    && ./configure \
    && make && make install \
    && cd .. \
    # zlib 依赖
    && wget http://zlib.net/zlib-${ZLIB_VER}.tar.gz \
    && tar -zxf zlib-${ZLIB_VER}.tar.gz \
    && rm -f zlib-${ZLIB_VER}.tar.gz \
    && cd zlib-${ZLIB_VER} \
    && ./configure \
    && make && make install \
    && cd ../.. \
    && ./compile --latest \
    # 减少镜像体积
	&& apk del .build-deps \
    # 删除编译依赖
    && rm -rf depends/*

EXPOSE 80

ENTRYPOINT [ "/usr/local/nginx/entrypoint.sh" ]