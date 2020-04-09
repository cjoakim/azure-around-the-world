#!/bin/bash

source ../env.sh

kubectl get endpoints ratings-api --namespace $AKS_NAMESPACE

echo 'done'

# Output:
# NAME          ENDPOINTS          AGE
# ratings-api   10.240.0.37:3000   106s
# done
