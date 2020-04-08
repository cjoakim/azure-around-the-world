#!/bin/bash

# Bash script to show an Azure Container Instance.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-show
# Chris Joakim, 2019/12/16
#
# Usage:
#   This script is called by aci-show-instances.sh n-times, once per region.
#   $ ./aci-show-instance.sh cjoakim-atw-1-eastus 

RESOURCE=$1

echo 'az container show: '$RESOURCE

az container show --name $RESOURCE --resource-group $RESOURCE > logs/$RESOURCE"_show.json"

cat logs/$RESOURCE"_show.json"
