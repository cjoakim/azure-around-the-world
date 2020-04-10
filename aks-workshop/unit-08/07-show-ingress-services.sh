#!/bin/bash

source ../env.sh

echo ''
echo '=== kubectl --namespace ingress get services; all'
kubectl --namespace ingress get services -o wide

echo ''
echo '=== kubectl --namespace ingress get services; nginx-ingress-controller'
kubectl --namespace ingress get services -o wide nginx-ingress-controller

echo 'done'

# Output:
# === kubectl --namespace ingress get services; all
# NAME                            TYPE           CLUSTER-IP   EXTERNAL-IP      PORT(S)                      AGE   SELECTOR
# nginx-ingress-controller        LoadBalancer   10.2.0.103   104.45.188.200   80:30929/TCP,443:30518/TCP   19h   app.kubernetes.io/component=controller,app=nginx-ingress,release=nginx-ingress
# nginx-ingress-default-backend   ClusterIP      10.2.0.192   <none>           80/TCP                       19h   app.kubernetes.io/component=default-backend,app=nginx-ingress,release=nginx-ingress

# === kubectl --namespace ingress get services; nginx-ingress-controller
# NAME                       TYPE           CLUSTER-IP   EXTERNAL-IP      PORT(S)                      AGE   SELECTOR
# nginx-ingress-controller   LoadBalancer   10.2.0.103   104.45.188.200   80:30929/TCP,443:30518/TCP   19h   app.kubernetes.io/component=controller,app=nginx-ingress,release=nginx-ingress
# done