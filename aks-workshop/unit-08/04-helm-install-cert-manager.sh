#!/bin/bash

source ../env.sh

helm install cert-manager \
    --namespace cert-manager \
    --version v0.14.0 \
    jetstack/cert-manager

echo 'done'

# Output:
# NAME: cert-manager
# LAST DEPLOYED: Fri Apr 10 12:04:30 2020
# NAMESPACE: cert-manager
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# cert-manager has been deployed successfully!

# In order to begin issuing certificates, you will need to set up a ClusterIssuer
# or Issuer resource (for example, by creating a 'letsencrypt-staging' issuer).

# More information on the different types of issuers and how to configure them
# can be found in our documentation:

# https://docs.cert-manager.io/en/latest/reference/issuers.html

# For information on how to configure cert-manager to automatically provision
# Certificates for Ingress resources, take a look at the `ingress-shim`
# documentation:

# https://docs.cert-manager.io/en/latest/reference/ingress-shim.html
# done
