#!/bin/bash

# Generated bash script to provision an AKS custer with the az CLI.
# Chris Joakim, Microsoft
#
# Usage:
#   ./aks-create-3-centralindia.sh

source ../app-config.sh

sleep_after_rg_delete_sec=15
sleep_after_rg_create_sec=15
sleep_after_cluster_sec=30
sleep_after_credentials_sec=15

echo "=== aks-create-3-centralindia.sh start: $(date)"

echo "deleting resource group cjoakim-atw-aks-3-centralindia"
az group delete --name cjoakim-atw-aks-3-centralindia --yes

sleep $sleep_after_rg_delete_sec

echo "creating resource group cjoakim-atw-aks-3-centralindia in centralindia"
az group create --location centralindia --name cjoakim-atw-aks-3-centralindia

sleep $sleep_after_rg_create_sec

echo "creating aks cluster cjoakim-atw-aks-3-centralindia"
az aks create \
    --resource-group cjoakim-atw-aks-3-centralindia \
    --name cjoakim-atw-aks-3-centralindia \
    --node-count 2 \
    --enable-cluster-autoscaler \
    --min-count 2 \
    --max-count 4 \
    --generate-ssh-keys \
    --attach-acr $AZURE_ACR_NAME \
    --service-principal $AZURE_AKS_SP_APP_ID \
    --client-secret $AZURE_AKS_SP_PASSWORD

# see https://github.com/Azure/azure-cli/issues/9585 re: Service Principal

sleep $sleep_after_cluster_sec

echo "getting credentials for aks cluster cjoakim-atw-aks-3-centralindia"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-3-centralindia \
    --name cjoakim-atw-aks-3-centralindia \
    --overwrite-existing

sleep $sleep_after_credentials_sec

echo 'kubectl config get-contexts'
kubectl config get-contexts

echo "kubectl get nodes for aks cluster cjoakim-atw-aks-3-centralindia"
kubectl get nodes

echo "=== aks-create-3-centralindia.sh finish: $(date)"
