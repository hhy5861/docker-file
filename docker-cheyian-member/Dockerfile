FROM hub.oapol.com/cheyian-php-nginx:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD mobile.conf.default /etc/nginx/conf.d/member.test.com.conf
ADD mobile.conf.default /etc/nginx/conf.d/member.demo.com.conf
ADD mobile.conf.default /etc/nginx/conf.d/member.prod.com.conf

RUN echo '[program:environment]\ncommand=/usr/local/bin/php /www/init' >> /etc/supervisord.conf && \
    sed -i 's/test.oapol.com/demo.oapol.com/g' /etc/nginx/conf.d/member.demo.com.conf && \
    sed -i 's/test.oapol.com/cheyian.com/g' /etc/nginx/conf.d/member.prod.com.conf \
    && rm -rf /www/* \
    && git clone http://mike:tlslpc586@gitlab.oapol.com/base/system-user.git -b master /www && \
    chown -R www-data.www-data /www && \
    chmod +x /www/init