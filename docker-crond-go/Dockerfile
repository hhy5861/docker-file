FROM debian

ENV CRON_VERSION 0.7.0
ENV CRON_OS linux
ENV CRON_ARCH amd64

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates curl \
	&& apt-get clean \
	&& curl -o /usr/bin/crond -sSL https://github.com/alexkappa/crond/releases/download/v$CRON_VERSION/crond-$CRON_OS-$CRON_ARCH \
	&& chmod +x /usr/bin/crond

VOLUME ["/etc/cron.d"]

EXPOSE 22

CMD ["crond", "/etc/cron.d"]
