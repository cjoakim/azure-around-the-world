#!/bin/bash

# Bash script to restart an Azure Container Instances.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-restart
# Chris Joakim, 2019/12/16
#
# Usage:
#   This script is called by aci_restart_instances.sh n-times, once per region.
#   $ ./aci-restart-instance.sh cjoakim-atw-1-eastus 

RESOURCE=$1

echo 'Restarting ACI instance: '$RESOURCE
az container restart --name $RESOURCE --resource-group $RESOURCE > logs/$RESOURCE"_restart.txt"
