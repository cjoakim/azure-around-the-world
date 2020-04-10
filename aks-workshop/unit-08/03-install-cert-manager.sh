#!/bin/bash

source ../env.sh

kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.14/deploy/manifests/00-crds.yaml

echo 'done'

# Output:
# customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
# customresourcedefinition.apiextensions.k8s.io/certificates.cert-manager.io created
# customresourcedefinition.apiextensions.k8s.io/challenges.acme.cert-manager.io created
# customresourcedefinition.apiextensions.k8s.io/clusterissuers.cert-manager.io created
# customresourcedefinition.apiextensions.k8s.io/issuers.cert-manager.io created
# customresourcedefinition.apiextensions.k8s.io/orders.acme.cert-manager.io created
# done
