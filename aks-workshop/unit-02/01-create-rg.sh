#!/bin/bash

source ../env.sh 

az group create \
    --name $RESOURCE_GROUP \
    --location $REGION_NAME

echo 'done'
