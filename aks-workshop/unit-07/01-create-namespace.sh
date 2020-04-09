#!/bin/bash

source ../env.sh

# make sure we're working with the right cluster (aksworkshop-cjoakim)
kubectl config get-contexts
kubectl config use-context $AKS_CLUSTER_NAME
kubectl config current-context

kubectl create namespace ingress

echo 'done'

# Output:
# Switched to context "aksworkshop-cjoakim".
# aksworkshop-cjoakim
# namespace/ingress created
# done
