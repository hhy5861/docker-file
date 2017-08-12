#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run \
    -d \
    --name="b00gizm-php-fpm" \
    -p 9001:9000 \
    -v ${DIR}/../app:/app \
    hub.oapol.com/php-nginx:latest \
    php5-fpm --nodaemonize

docker run \
    -d \
    --name="b00gizm-php-nginx" \
    --link="b00gizm-php-fpm":"php-fpm-svc" \
    -p 8084:80 \
    -v ${DIR}/../app:/app \
    hub.oapol.com/php-nginx:latest \
    nginx
