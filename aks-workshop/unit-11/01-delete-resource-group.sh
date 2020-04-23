#!/bin/bash

source ../env.sh display

echo 'deleting resource group: '$RESOURCE_GROUP

# --no-wait    Do not wait for the long-running operation to finish.
# --yes        Do not prompt for confirmation.

az group delete \
    --name $RESOURCE_GROUP \
    --subscription $AZURE_SUBSCRIPTION_ID \
    --no-wait \
    --yes 

echo 'done'
