#!/bin/bash

# Generated bash script to delete the AKS custers with the az CLI.
# Chris Joakim, Microsoft
#
# Usage:
#   ./aks-delete.sh
#   ./aks-delete.sh no-wait

source ../app-config.sh

arg_count=$#
sleep_time=3
wait=""

if [ $arg_count -gt 0 ]
then
    if [ $1 == "no-wait" ] 
    then
        wait="--no-wait"
    fi
fi

echo "wait flag: "$wait

echo "kubectl config get-contexts before deletes"
kubectl config get-contexts


kubectl config delete-context cjoakim-atw-aks-1-eastus

kubectl config delete-context cjoakim-atw-aks-2-westeurope

kubectl config delete-context cjoakim-atw-aks-3-centralindia

kubectl config delete-context cjoakim-atw-aks-4-japaneast

kubectl config delete-context cjoakim-atw-aks-5-westus


echo "kubectl config get-contexts after deletes"
kubectl config get-contexts


echo "=== az group delete: cjoakim-atw-aks-1-eastus at: $(date)"
az group delete --name cjoakim-atw-aks-1-eastus --yes $wait
sleep $sleep_time

echo "=== az group delete: cjoakim-atw-aks-2-westeurope at: $(date)"
az group delete --name cjoakim-atw-aks-2-westeurope --yes $wait
sleep $sleep_time

echo "=== az group delete: cjoakim-atw-aks-3-centralindia at: $(date)"
az group delete --name cjoakim-atw-aks-3-centralindia --yes $wait
sleep $sleep_time

echo "=== az group delete: cjoakim-atw-aks-4-japaneast at: $(date)"
az group delete --name cjoakim-atw-aks-4-japaneast --yes $wait
sleep $sleep_time

echo "=== az group delete: cjoakim-atw-aks-5-westus at: $(date)"
az group delete --name cjoakim-atw-aks-5-westus --yes $wait
sleep $sleep_time
