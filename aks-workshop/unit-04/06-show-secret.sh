#!/bin/bash

source ../env.sh display

kubectl describe secret mongosecret --namespace $AKS_NAMESPACE

echo 'done'

# Output:
# Name:         mongosecret
# Namespace:    ratingsapp
# Labels:       <none>
# Annotations:  <none>

# Type:  Opaque

# Data
# ====
# MONGOCONNECTION:  86 bytes
# done
