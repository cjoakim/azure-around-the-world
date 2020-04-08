#!/bin/bash

# Bash and Azure CLI script to delete the ACI Azure Resource Groups created and used in this app.
# See https://docs.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-delete
# Chris Joakim, 2020/03/16

source ../app-config.sh

arg_count=$#
wait=""

if [ $arg_count -gt 0 ]
then
    if [ $1 == "no-wait" ] 
    then
        wait="--no-wait"
    fi
fi

echo "wait flag: "$wait

echo 'az group delete: '$REGION1_ACI_RESOURCE
az group delete --name $REGION1_ACI_RESOURCE --yes $wait

echo 'az group delete: '$REGION2_ACI_RESOURCE
az group delete --name $REGION2_ACI_RESOURCE --yes $wait

echo 'az group delete: '$REGION3_ACI_RESOURCE
az group delete --name $REGION3_ACI_RESOURCE --yes $wait

echo 'az group delete: '$REGION4_ACI_RESOURCE
az group delete --name $REGION4_ACI_RESOURCE --yes $wait

echo 'az group delete: '$REGION5_ACI_RESOURCE
az group delete --name $REGION5_ACI_RESOURCE --yes $wait

echo 'done'
