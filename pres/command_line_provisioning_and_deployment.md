# command line provisioning and deployment

The scripts and YAML files mentioned on this page are all **generated**;
see [Automated File Generation With Python](python_automation.md)

---

## Start with an Azure Service Principal

The **Service Principal** (SP) is used to dynamically create and manage other Azure resources,
in a roles-based-access-control **RBAC** manner.

See https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal

```
$ az ad sp create-for-rbac --name <your-chosen-sp-name>
```

This CLI command produces a JSON output like this:

```
{
  "appId": "xxx",
  "displayName": "cjoakimaks1",
  "name": "http://cjoakimaks1",
  "password": "yyy",
  "tenant": "zzz"
}
```

I've captured the **appId** and **password** values in environment variables
**AZURE_AKS_SP_APP_ID** and **AZURE_AKS_SP_PASSWORD**, which are used in the 
**az cli commands** below:

---

## Provision the AKS Clusters

Use the AZ CLI to provision the clusters:

```
$ cd admin

$ ./aks-create-1-eastus.sh
$ ./aks-create-2-westeurope.sh
$ ./aks-create-3-centralindia.sh
$ ./aks-create-4-japaneast.sh
$ ./aks-create-5-westus.sh

- or -

$ ./aks-create-all.sh    # to provision all five regions in sequence
```

File **aks-create-1-eastus.sh**, for example, looks like the following:

```
#!/bin/bash

# Generated bash script to provision an AKS custer with the az CLI.
# Chris Joakim, Microsoft
#
# Usage:
#   ./aks-create-1-eastus.sh

source ../app-config.sh

sleep_after_rg_delete_sec=15
sleep_after_rg_create_sec=15
sleep_after_cluster_sec=30
sleep_after_credentials_sec=15

echo "=== aks-create-1-eastus.sh start: $(date)"

echo "deleting resource group cjoakim-atw-aks-1-eastus"
az group delete --name cjoakim-atw-aks-1-eastus --yes

sleep $sleep_after_rg_delete_sec

echo "creating resource group cjoakim-atw-aks-1-eastus in eastus"
az group create --location eastus --name cjoakim-atw-aks-1-eastus

sleep $sleep_after_rg_create_sec

echo "creating aks cluster cjoakim-atw-aks-1-eastus"
az aks create \
    --resource-group cjoakim-atw-aks-1-eastus \
    --name cjoakim-atw-aks-1-eastus \
    --node-count 2 \
    --enable-cluster-autoscaler \
    --min-count 2 \
    --max-count 4 \
    --generate-ssh-keys \
    --attach-acr $AZURE_ACR_NAME \
    --service-principal $AZURE_AKS_SP_APP_ID \
    --client-secret $AZURE_AKS_SP_PASSWORD

# see https://github.com/Azure/azure-cli/issues/9585 re: Service Principal

sleep $sleep_after_cluster_sec

echo "getting credentials for aks cluster cjoakim-atw-aks-1-eastus"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-1-eastus \
    --name cjoakim-atw-aks-1-eastus \
    --overwrite-existing

sleep $sleep_after_credentials_sec

echo 'kubectl config get-contexts'
kubectl config get-contexts

echo "kubectl get nodes for aks cluster cjoakim-atw-aks-1-eastus"
kubectl get nodes

echo "=== aks-create-1-eastus.sh finish: $(date)"
```

---

### Get the AKS Credentials for each Cluster 

```
$ ./aks-get-credentials-all.sh
```

File **aks-get-credentials-all.sh** looks like the following:
```
echo "getting credentials for aks cluster cjoakim-atw-aks-1-eastus"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-1-eastus \
    --name cjoakim-atw-aks-1-eastus \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-2-westeurope"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-2-westeurope \
    --name cjoakim-atw-aks-2-westeurope \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-3-centralindia"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-3-centralindia \
    --name cjoakim-atw-aks-3-centralindia \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-4-japaneast"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-4-japaneast \
    --name cjoakim-atw-aks-4-japaneast \
    --overwrite-existing

echo "getting credentials for aks cluster cjoakim-atw-aks-5-westus"
az aks get-credentials \
    --resource-group cjoakim-atw-aks-5-westus \
    --name cjoakim-atw-aks-5-westus \
    --overwrite-existing

echo 'kubectl config get-contexts'
kubectl config get-contexts
```

---

### Deploy the App to All Clusters

```
$ ./aks-clusters-deploy.sh
```

File **aks-clusters-deploy.sh** looks like the following:
```
#!/bin/bash

# Generated bash script to deploy the ATW app to the n-number
# of AKS clusters.
# Chris Joakim, Microsoft
#
# Usage:
#   $ ./aks-clusters-deploy.sh

sleep_time=10


echo "==="
echo "Deploying to region #1, name: eastus, context: cjoakim-atw-aks-1-eastus"
kubectl config use-context cjoakim-atw-aks-1-eastus
kubectl config current-context
kubectl apply -f kub/atw-1-eastus.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope"
kubectl config use-context cjoakim-atw-aks-2-westeurope
kubectl config current-context
kubectl apply -f kub/atw-2-westeurope.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #3, name: centralindia, context: cjoakim-atw-aks-3-centralindia"
kubectl config use-context cjoakim-atw-aks-3-centralindia
kubectl config current-context
kubectl apply -f kub/atw-3-centralindia.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #4, name: japaneast, context: cjoakim-atw-aks-4-japaneast"
kubectl config use-context cjoakim-atw-aks-4-japaneast
kubectl config current-context
kubectl apply -f kub/atw-4-japaneast.yaml
sleep $sleep_time

echo "==="
echo "Deploying to region #5, name: westus, context: cjoakim-atw-aks-5-westus"
kubectl config use-context cjoakim-atw-aks-5-westus
kubectl config current-context
kubectl apply -f kub/atw-5-westus.yaml
sleep $sleep_time
```

The **kub/atw-5-westus.yaml Deployment YAML** looks like this:
```
# Generated Kubernetes/AKS configuration file
# Usage:
# $ kubectl config get-contexts
# $ kubectl config use-context cjoakim-atw-aks-5-westus
# $ kubectl config current-context
# $ kubectl apply -f kub/atw-5-westus.yaml
# $ kubectl get service atw-web

apiVersion: apps/v1
kind: Deployment
metadata:
  name: atw-web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: atw-web
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        app: atw-web
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: atw-web
        image: cjoakimacr.azurecr.io/azure-around-the-world:v8
        imagePullPolicy: Always
        ports:
        - containerPort: 80
        resources:
          requests: # minimum resources required
            cpu: 250m
            memory: 128Mi
          limits: # maximum resources allocated
            cpu: 500m
            memory: 1Gi
        readinessProbe: # is the container ready to receive traffic?
          httpGet:
            port: 80
            path: /health/ready
          initialDelaySeconds: 60
          timeoutSeconds: 3
        livenessProbe: # is the container healthy?
          httpGet:
            port: 80
            path: /health/alive   
          initialDelaySeconds: 90
          periodSeconds: 300
          timeoutSeconds: 3
          failureThreshold: 5
        env:
        - name: AZURE_RESOURCE_LOC
          value: "westus"
        - name: AZURE_RESOURCE_NAME
          value: "atw"
        - name: AZURE_RESOURCE_NUM
          value: "5"
        - name: AZURE_COSMOSDB_URI
          value: "https://cjoakimcosmossql.documents.azure.com:443/"
        - name: AZURE_COSMOSDB_KEY
          value: "... secret ..."
        - name: AZURE_COSMOSDB_DATABASE
          value: "dev"

---
apiVersion: v1
kind: Service
metadata:
  name: atw-web
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: atw-web
```

---

## Check the Status of the Clusters

```
$ ./aks-clusters-info.sh
```

The **aks-clusters-info.sh** contains this:
```
#!/bin/bash

# Generated bash script to get AKS/ATW cluster info with kubectl.
# Chris Joakim, Microsoft
#
# Usage:
#   $ ./aks-clusters-info.sh > tmp/aks-clusters-info.txt

sleep_time=10


echo "==="
echo "AKS for region #1, name: eastus, context: cjoakim-atw-aks-1-eastus"
kubectl config use-context cjoakim-atw-aks-1-eastus
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope"
kubectl config use-context cjoakim-atw-aks-2-westeurope
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #3, name: centralindia, context: cjoakim-atw-aks-3-centralindia"
kubectl config use-context cjoakim-atw-aks-3-centralindia
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #4, name: japaneast, context: cjoakim-atw-aks-4-japaneast"
kubectl config use-context cjoakim-atw-aks-4-japaneast
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time

echo "==="
echo "AKS for region #5, name: westus, context: cjoakim-atw-aks-5-westus"
kubectl config use-context cjoakim-atw-aks-5-westus
kubectl config current-context

echo 'nodes:'
kubectl get nodes

echo 'pods:'
kubectl get pods

echo 'service: '
kubectl get service atw-web

sleep $sleep_time
```

The output is as follows:
```
===
AKS for region #1, name: eastus, context: cjoakim-atw-aks-1-eastus
Switched to context "cjoakim-atw-aks-1-eastus".
cjoakim-atw-aks-1-eastus
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d21h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d21h   v1.15.10
pods:
NAME                       READY   STATUS    RESTARTS   AGE
atw-web-7d54fd7c96-jj62m   1/1     Running   0          2d2h
service:
NAME      TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
atw-web   LoadBalancer   10.0.250.189   52.149.174.186   80:30940/TCP   2d8h
===
AKS for region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope
Switched to context "cjoakim-atw-aks-2-westeurope".
cjoakim-atw-aks-2-westeurope
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d21h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d21h   v1.15.10
pods:
NAME                       READY   STATUS    RESTARTS   AGE
atw-web-8655856669-6z7qh   1/1     Running   0          2d2h
service:
NAME      TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
atw-web   LoadBalancer   10.0.216.96   51.138.42.147   80:32027/TCP   2d8h
===
AKS for region #3, name: centralindia, context: cjoakim-atw-aks-3-centralindia
Switched to context "cjoakim-atw-aks-3-centralindia".
cjoakim-atw-aks-3-centralindia
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d20h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d20h   v1.15.10
pods:
NAME                      READY   STATUS    RESTARTS   AGE
atw-web-9c465c56f-fbw86   1/1     Running   0          2d2h
service:
NAME      TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
atw-web   LoadBalancer   10.0.46.168   13.71.55.252   80:32315/TCP   2d8h
===
AKS for region #4, name: japaneast, context: cjoakim-atw-aks-4-japaneast
Switched to context "cjoakim-atw-aks-4-japaneast".
cjoakim-atw-aks-4-japaneast
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d20h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d20h   v1.15.10
pods:
NAME                      READY   STATUS    RESTARTS   AGE
atw-web-89fdcf54c-zq5nz   1/1     Running   0          2d2h
service:
NAME      TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
atw-web   LoadBalancer   10.0.91.149   20.44.168.96   80:32305/TCP   2d8h
===
AKS for region #5, name: westus, context: cjoakim-atw-aks-5-westus
Switched to context "cjoakim-atw-aks-5-westus".
cjoakim-atw-aks-5-westus
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d20h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d20h   v1.15.10
pods:
NAME                       READY   STATUS    RESTARTS   AGE
atw-web-7df66dd6f8-74tg7   1/1     Running   0          2d2h
service:
NAME      TYPE           CLUSTER-IP   EXTERNAL-IP    PORT(S)        AGE
atw-web   LoadBalancer   10.0.73.24   13.83.71.106   80:31258/TCP   2d8h
```
