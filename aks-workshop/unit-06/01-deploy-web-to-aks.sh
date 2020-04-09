#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-web-deployment.yaml

echo 'done'

# Output:
# deployment.apps/ratings-web created
# done
