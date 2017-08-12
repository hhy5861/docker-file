FROM richarvey/nginx-php-fpm:latest

MAINTAINER Mike "hhy5861@gmail.com"

RUN docker-php-ext-configure bcmath \
    && docker-php-ext-configure pcntl \
    && docker-php-ext-configure sockets \
    && docker-php-ext-install bcmath pcntl sockets

ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev
RUN apk add --update libmemcached-libs zlib
RUN apk add --update --virtual .phpize-deps $PHPIZE_DEPS \
    && apk add --update --virtual .memcached-deps $MEMCACHED_DEPS \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && apk add dcron \
    && rm -rf /var/cache/apk/*

RUN pecl install mongodb \
#   && pecl install redis \
    && pecl install xdebug \
    && docker-php-ext-enable mongodb \
    && mkdir -p /var/log/cron \
    && mkdir -m 0644 -p /var/spool/cron/crontabs \
    && touch /var/log/cron/cron.log \
    && mkdir -m 0644 -p /etc/cron.d

RUN echo "[program:nginx]" >> /etc/supervisord.conf \
	&& echo "command=crond -s /var/spool/cron/crontabs -f -L /var/log/cron/cron.log "$@"" >> /etc/supervisord.conf
