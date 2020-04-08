#!/bin/bash

# Bash script to create an Azure Service Principal with the az CLI.
# Chris Joakim, Microsoft, 2020/03/26
#
# Usage:
#   ./create-service-principal.sh <some-name-of-yours>
#   ./create-service-principal.sh cjoakimaks1
#
# Output looks like the following; actual keys with scrubbed values:
# {
#   "appId": "xxx",
#   "displayName": "cjoakimaks1",
#   "name": "http://cjoakimaks1",
#   "password": "yyy",
#   "tenant": "zzz"
# }

az ad sp create-for-rbac --name $1
