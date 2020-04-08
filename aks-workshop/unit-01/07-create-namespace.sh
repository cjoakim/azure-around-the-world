#!/bin/bash

source ../env.sh 

echo 'kubectl get namespace - initial'

kubectl get namespace

echo 'kubectl create namespace'

kubectl create namespace ratingsapp

# Note: *ratingsapp* is in the docs, should be simply ratingsapp

echo 'kubectl get namespace - after namespace create'

kubectl get namespace

echo 'done'
