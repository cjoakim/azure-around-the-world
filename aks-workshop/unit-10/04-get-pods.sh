#!/bin/bash

source ../env.sh

echo 'kubectl get pods for ALL namespaces'
kubectl get pods --all-namespaces

echo 'kubectl get pods for app namespace'
kubectl get pods \
    --namespace $AKS_NAMESPACE

echo 'kubectl get pods for ratings-api:'
kubectl get pods \
    --namespace $AKS_NAMESPACE \
    -l app=ratings-api
    # -w

echo 'kubectl get deployment ratings-api:'
kubectl get deployment ratings-api --namespace $AKS_NAMESPACE

echo 'done'
