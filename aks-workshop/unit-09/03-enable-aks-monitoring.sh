#!/bin/bash

source ../env.sh

az aks enable-addons \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME \
    --addons monitoring \
    --workspace-resource-id $WORKSPACE_ID

echo 'done'

# Output:

