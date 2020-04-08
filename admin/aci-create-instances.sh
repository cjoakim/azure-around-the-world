#!/bin/bash

# Bash script to create the n-number of Azure Resource Groups
# with their Azure Container Instances.
# Invokes the aci-create-instance.sh script for each RG and ACI.
# Chris Joakim, 2020/03/16
#
# Usage:
#   ./aci-create-instances.sh dry-run
#   ./aci-create-instances.sh provision

source ../app-config.sh

MODE=specify-as-first-cli-arg-as-shown-above

if [ $arg_count -gt 0 ]
then
    MODE=$1
fi

./aci-create-instance.sh $MODE $REGION1 $REGION1_ACI_RESOURCE $REGION1_ACI_RESOURCE
./aci-create-instance.sh $MODE $REGION2 $REGION2_ACI_RESOURCE $REGION2_ACI_RESOURCE
./aci-create-instance.sh $MODE $REGION3 $REGION3_ACI_RESOURCE $REGION3_ACI_RESOURCE
./aci-create-instance.sh $MODE $REGION4 $REGION4_ACI_RESOURCE $REGION4_ACI_RESOURCE
./aci-create-instance.sh $MODE $REGION5 $REGION5_ACI_RESOURCE $REGION5_ACI_RESOURCE

echo 'done'
