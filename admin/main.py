"""
Usage:
  source ../app-config.sh
  python main.py generate_config_json
  python main.py generate_app_config_sh
  python main.py generate_aks_scripts
  python main.py generate_kub_config_yaml
  python main.py generate_kub_cluster_scripts
  python main.py generate_aks_relay_journey tmp/aks-clusters-info.txt
"""

# Python script for various AKS and ATW script and file-generation functions.
# Chris Joakim, Microsoft, 2020/04/08

import arrow
import jinja2
import json
import sys
import time
import os

from docopt import docopt

VERSION = 'v20200408a'


def config_json_filename():
    return 'config.json'

def read_parse_config_json_file():
    with open(config_json_filename()) as f:
        return json.loads(f.read())

def generate_config_json():
    config = dict()
    region_list = 'eastus,westeurope,centralindia,japaneast,westus'.split(',')
    outfile = config_json_filename()
    config['docker_username'] = 'cjoakim'
    config['pom_artifact_id'] = 'azure-around-the-world'
    config['pom_artifact_vers'] = '0.0.5'
    config['container_version'] = 'v10'
    config['region_prefix'] = 'cjoakim-atw'
    config['region_list'] = region_list
    config['region_count'] = len(region_list)

    with open(outfile, "w", newline="\n") as out:
        out.write(json.dumps(config, sort_keys=False, indent=2))
        print("file written: {}".format(outfile))

def generate_app_config_sh():
    config = read_parse_config_json_file()
    print('config loaded:')
    print(json.dumps(config, sort_keys=False, indent=2))

    # facts per config.json which drives the generated ENV VARS created here
    region_list = config['region_list']
    region_count = int(config['region_count'])
    region_prefix = config['region_prefix']
    pom_artifact_id = config['pom_artifact_id']
    pom_artifact_vers = config['pom_artifact_vers']
    docker_username = config['docker_username']
    container_version = config['container_version']

    # generate content from above facts in config.json
    lines = list()
    lines.append('#!/bin/bash')
    lines.append('')
    lines.append('# Generated script that defines common configuration values for this project')
    lines.append('# and is "sourced" by the other bash shell scripts.')
    lines.append('# Usage:')
    lines.append('#   $ ./app-config.sh          (silent)')
    lines.append('#   $ ./app-config.sh display  (verbose)')
    lines.append('# Chris Joakim, Microsoft, generated on: {}'.format(curr_timestamp()))
    lines.append('')
    lines.append('# Maven')
    lines.append('export POM_ARTIFACT_ID="{}"'.format(pom_artifact_id))
    lines.append('export POM_ARTIFACT_VERSION="{}"'.format(pom_artifact_vers))
    lines.append('export MAVEN_TEST_SKIP="true"')
    lines.append('export MAVEN_JAR_FILENAME="target/{}-{}.jar"'.format(
        pom_artifact_id, pom_artifact_vers))
    lines.append('export STANDARD_JAR_FILENAME="target/app.jar"')
    lines.append('')
    lines.append('# Simulated Azure Regions')
    lines.append('export AZURE_RESOURCE_LOC=workstation')
    lines.append('export AZURE_RESOURCE_NAME=atw')
    lines.append('')
    lines.append('# Azure Container Registry (ACR)')
    lines.append('export AZURE_ACR_NAME=$AZURE_ACR_NAME')
    lines.append('export AZURE_ACR_LOGIN_SERVER=$AZURE_ACR_LOGIN_SERVER')
    lines.append('export AZURE_ACR_USER_NAME=$AZURE_ACR_USER_NAME')
    lines.append('export AZURE_ACR_USER_PASS=$AZURE_ACR_USER_PASS')
    lines.append('')
    lines.append('# Docker')
    lines.append('export CONTAINER_SHORTNAME="{}"'.format(pom_artifact_id))
    lines.append('export CONTAINER_VERSION="{}"'.format(container_version))
    lines.append('export DOCKERHUB_USER_NAME="{}"'.format(docker_username))
    lines.append('export DOCKERHUB_CONTAINER_NAME="{}/{}"'.format(
        docker_username, pom_artifact_id))
    lines.append('export DOCKERHUB_CONTAINER_FULLNAME="{}/{}:{}"'.format(
        docker_username, pom_artifact_id, container_version))
    lines.append('export ACR_CONTAINER_SHORTNAME=""$CONTAINER_SHORTNAME":"$CONTAINER_VERSION') 
    lines.append('export ACR_CONTAINER_FULLNAME=""$AZURE_ACR_LOGIN_SERVER"/"$ACR_CONTAINER_SHORTNAME')
    lines.append('')
    lines.append('# Azure CosmosDB w/SQL API, Spring JPA env var names')
    lines.append('export AZURE_COSMOSDB_URI=$AZURE_COSMOSDB_SQLDB_URI')
    lines.append('export AZURE_COSMOSDB_KEY=$AZURE_COSMOSDB_SQLDB_KEY')
    lines.append('export AZURE_COSMOSDB_DATABASE=$AZURE_COSMOSDB_SQLDB_DBNAME')
    lines.append('')

    lines.append('# Azure Service Principal for AKS; see create-service-principal.sh')
    lines.append('export AZURE_AKS_SP_APP_ID=$AZURE_AKS_SP_APP_ID')
    lines.append('export AZURE_AKS_SP_PASSWORD=$AZURE_AKS_SP_PASSWORD')
    lines.append('')
    lines.append('# Azure Regions to deploy to')
    lines.append('export REGION_PREFIX="{}"'.format(region_prefix))
    lines.append('export REGION_COUNT={}'.format(region_count))
    for n in range(region_count):
        lines.append('export REGION{}="{}"'.format(n + 1, region_list[n]))
    lines.append('')
    lines.append('# Azure Container Instances (ACI)')
    for n in range(region_count):
        i = n + 1
        lines.append('export REGION{}_ACI_RESOURCE="{}-aci-{}-{}"'.format(
            i, region_prefix, i, region_list[n]))
    lines.append('')
    lines.append('# Azure Kubernetes Service (AKS)')
    for n in range(region_count):
        i = n + 1
        lines.append('export REGION{}_AKS_RESOURCE="{}-aks-{}-{}"'.format(
            i, region_prefix, i, region_list[n]))
    lines.append('')
    lines.append('export AKS_WEB_SERVICE_NAME="atw-web"')

    # extract the exports for display logic below
    displays = list()
    for line in lines:
        if line.startswith('export '):
            env_var_name = parse_env_var_name(line)
            name_colon   = env_var_name + ':'
            displays.append('echo "{:30} "${}'.format(name_colon, env_var_name))

    lines.append('arg_count=$#')
    lines.append('if [ $arg_count -gt 0 ]')
    lines.append('then')
    lines.append('    if [ $1 == "display" ] ')
    lines.append('    then')
    for line in displays:
        lines.append('        {}'.format(line))
    lines.append('    fi')
    lines.append('fi')
    lines.append('')

    outfile = 'app-config-gen.sh'
    content = "\n".join(lines)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_app_config_displays():
    infile = '../app-config.sh'
    with open(infile) as fp:
        for idx, line in enumerate(fp):
            if line.startswith('export '):
                env_var_name = parse_env_var_name(line)
                name_colon   = env_var_name + ':'
                print('echo "{:30} "${}'.format(name_colon, env_var_name))

def generate_aks_scripts():
    generate_aks_create_scripts()
    generate_aks_create_all_script()
    generate_aks_get_credentials_script()
    generate_aks_delete_script()

def generate_aks_create_scripts():
    template = get_template('aks_create_sh.txt')
    for n in range(1, region_count() + 1):
        values = region_info(n)
        region = values['region']
        outfile = 'aks-create-{}-{}.sh'.format(n, region)
        values['outfile'] = outfile
        content = template.render(values)
        with open(outfile, "w", newline="\n") as out:
            out.write(content)
            print("file written: {}".format(outfile))

def generate_aks_create_all_script():
    values = standard_regions_list_values()
    template = get_template('aks_create_all_sh.txt')
    outfile = 'aks-create-all.sh'
    values['outfile'] = outfile
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_aks_get_credentials_script():
    values = standard_regions_list_values()
    template = get_template('aks_get_credentials_all_sh.txt')
    outfile = 'aks-get-credentials-all.sh'
    values['outfile'] = outfile
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_aks_delete_script():
    values = standard_regions_list_values()
    template = get_template('aks_delete_sh.txt')
    outfile = 'aks-delete.sh'
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_kub_config_yaml():
    template = get_template('atw-all.yaml')
    gen_time = curr_timestamp()

    for n in range(1, region_count() + 1):
        values = dict()  # Jinga will merge these values into the template
        values['gen_time'] = gen_time
        region = os.environ['REGION{}'.format(n)]
        service = os.environ['AKS_WEB_SERVICE_NAME']
        outfile = kub_deploy_filename(n, region)

        values['context'] = kub_context_name(n, region)
        values['web_service_name'] = service
        values['yaml_filename'] = outfile
        values['AZURE_RESOURCE_LOC'] = region
        values['AZURE_RESOURCE_NUM'] = n
        values['AZURE_RESOURCE_NAME'] = 'atw'
        values['ACR_CONTAINER_FULLNAME']  = os.environ['ACR_CONTAINER_FULLNAME']
        values['AZURE_COSMOSDB_URI']      = os.environ['AZURE_COSMOSDB_URI']
        values['AZURE_COSMOSDB_KEY']      = os.environ['AZURE_COSMOSDB_KEY']
        values['AZURE_COSMOSDB_DATABASE'] = os.environ['AZURE_COSMOSDB_DATABASE']
        content = template.render(values)

        with open(outfile, "w", newline="\n") as out:
            out.write(content)
            print("file written: {}".format(outfile))

def generate_aks_clusters_deploy_script():
    values = standard_regions_list_values()
    template = get_template('aks_clusters_deploy_sh.txt')
    outfile = 'aks-clusters-deploy.sh'
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_aks_clusters_info_script():
    values = standard_regions_list_values()
    template = get_template('aks_clusters_info_sh.txt')

    outfile = 'aks-clusters-info.sh'
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_aks_clusters_health_script():
    infile = relay_planet_aks_journey_filename()
    values, targets, route = dict(), list(), load_json_file(infile)['route']
    values['targets'] = targets
    for url in route:
        url_tokens = url.split('/')
        ip = url_tokens[2]
        region = url_tokens[-1].split('-')[-1]
        targets.append([ip, region])

    template = get_template('aks_clusters_health_sh.txt')
    outfile = 'aks-clusters-health.sh'
    content = template.render(values)
    with open(outfile, "w", newline="\n") as out:
        out.write(content)
        print("file written: {}".format(outfile))

def generate_aks_relay_journey(cluster_status_file):
    # this method uses the output of the following command
    # ./aks-clusters-info.sh > tmp/aks-clusters-info.txt
    print('generate_aks_relay_journey: {}'.format(cluster_status_file))
    outfile = relay_planet_aks_journey_filename()
    urls, journey = list(), dict()

    with open('journeys/relay-empty.json', 'r') as journey_skeleton:
        journey = json.loads(journey_skeleton.read())

    curr_context = ''
    with open(cluster_status_file) as fp:
        for idx, line in enumerate(fp):
            # ===
            # AKS for region #5, name: westus, context: cjoakim-atw-aks-5-westus
            # NAME      TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
            # atw-web   LoadBalancer   10.0.192.90   13.91.195.219   80:30166/TCP   2m32s
            tokens = line.strip().split()
            if ' context: ' in line:
                curr_context = tokens[-1]
            if ' LoadBalancer ' in line:
                tokens = line.strip().split()
                xip = tokens[3]
                print(line.strip())
                url = 'http://{}:80/journey/relay?info={}'.format(xip, curr_context)
                urls.append(url)
    urls.append(urls[0])
    urls.pop(0)
    journey['route'] = urls

    with open(outfile, "w", newline="\n") as out:
        out.write(json.dumps(journey, sort_keys=False, indent=2))
        print("file written: {}".format(outfile))

def region_count():
    return int(os.environ['REGION_COUNT'])

def standard_regions_list_values():
    values = dict()
    values['gen_time'] = curr_timestamp()
    values['region_list'] = region_info_list()
    return values

def region_info_list():
    region_list = list()
    for n in range(1, region_count() + 1):
        region_list.append(region_info(n))
    return region_list

def region_info(n):
    data = {}
    region = os.environ['REGION{}'.format(n)]
    context = kub_context_name(n, region)
    data['gen_time'] = curr_timestamp()
    data['num'] = n
    data['region'] = region
    data['context'] = context
    data['service'] = os.environ['AKS_WEB_SERVICE_NAME']
    data['az_rg'] = azure_rg_name(n, region)
    data['az_aks_res'] = azure_aks_resource_name(n, region)
    data['create_script'] = 'aks-create-{}-{}.sh'.format(n, region)
    data['deploy_yaml'] = kub_deploy_filename(n, region)
    return data

def load_json_file(infile):
    with open(infile, 'rt') as json_file:
        return json.loads(str(json_file.read()))

def azure_rg_name(region_num, region_name):
    return 'cjoakim-atw-aks-{}-{}'.format(region_num, region_name)

def azure_aks_resource_name(region_num, region_name):
    return 'cjoakim-atw-aks-{}-{}'.format(region_num, region_name)

def kub_context_name(region_num, region_name):
    return 'cjoakim-atw-aks-{}-{}'.format(region_num, region_name)

def kub_deploy_filename(region_num, region_name):
    return 'kub/atw-{}-{}.yaml'.format(region_num, region_name)

def relay_planet_aks_journey_filename():
    return 'journeys/relay-planet-aks.json'

def curr_timestamp():
    return arrow.now('America/New_York').format('YYYY-MM-DD HH:mm:s')

def get_jinja2_env():
    return jinja2.Environment(
        loader = jinja2.FileSystemLoader(
            os.path.dirname (__file__)), autoescape=True)

def get_template(name):
    filename = 'templates/{}'.format(name)
    return get_jinja2_env().get_template(filename)

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
        if func == 'generate_config_json':
            generate_config_json()
        elif func == 'generate_app_config_sh':
            generate_app_config_sh()
        elif func == 'generate_aks_scripts':
            generate_aks_scripts()
        elif func == 'generate_kub_config_yaml':
            generate_kub_config_yaml()
        elif func == 'generate_kub_cluster_scripts':
            generate_aks_clusters_deploy_script()
            generate_aks_clusters_info_script()
            generate_aks_clusters_health_script()
        elif func == 'generate_aks_relay_journey':
            cluster_status_file = sys.argv[2]
            generate_aks_relay_journey(cluster_status_file)
        else:
            print_options('Error: invalid function: {}'.format(func))
    else:
        print_options('Error: no function argument provided.')
