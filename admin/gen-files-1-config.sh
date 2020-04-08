#!/bin/bash

# Bash and Python script to generate the 'config.json' file.
# This is intended as a one-time bootstrapping process for a clone
# of this project; config.json will contain YOUR specific project values.
# Alternatively, just manually edit the values in 'config.json'.
# Chris Joakim, Microsoft, 2020/03/25

source bin/activate

python main.py generate_config_json

echo ''
echo 'your config.json is shown below:'
echo ''

cat config.json

echo ''
