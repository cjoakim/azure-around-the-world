"""
Usage:
  python http-client.py get_health_alive http://52.149.174.186
  python http-client.py get_health_ready http://52.149.174.186
  -
  python http-client.py post_journey_relay http://127.0.0.1:3000 relay-local-3.json [pk]
  python http-client.py post_journey_relay http://52.149.174.186 relay-planet-aks.json [pk]
  -
  python http-client.py get_journey_by_pk http://52.149.174.186 [pk]
  python http-client.py get_journey_by_pk http://52.149.174.186 april3_1451
  python http-client.py get_journey_by_id_and_pk [id] [pk]
  python http-client.py get_journey_by_id_and_pk http://52.149.174.186 65461ae7-2420-4057-84b3-82e3ed38cd14 april3_1343
  -
  python http-client.py delete_all_journey_docs http://127.0.0.1:3000 delete_all.json
"""

# Python HTTP Client program for the ATW application.
# Chris Joakim, Microsoft, 2020/04/07

import json
import os
import sys
import time
import uuid 

import requests

from docopt import docopt

VERSION = 'v20200403a'


class AtwHttpClient:

    def __init__(self):
        self.u = None  # the current url
        self.r = None  # the current requests response object
        self.config = dict()
        self.user_agent = {'User-agent': 'Mozilla/5.0'}

    def initialize(self):
        self.config = self.load_json_file(self.aci_config_json_filename())

    def get_health_ready(self, target):
        endpoint = '{}/health/ready'.format(target)
        self.execute_get(endpoint, {'f': 'get_health_ready'})

    def get_health_alive(self, target):
        endpoint = '{}/health/alive'.format(target)
        self.execute_get(endpoint, {'f': 'get_health_alive'})

    def post_journey_relay(self, target, infile, pk):
        # target is a partial URL like this: http://52.179.113.199
        # infile is a json file in the journeys directory, like relay-planet-aks.json
        endpoint = '{}/journey/relay'.format(target)
        print('post_journey_relay endpoint: {}'.format(endpoint))
        postobj  = self.load_json_file('journeys/{}'.format(infile))
        postobj['pk'] = pk
        f = 'post_journey_relay_{}'.format(pk)
        self.execute_post(endpoint, postobj, {'f': f})

    def delete_all_journey_docs(self, target, infile):
        endpoint = '{}/journey/delete_all'.format(target)
        postobj  = self.load_json_file('journeys/{}'.format(infile))
        self.execute_post(endpoint, postobj, {'f': 'delete_all_journey_docs'})

    def get_journey_by_id_and_pk(self, target, id, pk):
        endpoint = '{}/journey/getbyid/{}/pk/{}'.format(target, id, pk)
        f = 'get_journey_by_id_and_pk_{}_{}'.format(id, pk)
        self.execute_get(endpoint, {'f': f})

    def get_journey_by_pk(self, target, pk):
        endpoint = '{}/journey/getbypk/{}'.format(target, pk)
        f = 'get_journey_by_pk_{}'.format(pk)
        self.execute_get(endpoint, {'f': f})

    def execute_get(self, endpoint, opts=dict()):
        print('execute_get, endpoint: {}'.format(endpoint))
        r = requests.get(url=endpoint) 
        print('response: {}'.format(r))

        if r.status_code == 200:
            resp_obj = json.loads(r.text)
            print(json.dumps(resp_obj, sort_keys=False, indent=2))
            if len(opts.keys()) > 0:
                p = dict()
                p['endpoint'] = endpoint
                p['resp'] = str(r)
                p['resp_obj'] = resp_obj
                outfile = 'tmp/{}_{}.json'.format(int(self.epoch()), opts['f'])
                self.write_json_file(p, outfile)

    def execute_post(self, endpoint, postobj, opts):
        print('===')
        print('execute_post, endpoint: {}'.format(endpoint))
        print(json.dumps(postobj, sort_keys=False, indent=2))
        print('')
        r = requests.post(url=endpoint, json=postobj) 
        print('---')
        print('response: {}'.format(r))

        if r.status_code == 200:
            resp_obj = json.loads(r.text)
            print(json.dumps(resp_obj, sort_keys=False, indent=2))
            if 'save_to_file' in opts:
                p = dict()
                p['endpoint'] = endpoint
                p['postobj']  = postobj
                p['resp'] = str(r)
                p['resp_obj'] = resp_obj
                self.write_json_file(p, 'tmp/post.json')

    def epoch(self):
        return time.time()
    
    def aci_config_json_filename(self):
        return 'data/aci-config.json'

    def load_config(self):
        with open(self.aci_config_json_filename(), 'rt') as json_file:
            self.data = json.loads(str(json_file.read()))

    def create_aci_config_json(self):
        data, targets = dict(), dict()
        data['targets'] = targets
        targets['0']  = 'http://localhost:3000'
        targets['11'] = 'http://cjoakim-atw-aci-1-eastus.eastus.azurecontainer.io:80'
        targets['12'] = 'http://cjoakim-atw-aci-2-northeurope.northeurope.azurecontainer.io:80'
        targets['13'] = 'http://cjoakim-atw-aci-3-centralindia.centralindia.azurecontainer.io:80'
        targets['14'] = 'http://cjoakim-atw-aci-4-japaneast.japaneast.azurecontainer.io:80'
        targets['15'] = 'http://cjoakim-atw-aci-5-westus.westus.azurecontainer.io:80'
        self.write_json_file(data, self.aci_config_json_filename())

    def write_json_file(self, obj, outfile):
        with open(outfile, 'wt') as f:
            f.write(json.dumps(obj, sort_keys=False, indent=2))
            print('file written: {}'.format(outfile))

    def load_json_file(self, infile):
        with open(infile, 'rt') as json_file:
            return json.loads(str(json_file.read()))

def print_options(msg):
    print(msg)
    arguments = docopt(__doc__, version=VERSION)
    print(arguments)


if __name__ == "__main__":
    # print(sys.argv)

    if len(sys.argv) > 1:
        func = sys.argv[1].lower()
        client = AtwHttpClient()
        client.initialize()

        if func == 'get_health_ready':
            target = sys.argv[2].lower()
            client.get_health_ready(target)

        elif func == 'get_health_alive':
            target = sys.argv[2].lower()
            client.get_health_alive(target)

        elif func == 'get_journey_by_id_and_pk':
            target = sys.argv[2].lower()
            id = sys.argv[3]
            pk = sys.argv[4]
            client.get_journey_by_id_and_pk(target, id, pk)

        elif func == 'get_journey_by_pk':
            target = sys.argv[2].lower()
            pk = sys.argv[3]
            client.get_journey_by_pk(target, pk)

        elif func == 'post_journey_relay':
            target = sys.argv[2].lower()
            infile = sys.argv[3]
            if len(sys.argv) > 4:
                pk = sys.argv[4]
            else:
                pk = str(int(time.time()))
            client.post_journey_relay(target, infile, pk)

        elif func == 'delete_all_journey_docs':
            target = sys.argv[2].lower()
            infile = sys.argv[3]
            client.delete_all_journey_docs(target, infile)

        elif func == 'create_aci_config_json':
            client.create_aci_config_json()
    
        else:
            print_options('Error: invalid function: {}'.format(func))
    else:
        print_options('Error: no function argument provided.')