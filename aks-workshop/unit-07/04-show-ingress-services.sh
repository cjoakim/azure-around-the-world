#!/bin/bash

source ../env.sh

echo ''
echo '=== kubectl --namespace ingress get services; all'
kubectl --namespace ingress get services -o wide

echo ''
echo '=== kubectl --namespace ingress get services; nginx-ingress-controller'
kubectl --namespace ingress get services -o wide nginx-ingress-controller

echo 'done'
