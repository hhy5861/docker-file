FROM    hub.oapol.com/php-tengine:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>
 
ENV REDIS_ADDR
ENV MEMCACHE_ADDR1
ENV MEMCACHE_ADDR2
ENV MYSQL_DB_ADDR
ENV MYSQL_BASE_ADDR

ADD php-tengine/src/index.php /app/index.php
RUN echo "<?php\n print_r($_ENV);\n?>" >> /app/test.php
