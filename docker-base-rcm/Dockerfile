FROM registry.cn-shanghai.aliyuncs.com/kd/nginx-php-fpm:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ENV CRON_VERSION 1.0.0
ENV CRON_OS linux
ENV CRON_ARCH amd64
ENV TIME_ZONE Asia/Shanghai

ADD ./bin/crond-$CRON_OS-$CRON_ARCH  /usr/bin/crond
ADD ./switch.sh  /start.sh
ADD ./crontab.sh  /start-crontab.sh

RUN apk add --no-cache tzdata \
    && chmod +x /usr/bin/crond \
    && chmod +x /start.sh \
    && mkdir -p /etc/cron.d \
    && cp -r -f /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    && echo "${TIME_ZONE}" > /etc/timezone \
    && apk del tzdata

ADD ./conf/cron /etc/cron.d/cron.conf