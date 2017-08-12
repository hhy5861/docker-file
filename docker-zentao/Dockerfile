FROM hub.oapol.com/php-tengine:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD pm.oapol.com.conf.default /usr/local/nginx/conf/vhosts/pm.oapol.com.conf
ADD ./zentaopms /www
ADD ./php.ini-production  /usr/local/php/etc/php.ini

VOLUME ["/www/config","/www/www/data"]

RUN chown -R www.www /www && touch /www/www/reset_5775dc078ebb9.txt