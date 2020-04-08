#!/bin/bash

# Bash script with AZ CLI to list the Azure Regions/Locations available
# to your subscription.
# Chris Joakim, 2020/03/23
#
# See https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest

# az login

az account list-locations > data/azure-regions.json
