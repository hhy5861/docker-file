FROM registry.cn-shanghai.aliyuncs.com/kd/nginx-php-fpm:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ENV CRON_VERSION 1.0.0
ENV CRON_OS linux
ENV CRON_ARCH amd64
ENV TIME_ZONE Asia/Shanghai

ADD ./bin/crond-$CRON_OS-$CRON_ARCH  /usr/bin/crond
ADD ./switch.sh  /start.sh

RUN apk add --no-cache tzdata \
    && chmod +x /usr/bin/crond \
    && chmod +x /start.sh \
    && mkdir -p /etc/cron.d \
    && cp -r -f /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
    && echo "${TIME_ZONE}" > /etc/timezone \
    && apk del tzdata

ADD ./conf/cron /etc/cron.d/cron.conf

RUN echo "" >> /etc/supervisord.conf \
    && echo "[program:crond]" >> /etc/supervisord.conf \
	&& echo "command=/usr/bin/crond /etc/cron.d" >> /etc/supervisord.conf \
    && echo "autostart=true" >> /etc/supervisord.conf \
    && echo "autorestart=true" >> /etc/supervisord.conf \
    && echo "priority=10" >> /etc/supervisord.conf \
    && echo "stdout_events_enabled=true" >> /etc/supervisord.conf \
    && echo "stderr_events_enabled=true" >> /etc/supervisord.conf \
    && echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
    && echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
    && echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
    && echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf 










