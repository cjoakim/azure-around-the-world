#!/bin/bash

source ../env.sh 

echo 'az aks get-credentials'

az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME

echo 'kubectl config get-contexts'

kubectl config get-contexts

echo 'kubectl get nodes'

kubectl get nodes

echo 'done'
