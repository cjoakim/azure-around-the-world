#!/bin/bash

# Generated bash script to get the kubernetes/kubectl configuration info
# for the AKS clusters in all n-regions.
# Chris Joakim, Microsoft
#
# Usage:
#   ./aks-get-credentials-all.sh

source ../app-config.sh


echo "getting credentials for aks cluster cjoakim-atw-aks-1-eastus"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-1-eastus \
    --name cjoakim-atw-aks-1-eastus \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-2-westeurope"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-2-westeurope \
    --name cjoakim-atw-aks-2-westeurope \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-3-centralindia"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-3-centralindia \
    --name cjoakim-atw-aks-3-centralindia \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-4-japaneast"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-4-japaneast \
    --name cjoakim-atw-aks-4-japaneast \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-5-westus"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-5-westus \
    --name cjoakim-atw-aks-5-westus \
    --overwrite-existing


echo 'kubectl config get-contexts'
kubectl config get-contexts
