#!/bin/bash

source ../env.sh

helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# "stable" has been added to your repositories

helm search repo stable

helm search repo stable | grep stable/mongo 

echo 'done'
