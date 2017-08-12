FROM    hub.oapol.com/centos:7.2.1511

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

RUN cd /etc/yum.repos.d/ && curl -O http://mirrors.aliyun.com/repo/Centos-7.repo \
    && curl -O http://mirrors.aliyun.com/repo/epel-7.repo

RUN yum install -y gcc gcc-c++ make libxml++-devel openssl-devel libxslt-devel supervisor autoconf \
    libmemcached-devel curl curl-devel

RUN groupadd www && useradd -g www www -s /bin/false && mkdir /tools && mkdir /app

ADD zlib-1.2.8.tar.gz /tools/
ADD tengine-2.1.2.tar.gz /tools/
ADD pcre-8.38.tar.gz /tools/
ADD openssl-1.0.1h.tar.gz /tools/

RUN cd /tools/zlib-1.2.8 && ./configure && make && make install
RUN cd /tools/pcre-8.38 && ./configure && make && make install
RUN cd /tools/openssl-1.0.1h && ./config && make && make install

RUN cd /tools/tengine-2.1.2 && ./configure \
--prefix=/usr/local/nginx \
--user=www \
--group=www \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--with-openssl=/tools/openssl-1.0.1h \
--with-zlib=/tools/zlib-1.2.8 \
--with-pcre=/tools/pcre-8.38 && \
make && make install

RUN mkdir -p /usr/local/nginx/conf/vhosts && mkdir -p /var/log/nginx

ADD conf/nginx.conf.default /usr/local/nginx/conf/nginx.conf
ADD conf/localhost.conf.default /usr/local/nginx/conf/vhosts/localhost.conf

RUN chown -R www:www /app 
RUN chown -R www:www /var/log/nginx 
ADD src/index.php /app/index.php

ADD conf/supervisord.conf /etc/supervisord.conf
ADD scripts/start.sh /start.sh
RUN yum clean all && chmod 755 /start.sh && rm -rf /tools

VOLUME ["/app","/var/log/nginx"]

EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]