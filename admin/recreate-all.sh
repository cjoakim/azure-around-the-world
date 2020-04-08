#!/bin/bash

# Bash shell script to delete then recreate the ACI and AKS RGs and Resources.
# Chris Joakim, Microsoft, 2020/01/02

source ../app-config.sh
sleep_seconds=60

echo ''
echo '=== DELETE RESOURCE GROUPS ==='
./app-delete-rgs.sh

echo ''
echo 'sleeping for '$sleep_seconds
sleep $sleep_seconds

echo ''
echo '=== ACI CREATE INSTANCES ==='
./aci-create-instances.sh dry-run
./aci-create-instances.sh provision

echo ''
echo 'sleeping for '$sleep_seconds
sleep $sleep_seconds

echo ''
echo '=== AKS CREATE INSTANCES ==='
./aks-create-instances.sh dry-run
./aks-create-instances.sh provision

echo ''
echo 'recreate-all.sh script complete'
