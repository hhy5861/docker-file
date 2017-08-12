#!/usr/bin/env bash
set -e

ACTION=$1
TOPIC=$2

if [ -z "`which docker-compose`" ]; then
	echo " Did not find the executable docker-compose file"
	exit 1
fi

dockerComposeStart(){
	docker=$(docker-compose up -d)
}

createTopic(){
	topic=$(docker run --rm ches/kafka kafka-topics.sh --create --topic $1 --replication-factor 1 --partitions 1 --zookeeper $2:2181)
	echo " -> $topic "
}

getZookeeperIp(){
	ZK_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' zookeeper)
}

removeAll(){
	ID=$(docker rm -f $(docker ps -a -q))
}

if [ "$ACTION" = "deploy" ]; then
	if [ "$TOPIC" ]; then
		echo " -> Starting system start"
		dockerComposeStart
		echo " -> Starting get zookeeper ip"
		getZookeeperIp
		if [ ! $ZK_IP ]; then
			echo " -> Get zookeeper ip is null"
			exit 1
		fi
		
		echo " -> Get zookeeper ip is： $ZK_IP"
		echo " -> Starting create tipic start"
		createTopic "$TOPIC" "$ZK_IP"
	else
		echo " -> Starting system topic not null"
	fi
elif [ "$ACTION" = "remove" ]; then
	removeAll
elif [ "$ACTION" = "update" ]; then
	dockerComposeStart
else
    echo "Unknown action $ACTION"
    exit 1
fi