#!/bin/bash

source ../env.sh

echo '=== kubectl delete service'

kubectl delete service --namespace $AKS_NAMESPACE ratings-web

echo 'done'
