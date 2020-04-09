#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-api-deployment.yaml

echo 'done'

# Output:
# deployment.apps/ratings-api created
# done
