# 绿色版的nginx
FROM debian:stretch-slim

LABEL maintainer="NGINX Docker <zengwanzhong@movee.cn>"

ENV PCRE_VER 8.42
ENV ZLIB_VER 1.2.11

COPY package /usr/local/nginx

WORKDIR /usr/local/nginx

RUN cp /usr/local/nginx/etc/apt/sources.list /etc/apt/sources.list \
    && rm -r /usr/local/nginx/etc \
	# 安装编译依赖
	&& apt-get update \
	# 安装编译依赖
	&& apt-get install -y --no-install-recommends \ 
        autoconf file g++ gcc libc-dev make wget \
    # nginx pcre依赖
    && cd depends \
    # && wget ftp://ftp.pcre.org/pub/pcre/pcre-${PCRE_VER}.tar.gz \
    && tar -zxf pcre-${PCRE_VER}.tar.gz \
    && rm -f pcre-${PCRE_VER}.tar.gz \
    && cd pcre-${PCRE_VER} \
    && ./configure \
    && make && make install \
    && cd .. \
    # zlib 依赖
    # && wget http://zlib.net/zlib-${ZLIB_VER}.tar.gz \
    && tar -zxf zlib-${ZLIB_VER}.tar.gz \
    && rm -f zlib-${ZLIB_VER}.tar.gz \
    && cd zlib-${ZLIB_VER} \
    && ./configure \
    && make && make install \
    && cd ../.. \
    && ./compile --latest \
    # 删除编译依赖
    && rm -rf depends/*

EXPOSE 80

ENTRYPOINT [ "/usr/local/nginx/entrypoint.sh" ]