FROM   hub.oapol.com/php-tengine:latest

MAINTAINER Mike Huang <huanghaiying@cheyian.com>

ADD imagick-3.4.1.tgz /
RUN yum install -y ImageMagick-devel && yum clean all && \
    cd /imagick-3.4.1 && /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config --with-imagick && \
    make -j 8 && make install && \
    sed -i -e '/extension=igbinary.so/a\extension=imagick.so' /usr/local/php/etc/php.ini && \
    rm -rf imagick-3.4.1