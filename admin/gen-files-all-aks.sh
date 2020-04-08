#!/bin/bash

# Script to generate the AKS shell scripts and yaml files.
# Chris Joakim, Microsoft, 2020/04/02

source bin/activate

echo 'gen-files-1-config.sh ...'
./gen-files-1-config.sh

echo 'gen-files-2-env.sh ...'
sleep 3
./gen-files-2-env.sh

echo 'gen-files-3-aks.sh ...'
sleep 3
source ../app-config.sh

./gen-files-3-aks.sh

echo ''
