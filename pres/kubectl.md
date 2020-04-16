# Interact with your clusters with kubectl

The AKS cluster(s) has been provisioned.   Now what?

---

## First, Get the Cluster Credentials for the kubectl program

The az CLI command looks like this:
```
az aks get-credentials \
    --resource-group cjoakim-atw-aks-1-eastus \
    --name cjoakim-atw-aks-1-eastus \
    --overwrite-existing
```

Get the credentials for all five clusters with this script:
```
$ ./aks-get-credentials-all.sh

getting credentials for aks cluster cjoakim-atw-aks-1-eastus
Merged "cjoakim-atw-aks-1-eastus" as current context in /Users/cjoakim/.kube/config
getting credentials for aks cluster cjoakim-atw-aks-2-westeurope
Merged "cjoakim-atw-aks-2-westeurope" as current context in /Users/cjoakim/.kube/config
getting credentials for aks cluster cjoakim-atw-aks-3-centralindia
Merged "cjoakim-atw-aks-3-centralindia" as current context in /Users/cjoakim/.kube/config
getting credentials for aks cluster cjoakim-atw-aks-4-japaneast
Merged "cjoakim-atw-aks-4-japaneast" as current context in /Users/cjoakim/.kube/config
getting credentials for aks cluster cjoakim-atw-aks-5-westus
Merged "cjoakim-atw-aks-5-westus" as current context in /Users/cjoakim/.kube/config
```

Notice how these are all stored in **~/.kube/config** on your computer.

---

## What Clusters can I interact with?

[Contexts](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)

```
$ kubectl config get-contexts

CURRENT   NAME                             CLUSTER                          AUTHINFO                                                                    NAMESPACE
          aksworkshop-cjoakim              aksworkshop-cjoakim              clusterUser_aksworkshop_aksworkshop-cjoakim
          cjoakim-atw-aks-1-eastus         cjoakim-atw-aks-1-eastus         clusterUser_cjoakim-atw-aks-1-eastus_cjoakim-atw-aks-1-eastus
          cjoakim-atw-aks-2-westeurope     cjoakim-atw-aks-2-westeurope     clusterUser_cjoakim-atw-aks-2-westeurope_cjoakim-atw-aks-2-westeurope
          cjoakim-atw-aks-3-centralindia   cjoakim-atw-aks-3-centralindia   clusterUser_cjoakim-atw-aks-3-centralindia_cjoakim-atw-aks-3-centralindia
          cjoakim-atw-aks-4-japaneast      cjoakim-atw-aks-4-japaneast      clusterUser_cjoakim-atw-aks-4-japaneast_cjoakim-atw-aks-4-japaneast
*         cjoakim-atw-aks-5-westus         cjoakim-atw-aks-5-westus         clusterUser_cjoakim-atw-aks-5-westus_cjoakim-atw-aks-5-westus
```

---

## What Cluster is kubectl currently pointing to?

It's the one with the asterisk in the above list.

```
$ kubectl config current-context

cjoakim-atw-aks-5-westus
```

---

## How do I remove a cluster from this list?

```
$ kubectl config delete-context cjoakim-atw-aks-1-eastus2
```

Note: this doesn't delete the cluster.  It just removes it from your local list in ~/.kube/config.

---

## How do point to a given cluster?

```
$ kubectl config use-context cjoakim-atw-aks-1-eastus
```

---

## How do I list the nodes in the current context/cluster?

A **node** is a VM in the cluster.

```
$ kubectl get nodes

NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   11d   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   11d   v1.15.10
```

## How do I list the deployed pods in the current context/cluster?

A **pod** is a related set of one or more containers that are deployed to a given VM.

Immutable.

```
$ kubectl get pods

NAME                       READY   STATUS    RESTARTS   AGE
atw-web-5768c766bd-mtc7n   1/1     Running   0          7d3h
```

---

## How do I deploy/redeploy my India cluster?

**apply** a **kubernetes yaml file**

```
$ kubectl config get-contexts

$ kubectl config use-context cjoakim-atw-aks-3-centralindia

$ kubectl apply -f kub/atw-3-centralindia.yaml
```

---

## How do I see the list of services in a cluster?

[Services](https://kubernetes.io/docs/concepts/services-networking/service/)

```
$ kubectl get service atw-web
$ kubectl get service


NAME         TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
atw-web      LoadBalancer   10.0.46.168   13.71.55.252   80:32315/TCP   11d
kubernetes   ClusterIP      10.0.0.1      <none>         443/TCP        11d
```

```
$ kubectl --namespace xxx get services 
```

---

## How to I create an AKS Secret?

[Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

This is covered in the upcoming workshop.

```
$ kubectl create secret ...
```

---

## How to I create an AKS Namespace?

[Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

This is covered in the upcoming workshop.

```
$ kubectl create namespace ...
```

---

## How do I see the list of namespaces in a cluster?

```
$ kubectl get namespace

NAME              STATUS   AGE
default           Active   11d
kube-node-lease   Active   11d
kube-public       Active   11d
kube-system       Active   11d
```

---

## What other kubectl commands are available?

[kubectl cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

```
$ kubectl

kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create        Create a resource from a file or from stdin.
  expose        Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run           Run a particular image on the cluster
  set           Set specific features on objects

Basic Commands (Intermediate):
  explain       Documentation of resources
  get           Display one or many resources
  edit          Edit a resource on the server
  delete        Delete resources by filenames, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout       Manage the rollout of a resource
  scale         Set a new size for a Deployment, ReplicaSet or Replication Controller
  autoscale     Auto-scale a Deployment, ReplicaSet, or ReplicationController

Cluster Management Commands:
  certificate   Modify certificate resources.
  cluster-info  Display cluster info
  top           Display Resource (CPU/Memory/Storage) usage.
  cordon        Mark node as unschedulable
  uncordon      Mark node as schedulable
  drain         Drain node in preparation for maintenance
  taint         Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe      Show details of a specific resource or group of resources
  logs          Print the logs for a container in a pod
  attach        Attach to a running container
  exec          Execute a command in a container
  port-forward  Forward one or more local ports to a pod
  proxy         Run a proxy to the Kubernetes API server
  cp            Copy files and directories to and from containers.
  auth          Inspect authorization

Advanced Commands:
  diff          Diff live version against would-be applied version
  apply         Apply a configuration to a resource by filename or stdin
  patch         Update field(s) of a resource using strategic merge patch
  replace       Replace a resource by filename or stdin
  wait          Experimental: Wait for a specific condition on one or many resources.
  convert       Convert config files between different API versions
  kustomize     Build a kustomization target from a directory or a remote url.

Settings Commands:
  label         Update the labels on a resource
  annotate      Update the annotations on a resource
  completion    Output shell completion code for the specified shell (bash or zsh)

Other Commands:
  alpha         Commands for features in alpha
  api-resources Print the supported API resources on the server
  api-versions  Print the supported API versions on the server, in the form of "group/version"
  config        Modify kubeconfig files
  plugin        Provides utilities for interacting with plugins.
  version       Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands)
```
