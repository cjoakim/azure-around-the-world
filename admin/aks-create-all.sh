#!/bin/bash

# Generated bash script to create the AKS clusters in all n-regions.
# Chris Joakim, Microsoft
#
# Usage:
#   $ ./aks-create-all.sh

source ../app-config.sh

echo "=== aks-create-all.sh start: $(date)"


./aks-create-1-eastus.sh

./aks-create-2-westeurope.sh

./aks-create-3-centralindia.sh

./aks-create-4-japaneast.sh

./aks-create-5-westus.sh


echo "=== aks-create-all.sh finish: $(date)"
