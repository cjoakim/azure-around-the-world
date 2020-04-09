#!/bin/bash

source ../env.sh

kubectl get namespace

echo 'done'

# Output:
# NAME              STATUS   AGE
# default           Active   26h
# ingress           Active   3m34s
# kube-node-lease   Active   26h
# kube-public       Active   26h
# kube-system       Active   26h
# ratingsapp        Active   26h
# done
