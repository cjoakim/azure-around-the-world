#!/bin/bash

source ../env.sh

echo 'kubectl get nodes:'

kubectl get nodes -w

echo 'done'
