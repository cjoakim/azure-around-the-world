#!/bin/bash

# Bash and Azure CLI script to create an Azure Container Instance, invoked
# with a sequence of command-line args (MODE, RG_LOG, RG_NAME, RES_NAME).
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-create
# Chris Joakim, 2020/03/16
#
# Usage:
#   This script is called by aci-create-instances.sh n-times, once per region.

source ../app-config.sh 

# These parameters are passed to this script as a sequence of command-line args:
MODE=$1
RG_LOC=$2
RG_NAME=$3""
RES_NAME=$4

arg_count=$#

if [ $arg_count -gt 0 ]
then
    if [ $MODE == "provision" ] 
    then
        echo "aci-create-instance, provision mode"
        echo "  RG_LOC:                 "$RG_LOC
        echo "  RG_NAME:                "$RG_NAME
        echo "  RES_NAME:               "$RES_NAME
        echo "  ACR_CONTAINER_FULLNAME: "$ACR_CONTAINER_FULLNAME

        echo "creating resource group "$RG_NAME" in "$RG_LOC
        az group create --location $RG_LOC --name $RG_NAME

        echo "creating container instance "$RES_NAME" in "$RG_NAME
        az container create \
            --resource-group $RG_NAME \
            --name  $RES_NAME \
            --image $ACR_CONTAINER_FULLNAME \
            --dns-name-label $RES_NAME \
            --ports 80 \
            --os-type Linux \
            --restart-policy Always \
            --registry-login-server $AZURE_ACR_LOGIN_SERVER \
            --registry-username     $AZURE_ACR_USER_NAME \
            --registry-password     $AZURE_ACR_USER_PASS \
            --environment-variables \
                'AZURE_RESOURCE_LOC'=$RG_LOC \
                'AZURE_RESOURCE_NAME'=$RES_NAME \
                'AZURE_COSMOSDB_URI'=$AZURE_COSMOSDB_URI \
                'AZURE_COSMOSDB_KEY'=$AZURE_COSMOSDB_KEY \
                'AZURE_COSMOSDB_DATABASE'=$AZURE_COSMOSDB_DATABASE 

        az container show --resource-group $RG_NAME --name $RES_NAME --out table > logs/$RES_NAME"_show.txt"
        cat logs/$RES_NAME"_show.txt"
    else
        echo "aci-create-instance, display mode only"
        echo "  RG_LOC:                  "$RG_LOC
        echo "  RG_NAME:                 "$RG_NAME
        echo "  RES_NAME:                "$RES_NAME
        echo "  ACR_CONTAINER_FULLNAME:  "$ACR_CONTAINER_FULLNAME
        echo "  AZURE_COSMOSDB_URI:      "$AZURE_COSMOSDB_URI
        # echo "  AZURE_COSMOSDB_KEY:      "$AZURE_COSMOSDB_KEY
        # echo "  AZURE_COSMOSDB_DATABASE: "$AZURE_COSMOSDB_DATABASE
    fi
fi
