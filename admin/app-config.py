"""
Usage:
  python app-config.py gen_app_config_displays
"""

# Python script to read the app-config.sh script, scan it for exports,
# and generate the (tedious) echo statements for that script.
# Chris Joakim, Microsoft, 2020/01/02

import json
import sys
import time
import os

from docopt import docopt

VERSION = 'v20200102a'

def gen_app_config_displays():
    infile = '../app-config.sh'
    with open(infile) as fp:
        for idx, line in enumerate(fp):
            if line.startswith('export '):
                env_var_name = parse_env_var_name(line)
                name_colon   = env_var_name + ':'
                print('echo "{:30} "${}'.format(name_colon, env_var_name))

def parse_env_var_name(line):
    name_with_suffix = line.split()[1]
    return name_with_suffix.split('=')[0]

def print_options(msg):
    print(msg)
    arguments = docopt(__doc__, version=VERSION)
    print(arguments)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        func = sys.argv[1].lower()
        if func == 'gen_app_config_displays':
            gen_app_config_displays()
        else:
            print_options('Error: invalid function: {}'.format(func))
    else:
        print_options('Error: no function argument provided.')
