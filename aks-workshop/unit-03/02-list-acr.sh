#!/bin/bash

source ../env.sh

az acr repository list \
    --name $ACR_NAME \
    --output table

# extra

echo 'ratings-api image'
az acr repository show-tags --name $ACR_NAME --repository ratings-api
az acr repository show --name $ACR_NAME --image ratings-api:v1

echo 'ratings-web image'
az acr repository show-tags --name $ACR_NAME --repository ratings-web
az acr repository show --name $ACR_NAME --image ratings-web:v1

echo 'done'
