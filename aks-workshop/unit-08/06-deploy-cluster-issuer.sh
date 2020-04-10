#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f cluster-issuer.yaml

echo 'done'

# Output:
# clusterissuer.cert-manager.io/letsencrypt created
# done
