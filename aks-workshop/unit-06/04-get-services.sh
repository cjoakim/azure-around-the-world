#!/bin/bash

source ../env.sh

echo 'kubectl get service ratings-api:'
kubectl get service ratings-api --namespace $AKS_NAMESPACE

echo 'kubectl get service ratings-web:'
kubectl get service ratings-web --namespace $AKS_NAMESPACE

echo 'done'

# Output:
# kubectl get service ratings-api:
# NAME          TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# ratings-api   ClusterIP   10.2.0.116   <none>        80/TCP    107m
# kubectl get service ratings-web:
# NAME          TYPE           CLUSTER-IP   EXTERNAL-IP      PORT(S)        AGE
# ratings-web   LoadBalancer   10.2.0.131   52.186.100.168   80:31493/TCP   4m46s
# done

# Visit the EXTERNAL-IP with your browser: http://52.186.100.168/
