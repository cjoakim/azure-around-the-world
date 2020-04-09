#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-web-service.yaml

echo 'done'
