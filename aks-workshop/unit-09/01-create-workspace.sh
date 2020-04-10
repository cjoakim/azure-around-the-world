#!/bin/bash

source ../env.sh display

az resource create --resource-type Microsoft.OperationalInsights/workspaces \
        --name $WORKSPACE \
        --resource-group $RESOURCE_GROUP \
        --location $REGION_NAME \
        --properties '{}' -o table

echo 'done'

# Output:
# Location    Name                           ResourceGroup
# ----------  -----------------------------  ---------------
# eastus      aksworkshop-workspace-cjoakim  aksworkshop
# done
