#!/bin/bash

source ../env.sh display

# kubectl create secret generic mongosecret \
#     --namespace ratingsapp \
#     --from-literal=MONGOCONNECTION="mongodb://<username>:<password>@ratings-mongodb.ratingsapp.svc.cluster.local:27017/ratingsdb"

kubectl create secret generic mongosecret \
    --namespace $AKS_NAMESPACE \
    --from-literal=MONGOCONNECTION=$MONGOCONNECTION

echo 'done'

# Output:
# secret/mongosecret created
# done
