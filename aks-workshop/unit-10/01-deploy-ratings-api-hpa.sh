#!/bin/bash

source ../env.sh display

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-api-hpa.yaml

echo 'done'

# Output:
# horizontalpodautoscaler.autoscaling/ratings-api created
# done
