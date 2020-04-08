#!/bin/bash

# This bash script is "sourced" by the shell scripts in this workshop 
# to define environment variables:
#
# Use:
#   In shell scripts:  source ../env.sh 
#   In terminal:       env.sh display

# Base environment variables:
REGION_NAME=eastus
RESOURCE_GROUP=aksworkshop
SUBNET_NAME=aks-subnet
VNET_NAME=aks-vnet
AKS_CLUSTER_NAME=aksworkshop-cjoakim   # don't use this name!

# Environment variables added while executing this workshop:
SUBNET_ID="/subscriptions/61761119-d249-4507-90c6-a16517e1874c/resourceGroups/aksworkshop/providers/Microsoft.Network/virtualNetworks/aks-vnet/subnets/aks-subnet"
VERSION="1.16.7"

arg_count=$#
if [ $arg_count -gt 0 ]
then
    if [ $1 == "display" ] 
    then
        echo "REGION_NAME:        "$REGION_NAME
        echo "RESOURCE_GROUP:     "$RESOURCE_GROUP
        echo "SUBNET_NAME:        "$SUBNET_NAME
        echo "VNET_NAME:          "$VNET_NAME
        echo "AKS_CLUSTER_NAME:   "$AKS_CLUSTER_NAME
        echo "SUBNET_ID:          "$SUBNET_ID
        echo "VERSION:            "$VERSION
    fi
fi
