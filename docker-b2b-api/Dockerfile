FROM hub.oapol.com/cheyian-php-nginx:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD nginx.conf.default /etc/nginx/conf.d/test.nginx.com.conf
ADD nginx.conf.default /etc/nginx/conf.d/demo.nginx.com.conf
ADD nginx.conf.default /etc/nginx/conf.d/prod.nginx.com.conf

RUN echo '[program:environment]\ncommand=/usr/local/bin/php /www/init' >> /etc/supervisord.conf && \
    sed -i 's/test.oapol.com/demo.oapol.com/g' /etc/nginx/conf.d/demo.nginx.com.conf && \
    sed -i 's/test.oapol.com/cheyian.com/g' /etc/nginx/conf.d/prod.nginx.com.conf \
    && rm -rf /www/* \
    && git clone http://mike:tlslpc586@gitlab.oapol.com/b2b/cheyian-b2b.git -b master /www && \
    chown -R www-data.www-data /www && \
    chmod +x /www/init