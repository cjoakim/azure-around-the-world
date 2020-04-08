#!/bin/bash

# Bash and Python scripts to generate shell scripts and yaml
# files for the AKS clusters.
# Chris Joakim, Microsoft, 2020/03/27
#
# Sample output:
# file written: aks-create.sh
# file written: aks-delete.sh
# file written: kub/atw-1-eastus.yaml
# file written: kub/atw-2-westeurope.yaml
# file written: kub/atw-3-centralindia.yaml
# file written: kub/atw-4-japaneast.yaml
# file written: kub/atw-5-westus.yaml
# file written: kub-deploy.sh
# file written: kub-info.sh

source ../app-config.sh
source bin/activate

python main.py generate_aks_scripts
python main.py generate_kub_config_yaml
python main.py generate_kub_cluster_scripts

chmod 744 *.sh

cluster_info_file='tmp/aks-clusters-info.txt'

if [ -f $cluster_info_file ]
then
  python main.py generate_aks_relay_journey $cluster_info_file
fi

echo 'done'
