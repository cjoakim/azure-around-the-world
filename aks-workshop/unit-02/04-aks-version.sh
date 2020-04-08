#!/bin/bash

source ../env.sh 

VERSION=$(az aks get-versions \
    --location $REGION_NAME \
    --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
    --output tsv)

echo 'VERSION: '$VERSION

# VERSION: 1.16.7

echo 'done'
