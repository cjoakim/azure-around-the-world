#!/bin/bash

# This bash script is "sourced" by the shell scripts in this workshop 
# to define environment variables:
#
# Use:
#   In shell scripts:  source ../env.sh 
#   In terminal:       env.sh display

# AZURE_SUBSCRIPTION_ID - this is in my bash_profile

export REGION_NAME=eastus
export RESOURCE_GROUP=aksworkshop
export SUBNET_NAME=aks-subnet
export VNET_NAME=aks-vnet
export AKS_CLUSTER_NAME=aksworkshop-cjoakim   # don't use this name!
export AKS_NAMESPACE=ratingsapp

export SUBNET_ID="/subscriptions/61761119-d249-4507-90c6-a16517e1874c/resourceGroups/aksworkshop/providers/Microsoft.Network/virtualNetworks/aks-vnet/subnets/aks-subnet"
export VERSION="1.16.7"
export ACR_NAME=aksworkshopcjoakim
export MONGODB_USER="dwight"    # Dwight Merriman, inventor of MongoDB
export MONGODB_PASS="merriman"
export MONGODB_DBNAME="ratingsdb"
export MONGODB_DNS="ratings-mongodb.ratingsapp.svc.cluster.local"
export MONGOCONNECTION="mongodb://"$MONGODB_USER":"$MONGODB_PASS"@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb"
export WORKSPACE=aksworkshop-workspace-cjoakim
export WORKSPACE_ID="/subscriptions/61761119-d249-4507-90c6-a16517e1874c/resourcegroups/aksworkshop/providers/microsoft.operationalinsights/workspaces/aksworkshop-workspace-cjoakim"
export LOADTEST_API_ENDPOINT="https://frontend.104-45-188-200.nip.io/api/loadtest"
# https://frontend.104-45-188-200.nip.io/#/leaderboard

arg_count=$#
if [ $arg_count -gt 0 ]
then
    if [ $1 == "display" ] 
    then
        echo "REGION_NAME:           "$REGION_NAME
        echo "RESOURCE_GROUP:        "$RESOURCE_GROUP
        echo "SUBNET_NAME:           "$SUBNET_NAME
        echo "VNET_NAME:             "$VNET_NAME
        echo "AKS_CLUSTER_NAME:      "$AKS_CLUSTER_NAME
        echo "AKS_NAMESPACE:         "$AKS_NAMESPACE
        echo "SUBNET_ID:             "$SUBNET_ID
        echo "VERSION:               "$VERSION
        echo "ACR_NAME:              "$ACR_NAME
        echo "MONGODB_USER:          "$MONGODB_USER
        echo "MONGODB_PASS:          "$MONGODB_PASS
        echo "MONGODB_DBNAME:        "$MONGODB_DBNAME
        ECHO "MONGODB_DNS:           "$MONGODB_DNS
        echo "MONGOCONNECTION:       "$MONGOCONNECTION
        echo "WORKSPACE:             "$WORKSPACE
        echo "WORKSPACE_ID:          "$WORKSPACE_ID
        echo "LOADTEST_API_ENDPOINT: "$LOADTEST_API_ENDPOINT
    fi
fi
