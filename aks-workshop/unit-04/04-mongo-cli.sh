#!/bin/bash

source ../env.sh

export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace ratingsapp ratings-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)

echo 'MONGODB_ROOT_PASSWORD: '$MONGODB_ROOT_PASSWORD

kubectl port-forward --namespace $AKS_NAMESPACE svc/ratings-mongodb 27017:27017 &

echo 'sleeping 10 sec...'
sleep 10

mongo --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD

