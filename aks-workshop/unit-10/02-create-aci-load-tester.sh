#!/bin/bash

source ../env.sh display

echo 'az container create:'

az container create \
    -g $RESOURCE_GROUP \
    -n loadtest \
    --cpu 4 \
    --memory 1 \
    --image azch/artillery \
    --restart-policy Never \
    --command-line "artillery quick -r 500 -d 120 $LOADTEST_API_ENDPOINT"

echo 'kubectl get hpa:'

kubectl get hpa --namespace $AKS_NAMESPACE -w

echo 'done'

# Output:
# kubectl get hpa:
# NAME          REFERENCE                TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
# ratings-api   Deployment/ratings-api   0%/30%    1         10        1          3h11m
# ratings-api   Deployment/ratings-api   125%/30%   1         10        1          3h11m
# ratings-api   Deployment/ratings-api   125%/30%   1         10        4          3h12m
# ratings-api   Deployment/ratings-api   125%/30%   1         10        5          3h12m
# ratings-api   Deployment/ratings-api   88%/30%    1         10        5          3h13m
# ratings-api   Deployment/ratings-api   0%/30%     1         10        5          3h14m
# ratings-api   Deployment/ratings-api   0%/30%     1         10        5          3h18m
# ratings-api   Deployment/ratings-api   0%/30%     1         10        1          3h19m
