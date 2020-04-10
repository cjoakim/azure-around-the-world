#!/bin/bash

source ../env.sh

helm repo add jetstack https://charts.jetstack.io
helm repo update

echo 'done'

# Output:
# "jetstack" has been added to your repositories
# Hang tight while we grab the latest from your chart repositories...
# ...Successfully got an update from the "jetstack" chart repository
# ...Successfully got an update from the "stable" chart repository
# Update Complete. ⎈ Happy Helming!⎈
# done
