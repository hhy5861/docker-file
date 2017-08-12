#!/bin/bash

IMAGE=jenkins:2.3
DOMAIN=gitlab.oapol.com
ADDIP=192.168.110.40

start_jenkins() {
    ID=$(docker run \
        -ti \
        -d \
        -u=jenkins \
        --restart=always \
        --name docker_jenkins \
        --add-host $DOMAIN:$ADDIP \
        -p 8081:8080 \
        -p 50000:50000 \
        -v /data/docker/jenkins/data:/var/jenkins_home \
        $IMAGE)
}

echo "jenkins start ..."
start_jenkins
echo $ID