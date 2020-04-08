#!/bin/bash

# Bash script to show the n-number of Azure Container Instances.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-show
# Chris Joakim, 2019/12/16
#
# Usage:
#   $ ./aci-show-instances.sh

source ../app-config.sh

./aci-show-instance.sh $REGION1_RESOURCE
./aci-show-instance.sh $REGION2_RESOURCE
./aci-show-instance.sh $REGION3_RESOURCE
./aci-show-instance.sh $REGION4_RESOURCE
./aci-show-instance.sh $REGION5_RESOURCE

echo 'listing the _show.json files in logs/ directory ...'
ls -alR logs | grep _show.json$

echo 'done'
