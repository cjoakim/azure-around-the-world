#!/bin/bash

# Bash script to download the logs for an Azure Container Instance.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-logs
# Chris Joakim, 2019/12/16
#
# Usage:
#   This script is called by aci-get-logs.sh n-times, once per region.
#   $ ./aci-get-log.sh cjoakim-atw-1-eastus

RESOURCE=$1

echo 'Getting logs for ACI instance: '$RESOURCE

az container logs --name $RESOURCE --resource-group $RESOURCE > logs/$RESOURCE"_log.txt"
