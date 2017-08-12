FROM hub.oapol.com/php-base:latest

ENV REDIS_VERSION 2.2.8

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libmemcached-dev \
        imagemagick \
        libmagickwand-dev \
        libmagickcore-dev \
    && pecl install igbinary \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached igbinary imagick \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) mysql \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && curl -fsSL http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz -o redis-${REDIS_VERSION}.tgz \
    && tar -xf redis-${REDIS_VERSION}.tgz && rm -rf redis-${REDIS_VERSION}.tgz \
    && ( \
            cd redis-${REDIS_VERSION} \
            && phpize \
            && ./configure --enable-redis \
            && make -j$(nproc) \
            && make install \
        ) \
         && rm -rf redis-${REDIS_VERSION} \
         && docker-php-ext-enable redis \
         && apt-get clean \
         && sed -i 's/pm.max_children = 5/pm.max_children = 50/g' /usr/local/etc/php-fpm.d/www.conf