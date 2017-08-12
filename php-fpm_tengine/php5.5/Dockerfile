FROM    hub.oapol.com/centos:7.2.1511

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

RUN cd /etc/yum.repos.d/ && curl -O http://mirrors.aliyun.com/repo/Centos-7.repo \
    && curl -O http://mirrors.aliyun.com/repo/epel-7.repo

RUN yum install -y gcc gcc-c++ make libxml++-devel openssl-devel libxslt-devel supervisor autoconf \
    libmemcached-devel curl curl-devel

RUN groupadd www && useradd -g www www -s /bin/false && mkdir /tools

ADD tools/jpegsrc.v9b.tar.gz /tools/
ADD tools/libmcrypt-2.5.7.tar.gz /tools/
ADD tools/zlib-1.2.8.tar.gz /tools/
ADD tools/freetype-2.6.3.tar.gz /tools/
ADD tools/libpng-1.6.21.tar.xz /tools/
ADD tools/php-5.5.34.tar.gz /tools/
ADD tools/redis-2.2.7.tgz /tools/
ADD tools/memcached-2.2.0.tgz /tools/
ADD tools/igbinary-1.2.1.tar.gz /tools/

RUN cd /tools/freetype-2.6.3 && ./configure && make && make install
RUN cd /tools/jpeg-9b && ./configure && make && make install
RUN cd /tools/libmcrypt-2.5.7 && ./configure && make && make install
RUN cd /tools/libpng-1.6.21 && ./configure && make && make install
RUN cd /tools/zlib-1.2.8 && ./configure && make && make install

RUN cd /tools/php-5.5.34 \
&& ./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-config-file-scan-dir=/usr/local/php/etc/conf.d \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--with-pear \
--with-curl \
--with-gd \
--with-jpeg-dir=/tools/jpeg-9b \
--with-png-dir=/tools/libpng-1.6.21 \
--with-zlib-dir=/tools/zlib-1.2.8 \
--with-freetype-dir=/tools/freetype-2.6.3 \
--with-iconv \
--with-mcrypt=/tools/libmcrypt-2.5.7 \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-openssl \
--with-xsl \
--enable-sockets \
--enable-soap \
--enable-mbstring \
--enable-gd-native-ttf \
--enable-zip \
--enable-xml \
--enable-bcmath \
--enable-calendar \
--enable-shmop \
--enable-dba \
--enable-wddx \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-opcache \
--enable-pcntl \
--enable-maintainer-zts \
--disable-debug && \
make && make install

RUN cd /tools/redis-2.2.7 && /usr/local/php/bin/phpize && \
    ./configure --enable-redis --with-php-config=/usr/local/php/bin/php-config && \
    make && make install

RUN cd /tools/memcached-2.2.0 && /usr/local/php/bin/phpize && \
    ./configure --enable-memcached --with-php-config=/usr/local/php/bin/php-config && \
    make && make install

RUN cd /tools/igbinary-1.2.1 && /usr/local/php/bin/phpize && \
    ./configure CFLAGS="-O2 -g" --enable-igbinary --with-php-config=/usr/local/php/bin/php-config && \
    make && make install

ADD conf/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
ADD conf/php.ini-production /usr/local/php/etc/php.ini

RUN mkdir -p /var/log/php && chown -R www:www /var/log/php

ADD conf/supervisord.conf /etc/supervisord.conf
ADD scripts/start.sh /start.sh
RUN yum clean all && chmod 755 /start.sh && rm -rf /tools

VOLUME ["/app","/var/log/php"]

EXPOSE 9000

CMD ["/bin/bash", "/start.sh"]