#!/bin/bash

source ../env.sh display

echo 'deleting resource group: '$RESOURCE_GROUP

az group delete \
    --name $RESOURCE_GROUP \
    --subscription $AZURE_SUBSCRIPTION_ID \
    --no-wait

echo 'done'
