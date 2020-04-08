#!/bin/bash

# Bash and Python scripts to generate the 'app-config.sh' bash shell
# script which is used/sourced by this project.  It will contain generated
# values per your 'config.json' file, see file gen-files-1-config.sh
# Chris Joakim, Microsoft, 2020/03/25

# create a backup copy of the original file
cp ../app-config.sh ../app-config-bak.sh 

source ../app-config.sh
source bin/activate

python main.py generate_app_config_sh

chmod 744 app-config-gen.sh

cp app-config-gen.sh ../app-config.sh

echo ''
echo 'display the new/generated values'
source ../app-config.sh display

echo ''
echo 'display the old vs new diffs:'
diff ../app-config-bak.sh ../app-config.sh

echo 'done'
