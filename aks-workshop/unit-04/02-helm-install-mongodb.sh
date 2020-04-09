#!/bin/bash

source ../env.sh

# make sure we're working with the right cluster (aksworkshop-cjoakim)
kubectl config get-contexts
kubectl config use-context $AKS_CLUSTER_NAME
kubectl config current-context

echo 'kube-system pods:'
kubectl get pods --namespace $AKS_NAMESPACE

# helm install ratings stable/mongodb \
#     --namespace ratingsapp \
#     --set mongodbUsername=<username>,mongodbPassword=<password>,mongodbDatabase=ratingsdb

# Alternatively, use a yaml file instead of --set
# https://github.com/helm/charts/tree/master/stable/mongodb

echo 'helm install ratings stable/mongodb:'
helm install ratings stable/mongodb --namespace $AKS_NAMESPACE -f mongodb-values.yaml 

echo 'kube-system pods:'
kubectl get pods --namespace $AKS_NAMESPACE

echo 'done'

# Output:
#
# helm install ratings stable/mongodb:
# WARNING: This chart is deprecated
# NAME: ratings
# LAST DEPLOYED: Thu Apr  9 13:45:16 2020
# NAMESPACE: ratingsapp
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# This Helm chart is deprecated

# Given the `stable` deprecation timeline (https://github.com/helm/charts#deprecation-timeline), the Bitnami maintained Helm chart is now located at bitnami/charts (https://github.com/bitnami/charts/).

# The Bitnami repository is already included in the Hubs and we will continue providing the same cadence of updates, support, etc that we've been keeping here these years. Installation instructions are very similar, just adding the _bitnami_ repo and using it during the installation (`bitnami/<chart>` instead of `stable/<chart>`)

# ```bash
# $ helm repo add bitnami https://charts.bitnami.com/bitnami
# $ helm install my-release bitnami/<chart>           # Helm 3
# $ helm install --name my-release bitnami/<chart>    # Helm 2
# ```

# To update an exisiting _stable_ deployment with a chart hosted in the bitnami repository you can execute

# ```bash
# $ helm repo add bitnami https://charts.bitnami.com/bitnami
# $ helm upgrade my-release bitnami/<chart>
# ```

# Issues and PRs related to the chart itself will be redirected to `bitnami/charts` GitHub repository. In the same way, we'll be happy to answer questions related to this migration process in this issue (https://github.com/helm/charts/issues/20969) created as a common place for discussion.

# ** Please be patient while the chart is being deployed **

# MongoDB can be accessed via port 27017 on the following DNS name from within your cluster:

#     ratings-mongodb.ratingsapp.svc.cluster.local

# To get the root password run:

#     export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace ratingsapp ratings-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)

# To get the password for "dwight" run:

#     export MONGODB_PASSWORD=$(kubectl get secret --namespace ratingsapp ratings-mongodb -o jsonpath="{.data.mongodb-password}" | base64 --decode)

# To connect to your database run the following command:

#     kubectl run --namespace ratingsapp ratings-mongodb-client --rm --tty -i --restart='Never' --image docker.io/bitnami/mongodb:4.2.4-debian-10-r0 --command -- mongo admin --host ratings-mongodb --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD

# To connect to your database from outside the cluster execute the following commands:

#     kubectl port-forward --namespace ratingsapp svc/ratings-mongodb 27017:27017 &
#     mongo --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD
# kube-system pods:
# NAME                               READY   STATUS    RESTARTS   AGE
# ratings-mongodb-7b86f64bb7-zw4rj   0/1     Pending   0          1s
# done
