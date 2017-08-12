FROM hub.oapol.com/cheyian-php:latest

ENV NGINX_VERSION 1.10.1-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
                        ca-certificates \
                        nginx=${NGINX_VERSION} \
                        nginx-module-xslt \
                        nginx-module-geoip \
                        nginx-module-image-filter \
                        nginx-module-perl \
                        nginx-module-njs \
                        gettext-base \
                        python-pip \
                        git \
    && rm -rf /var/lib/apt/lists/* \
    && pip install supervisor \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && apt-get clean

ADD conf/nginx.conf.default     /etc/nginx/nginx.conf
ADD conf/default.oapol.com.conf /etc/nginx/conf.d/default.oapol.com.conf
ADD conf/supervisord.conf       /etc/supervisord.conf
ADD conf/index.php              /app/index.php

EXPOSE 80 443

CMD ["supervisord","-n","-c","/etc/supervisord.conf"]
