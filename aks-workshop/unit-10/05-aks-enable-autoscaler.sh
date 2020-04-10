#!/bin/bash

source ../env.sh

echo 'az aks update:'

az aks update \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME  \
    --enable-cluster-autoscaler \
    --min-count 3 \
    --max-count 5

echo 'done'
