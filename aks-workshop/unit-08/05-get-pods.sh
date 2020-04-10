#!/bin/bash

source ../env.sh

echo ''
echo 'kubectl get pods for ALL namespaces'
kubectl get pods --all-namespaces

echo ''
echo 'kubectl get pods for cert-manager namespace'
kubectl get pods --namespace cert-manager

echo 'done'
