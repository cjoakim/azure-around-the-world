#!/bin/bash

source ../env.sh

kubectl apply \
    --namespace $AKS_NAMESPACE \
    -f ratings-api-service.yaml

kubectl get service ratings-api --namespace $AKS_NAMESPACE

echo 'done'

# Output:
# service/ratings-api created
# NAME          TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# ratings-api   ClusterIP   10.2.0.116   <none>        80/TCP    0s
# done
