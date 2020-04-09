#!/bin/bash

source ../env.sh

echo 'helm ls'
helm ls --namespace $AKS_NAMESPACE

# helm uninstall ratings --namespace ratingsapp

echo 'done'
