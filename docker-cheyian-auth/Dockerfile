FROM hub.oapol.com/cheyian-php-nginx:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD auth.test.conf.default /etc/nginx/conf.d/auth.test.oapol.com.conf
ADD auth.test.conf.default /etc/nginx/conf.d/auth.demo.oapol.com.conf
ADD auth.test.conf.default /etc/nginx/conf.d/auth.cheyian.com.conf
ADD env.sh /

RUN sed -i '$a\\n[program:environment]\ncommand=/env.sh' /etc/supervisord.conf && \
    sed -i 's/test.oapol.com/demo.oapol.com/g' /etc/nginx/conf.d/auth.demo.oapol.com.conf && \
    sed -i 's/test.oapol.com/cheyian.com/g' /etc/nginx/conf.d/auth.cheyian.com.conf && \
    sed -i 's/client_max_body_size 8m;/client_max_body_size 20m;/g' /etc/nginx/nginx.conf && \
    rm -rf /www/* && \
    git clone http://mike:tlslpc586@gitlab.oapol.com/base/cheyian-base.git -b master /www && \
    mkdir /www/app/runtime && \
    chown -R www-data.www-data /www && \
    chmod +x /env.sh
