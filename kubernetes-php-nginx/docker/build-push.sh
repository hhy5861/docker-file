#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build -t hub.oapol.com/php-nginx:latest ${DIR}/..
docker push hub.oapol.com/php-nginx:latest
