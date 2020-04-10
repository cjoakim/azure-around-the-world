#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-web-ingress.yaml

echo 'done'

# Output:
# ingress.networking.k8s.io/ratings-web-ingress configured
# done
