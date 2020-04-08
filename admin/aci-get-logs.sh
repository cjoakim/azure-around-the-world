#!/bin/bash

# Bash script to download the logs from the Azure Container Instances.
# See https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest#az-container-logs
# Chris Joakim, 2019/12/16
#
# Usage:
#   $ ./aci-get-logs.sh

source ../app-config.sh

./aci-get-log.sh $REGION1_RESOURCE
./aci-get-log.sh $REGION2_RESOURCE
./aci-get-log.sh $REGION3_RESOURCE
./aci-get-log.sh $REGION4_RESOURCE
./aci-get-log.sh $REGION5_RESOURCE

echo 'listing the _log.txt files in logs/ directory ...'
ls -alR logs | grep _log.txt$

echo 'done'
