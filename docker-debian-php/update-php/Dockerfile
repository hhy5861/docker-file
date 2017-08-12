FROM hub.oapol.com/cheyian-php-nginx:latest

RUN { \
        echo '[Date]'; \
        echo 'date.timezone = asia/shanghai'; \
        echo '[PHP]'; \
        echo 'file_uploads = On'; \
        echo 'upload_max_filesize = 20M'; \
        echo 'max_file_uploads = 20'; \
    } | tee /usr/local/etc/php/conf.d/php.ini