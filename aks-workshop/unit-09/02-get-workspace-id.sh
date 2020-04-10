#!/bin/bash

source ../env.sh

WORKSPACE_ID=$(az resource show --resource-type Microsoft.OperationalInsights/workspaces \
    --resource-group $RESOURCE_GROUP \
    --name $WORKSPACE \
    --query "id" -o tsv)

echo 'WORKSPACE_ID: '$WORKSPACE_ID
echo 'done'

# Output:

