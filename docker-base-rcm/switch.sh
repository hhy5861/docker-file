#!/bin/bash

# Disable Strict Host checking for non interactive git clones

mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

if [[ "$GIT_USE_SSH" == "1" ]] ; then
  echo -e "Host *\n\tUser ${GIT_USERNAME}\n\n" >> /root/.ssh/config
fi

if [ ! -z "$SSH_KEY" ]; then
 echo $SSH_KEY > /root/.ssh/id_rsa.base64
 base64 -d /root/.ssh/id_rsa.base64 > /root/.ssh/id_rsa
 chmod 600 /root/.ssh/id_rsa
fi

# Set custom webroot
if [ ! -z "$WEBROOT" ]; then
 sed -i "s#root /var/www/html;#root ${WEBROOT};#g" /etc/nginx/sites-available/default.conf
else
 webroot=/var/www/html
fi

# Setup git variables
if [ ! -z "$GIT_EMAIL" ]; then
 git config --global user.email "$GIT_EMAIL"
fi
if [ ! -z "$GIT_NAME" ]; then
 git config --global user.name "$GIT_NAME"
 git config --global push.default simple
fi

# Dont pull code down if the .git folder exists
 GIT_COMMAND='git clone '

# Try auto install for composer
if [ -f "/var/www/html/composer.lock" ]; then
  composer install --no-dev --working-dir=/var/www/html
fi

# Enable custom nginx config files if they exist
if [ -f /var/www/html/conf/nginx/nginx-site.conf ]; then
  cp /var/www/html/conf/nginx/nginx-site.conf /etc/nginx/sites-available/default.conf
fi

if [ -f /var/www/html/conf/nginx/nginx-site-ssl.conf ]; then
  cp /var/www/html/conf/nginx/nginx-site-ssl.conf /etc/nginx/sites-available/default-ssl.conf
fi

# Enable cron config 
if [ -f /var/www/html/conf/cron/cron.conf ]; then
  cp -rf /var/www/html/conf/cron/cron.conf /etc/cron.d/cron.conf
fi

# Display PHP error's or not
if [[ "$ERRORS" != "1" ]] ; then
 echo php_flag[display_errors] = off >> /usr/local/etc/php-fpm.conf
else
 echo php_flag[display_errors] = on >> /usr/local/etc/php-fpm.conf
fi

# Display Version Details or not
if [[ "$HIDE_NGINX_HEADERS" == "0" ]] ; then
 sed -i "s/server_tokens off;/server_tokens on;/g" /etc/nginx/nginx.conf
else
 sed -i "s/expose_php = On/expose_php = Off/g" /usr/local/etc/php-fpm.conf
fi

# Pass real-ip to logs when behind ELB, etc
if [[ "$REAL_IP_HEADER" == "1" ]] ; then
 sed -i "s/#real_ip_header X-Forwarded-For;/real_ip_header X-Forwarded-For;/" /etc/nginx/sites-available/default.conf
 sed -i "s/#set_real_ip_from/set_real_ip_from/" /etc/nginx/sites-available/default.conf
 if [ ! -z "$REAL_IP_FROM" ]; then
  sed -i "s#172.16.0.0/12#$REAL_IP_FROM#" /etc/nginx/sites-available/default.conf
 fi
fi
# Do the same for SSL sites
if [ -f /etc/nginx/sites-available/default-ssl.conf ]; then
 if [[ "$REAL_IP_HEADER" == "1" ]] ; then
  sed -i "s/#real_ip_header X-Forwarded-For;/real_ip_header X-Forwarded-For;/" /etc/nginx/sites-available/default-ssl.conf
  sed -i "s/#set_real_ip_from/set_real_ip_from/" /etc/nginx/sites-available/default-ssl.conf
  if [ ! -z "$REAL_IP_FROM" ]; then
   sed -i "s#172.16.0.0/12#$REAL_IP_FROM#" /etc/nginx/sites-available/default-ssl.conf
  fi
 fi
fi

# Increase the memory_limit
if [ ! -z "$PHP_MEM_LIMIT" ]; then
 sed -i "s/memory_limit = 128M/memory_limit = ${PHP_MEM_LIMIT}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
fi

# Increase the post_max_size
if [ ! -z "$PHP_POST_MAX_SIZE" ]; then
 sed -i "s/post_max_size = 100M/post_max_size = ${PHP_POST_MAX_SIZE}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
fi

# Increase the upload_max_filesize
if [ ! -z "$PHP_UPLOAD_MAX_FILESIZE" ]; then
 sed -i "s/upload_max_filesize = 100M/upload_max_filesize= ${PHP_UPLOAD_MAX_FILESIZE}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
fi

if [ ! -z "$PUID" ]; then
  if [ -z "$PGID" ]; then
    PGID=${PUID}
  fi
  deluser nginx
  addgroup -g ${PGID} nginx
  adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx -u ${PUID} nginx
else
  # Always chown webroot for better mounting
  chown -Rf nginx.nginx /var/www/html
fi

# Run custom scripts
if [[ "$RUN_SCRIPTS" == "1" ]] ; then
  if [ -d "/var/www/html/scripts/" ]; then
    # make scripts executable incase they aren't
    chmod -Rf 750 /var/www/html/scripts/*
    # run scripts in number order
    for i in `ls /var/www/html/scripts/`; do /var/www/html/scripts/$i ; done
  else
    echo "Can't find script directory"
  fi
fi

# default app config
mv /var/www/html/environments/dev.default /var/www/html/environments/$SWITCH_ENV
# Switch env config file
if [[ "$SWITCH_ENV" == "dev" ]]
 then
    cp -rf /var/www/html/environments/dev.dev/yii /var/www/html/
    cp -rf /var/www/html/environments/dev.dev/index.php /var/www/html/backend/web/
    cp -rf /var/www/html/environments/dev.dev/* /var/www/html/environments/dev
elif [[ "$SWITCH_ENV" == "stage" ]]
 then
    cp -rf /var/www/html/environments/dev.stage/yii /var/www/html/
    cp -rf /var/www/html/environments/dev.stage/index.php /var/www/html/backend/web/
    cp -rf /var/www/html/environments/dev.stage/* /var/www/html/environments/stage
 elif [[ "$SWITCH_ENV" == "test" ]]
 then
    cp -rf /var/www/html/environments/dev.test/yii /var/www/html/
    cp -rf /var/www/html/environments/dev.test/index.php /var/www/html/backend/web/
    cp -rf /var/www/html/environments/dev.test/* /var/www/html/environments/test
 elif [[ "$SWITCH_ENV" == "prod" ]]
 then
    cp -rf /var/www/html/environments/prod/yii /var/www/html/
    COMFIGPARTH="/var/www/html/environments/prod"
   if [ -z "$GIT_CONFIG_USERNAME" ] && [ -z "$GIT_CONFIG_PERSONAL_TOKEN" ] && [ -z "$GIT_CONFIG_REPO" ]; then
      GIT_COMMAND=${GIT_COMMAND}" http://${GIT_CONFIG_USERNAME}:${GIT_CONFIG_PERSONAL_TOKEN}@${GIT_CONFIG_REPO} ${COMFIGPARTH} -b master"
   fi
   ${GIT_COMMAND} ${COMFIGPARTH} || exit 1
   chown -Rf nginx.nginx ${COMFIGPARTH}
fi

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf

