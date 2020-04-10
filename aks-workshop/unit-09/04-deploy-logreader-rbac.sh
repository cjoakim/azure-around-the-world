#!/bin/bash

source ../env.sh display

kubectl apply -f logreader-rbac.yaml

echo 'done'

# Output:
# clusterrole.rbac.authorization.k8s.io/containerHealth-log-reader created
# clusterrolebinding.rbac.authorization.k8s.io/containerHealth-read-logs-global created
# done

