#!/bin/bash

# Bash script to restart the Azure Container Instances.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-restart
# Chris Joakim, 2019/12/16
#
# Usage:
#   $ ./aci-restart-instances.sh

source ../app-config.sh

./aci-restart-instance.sh $REGION1_RESOURCE
./aci-restart-instance.sh $REGION2_RESOURCE
./aci-restart-instance.sh $REGION3_RESOURCE
./aci-restart-instance.sh $REGION4_RESOURCE
./aci-restart-instance.sh $REGION5_RESOURCE

echo 'listing the _restart.txt files in logs/ directory ...'
ls -alR logs | grep _restart.txt$

echo 'done'
