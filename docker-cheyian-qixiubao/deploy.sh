#! /bin/bash
ID=$(docker -H 172.16.0.6:8010 run -d \
    -p 8014:80 \
    --name cheyian-qixiubao \
    --restart=always \
    --add-host b2b.api.cheyian.com:172.18.0.1 \
    --add-host b2c.api.cheyian.com:172.18.0.1 \
    --add-host member.api.cheyian.com:172.18.0.1 \
    --add-host auth.api.cheyian.com:172.18.0.1 \
    --add-host napi.cheyian.com:172.18.0.1 \
    --add-host member.site.cheyian.com:172.18.0.1 \
    -e YII_ENV=prod \
    hub.oapol.com/cheyian-qixiubao:v44)

ID=$(docker -H 172.16.0.6:8010 run -d \
    -p 8012:80 \
    --name cheyian-member \
    --restart=always \
    --add-host b2b.api.cheyian.com:172.18.0.1 \
    --add-host b2c.api.cheyian.com:172.18.0.1 \
    --add-host member.api.cheyian.com:172.18.0.1 \
    --add-host auth.api.cheyian.com:172.18.0.1 \
    --add-host napi.cheyian.com:172.18.0.1 \
    --add-host member.site.cheyian.com:172.18.0.1 \
    -e YII_ENV=prod \
    hub.oapol.com/cheyian-member:v11)

ID=$(docker -H 172.16.0.6:8010 run -d \
    -p 8011:80 \
    --name cheyian-b2c \
    --restart=always \
    --add-host b2b.api.cheyian.com:172.18.0.1 \
    --add-host b2c.api.cheyian.com:172.18.0.1 \
    --add-host member.api.cheyian.com:172.18.0.1 \
    --add-host auth.api.cheyian.com:172.18.0.1 \
    --add-host napi.cheyian.com:172.18.0.1 \
    --add-host member.site.cheyian.com:172.18.0.1 \
    -e YII_ENV=prod \
    hub.oapol.com/cheyian-b2c:v9)

ID=$(docker -H 172.16.0.6:8010 run -d \
    -p 8010:80 \
    --name cheyian-b2b \
    --restart=always \
    --add-host b2b.api.cheyian.com:172.18.0.1 \
    --add-host b2c.api.cheyian.com:172.18.0.1 \
    --add-host member.api.cheyian.com:172.18.0.1 \
    --add-host auth.api.cheyian.com:172.18.0.1 \
    --add-host napi.cheyian.com:172.18.0.1 \
    --add-host member.site.cheyian.com:172.18.0.1 \
    -e YII_ENV=prod \
    hub.oapol.com/cheyian-b2b:v44)

ID=$(docker -H 172.16.0.6:8010 run -d \
    -p 8013:80 \
    --name cheyian-auth \
    --restart=always \
    --add-host b2b.api.cheyian.com:172.18.0.1 \
    --add-host b2c.api.cheyian.com:172.18.0.1 \
    --add-host member.api.cheyian.com:172.18.0.1 \
    --add-host auth.api.cheyian.com:172.18.0.1 \
    --add-host napi.cheyian.com:172.18.0.1 \
    --add-host member.site.cheyian.com:172.18.0.1 \
    -e YII_ENV=prod \
    -e DOCKER_EXPORT_MEMCACHED_HOST=172.16.0.8 \
    -e DOCKER_EXPORT_MYSQL_DB=172.16.0.3 \
    -e DOCKER_EXPORT_MYSQL_DB_BASE=172.16.0.3 \
    -e DOCKER_EXPORT_MYSQL_DB_BASE_PASSWORD=iHYIFUrz9XpE \
    -e DOCKER_EXPORT_MYSQL_DB_BASE_USERNAME=produser \
    -e DOCKER_EXPORT_MYSQL_DB_PASSWORD=iHYIFUrz9XpE \
    -e DOCKER_EXPORT_MYSQL_DB_USERNAME=produser \
    -e DOCKER_EXPORT_REDIS_HOST_NAME=172.16.0.2 \
    -e DOCKER_EXPORT_REDIS_PASSWORD=E30a84d30 \
    -e DOCKER_EXPORT_STATIC_DOMAIN=http:/auth.static.cheyian.com \
    -e DOCKER_EXPORT_VIN_API_DOMAIN=http://auth.cheyian.com \
    -e DOCKER_EXPORT_YII_DEBUG=false \
    -e DOCKER_EXPORT_YII_ENV=prod \
    hub.oapol.com/cheyian-auth:v44)