#!/bin/bash

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

# Enable custom crond config files if they exist
if [ -d "/var/www/html/conf/cron" ]; then
  cp -rf /var/www/html/conf/cron/* /etc/cron.d/
fi

 GIT_COMMAND='git clone '

# Switch env config file
if [[ "$SWITCH_ENV" == "prod" ]]
 then
    cp -rf /var/www/html/environments/prod/yii /var/www/html/
    COMFIGPARTH="/var/www/html/environments/prod"
   if [ -z "$GIT_CONFIG_USERNAME" ] && [ -z "$GIT_CONFIG_PERSONAL_TOKEN" ] && [ -z "$GIT_CONFIG_REPO" ]; then
      GIT_COMMAND=${GIT_COMMAND}" http://${GIT_CONFIG_USERNAME}:${GIT_CONFIG_PERSONAL_TOKEN}@${GIT_CONFIG_REPO} ${COMFIGPARTH} -b master"
   fi
   ${GIT_COMMAND} ${COMFIGPARTH} || exit 1
   chown -Rf nginx.nginx ${COMFIGPARTH}
fi

if [ ! -z "$SWITCH_ENV" ]; then
 ./init --env=$SWITCH_ENV
fi

# Start crond and services
exec /usr/bin/crond /etc/cron.d