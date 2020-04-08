#!/bin/bash

source ../env.sh 

SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $SUBNET_NAME \
    --query id -o tsv)

echo 'SUBNET_ID: '$SUBNET_ID

echo 'done'
