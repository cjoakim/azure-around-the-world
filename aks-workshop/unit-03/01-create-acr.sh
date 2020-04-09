#!/bin/bash

source ../env.sh

az acr create \
    --resource-group $RESOURCE_GROUP \
    --location $REGION_NAME \
    --name $ACR_NAME \
    --sku Standard

echo 'done'

# Note: see the Docker build scripts here:
# aks-workshop/mslearn-aks-workshop-ratings-api/acr-build-api-app.sh
# aks-workshop/mslearn-aks-workshop-ratings-web/acr-build-web-app.sh
