#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

kubectl create -f ${DIR}/php-nginx-app.yaml --validate=false

nodePort=$(kubectl get svc php-nginx-svc -o template --template="{{(index .spec.ports 0).nodePort}}")
externalIP=$(kubectl get no -o template --template="{{(index .items 0).metadata.name}}")

echo "---"
echo "When pod(s) are ready, hit http://${externalIP}:${nodePort} in your browser!"
