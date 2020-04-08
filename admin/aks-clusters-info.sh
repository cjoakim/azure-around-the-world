#!/bin/bash

# Generated bash script to get AKS/ATW cluster info with kubectl.
# Chris Joakim, Microsoft
#
# Usage:
#   $ ./aks-clusters-info.sh > tmp/aks-clusters-info.txt

sleep_time=10


echo "==="
echo "AKS for region #1, name: eastus, context: cjoakim-atw-aks-1-eastus"
kubectl config use-context cjoakim-atw-aks-1-eastus
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope"
kubectl config use-context cjoakim-atw-aks-2-westeurope
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #3, name: centralindia, context: cjoakim-atw-aks-3-centralindia"
kubectl config use-context cjoakim-atw-aks-3-centralindia
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #4, name: japaneast, context: cjoakim-atw-aks-4-japaneast"
kubectl config use-context cjoakim-atw-aks-4-japaneast
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #5, name: westus, context: cjoakim-atw-aks-5-westus"
kubectl config use-context cjoakim-atw-aks-5-westus
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time
