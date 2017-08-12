FROM hub.oapol.com/cheyian-php-nginx:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD mobile.dev.conf.default /etc/nginx/conf.d/mobile.dev.com.conf
ADD mobile.dev.conf.default /etc/nginx/conf.d/mobile.demo.com.conf
ADD mobile.dev.conf.default /etc/nginx/conf.d/mobile.online.com.conf

RUN echo '[program:environment]\ncommand=/usr/local/bin/php /www/init' >> /etc/supervisord.conf && \
    sed -i 's/test.oapol.com/demo.oapol.com/g' /etc/nginx/conf.d/mobile.demo.com.conf && \
    sed -i 's/test.oapol.com/cheyian.com/g' /etc/nginx/conf.d/mobile.online.com.conf \
    && rm -rf /www/* \
    && git clone http://mike:tlslpc586@gitlab.oapol.com/base/cheyian-qixiubao.git -b master /www && \
    chown -R www-data.www-data /www && \
    chmod +x /www/init