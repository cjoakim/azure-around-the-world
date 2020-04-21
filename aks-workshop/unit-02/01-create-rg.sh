#!/bin/bash

source ../env.sh display

echo 'RESOURCE_GROUP: '$RESOURCE_GROUP

az group create \
    --name $RESOURCE_GROUP \
    --location $REGION_NAME

echo 'done'
