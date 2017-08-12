#!/bin/bash

ENV_PAHT=/www/.env

export | grep DOCKER_EXPORT | awk '{print $3}' | sed 's/"//g'>$ENV_PAHT