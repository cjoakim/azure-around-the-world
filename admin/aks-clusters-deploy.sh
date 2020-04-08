#!/bin/bash

# Generated bash script to deploy the ATW app to the n-number
# of AKS clusters.
# Chris Joakim, Microsoft
#
# Usage:
#   $ ./aks-clusters-deploy.sh

sleep_time=10


echo "==="
echo "Deploying to region #1, name: eastus, context: cjoakim-atw-aks-1-eastus"
kubectl config use-context cjoakim-atw-aks-1-eastus
kubectl config current-context
kubectl apply -f kub/atw-1-eastus.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope"
kubectl config use-context cjoakim-atw-aks-2-westeurope
kubectl config current-context
kubectl apply -f kub/atw-2-westeurope.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #3, name: centralindia, context: cjoakim-atw-aks-3-centralindia"
kubectl config use-context cjoakim-atw-aks-3-centralindia
kubectl config current-context
kubectl apply -f kub/atw-3-centralindia.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #4, name: japaneast, context: cjoakim-atw-aks-4-japaneast"
kubectl config use-context cjoakim-atw-aks-4-japaneast
kubectl config current-context
kubectl apply -f kub/atw-4-japaneast.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #5, name: westus, context: cjoakim-atw-aks-5-westus"
kubectl config use-context cjoakim-atw-aks-5-westus
kubectl config current-context
kubectl apply -f kub/atw-5-westus.yaml
sleep $sleep_time
