# sample journey spec

This JSON is HTTP-posted to http://52.149.174.186:80/journey/relay?info=cjoakim-atw-aks-1-eastus.

The journey finishes back at the originating region, **eastus**.

```
{
  "pk": "j1586113616",
  "function": "relay",
  "originLocation": "",
  "originResourceName": "",
  "originStartEpoch": -1,
  "originFinishEpoch": -1,
  "elapsedMs": -1,
  "currentLocation": "",
  "currentResourceName": "",
  "currentRouteIndex": -1,
  "nextUrl": "none",
  "verbose": false,
  "persistPolicy": "final",
  "route": [
    "http://51.138.42.147:80/journey/relay?info=cjoakim-atw-aks-2-westeurope",
    "http://13.71.55.252:80/journey/relay?info=cjoakim-atw-aks-3-centralindia",
    "http://20.44.168.96:80/journey/relay?info=cjoakim-atw-aks-4-japaneast",
    "http://13.83.71.106:80/journey/relay?info=cjoakim-atw-aks-5-westus",
    "http://52.149.174.186:80/journey/relay?info=cjoakim-atw-aks-1-eastus"
  ],
  "messages": []
}
```

---

Note: These endpoints were mined from the output of the following **kubectl** commands.
See **aks-clusters-info.sh**

```
kubectl config use-context cjoakim-atw-aks-1-eastus
kubectl config current-context
kubectl get nodes
kubectl get pods
kubectl get service atw-web
```

The output from See **aks-clusters-info.sh** looks like the following.
Note how the **kubernetes contexts** (i.e. - 'cjoakim-atw-aks-1-eastus')
and **EXTERNAL-IP** addresses are displayed.

```
===
AKS for region #1, name: eastus, context: cjoakim-atw-aks-1-eastus
Switched to context "cjoakim-atw-aks-1-eastus".
cjoakim-atw-aks-1-eastus
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d19h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d19h   v1.15.10
pods:
NAME                       READY   STATUS    RESTARTS   AGE
atw-web-7d54fd7c96-jj62m   1/1     Running   0          2d
service:
NAME      TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
atw-web   LoadBalancer   10.0.250.189   52.149.174.186   80:30940/TCP   2d6h

===
AKS for region #2, name: westeurope, context: cjoakim-atw-aks-2-westeurope
Switched to context "cjoakim-atw-aks-2-westeurope".
cjoakim-atw-aks-2-westeurope
nodes:
NAME                                STATUS   ROLES   AGE     VERSION
aks-nodepool1-19869207-vmss000000   Ready    agent   2d19h   v1.15.10
aks-nodepool1-19869207-vmss000001   Ready    agent   2d19h   v1.15.10
pods:
NAME                       READY   STATUS    RESTARTS   AGE
atw-web-8655856669-6z7qh   1/1     Running   0          2d
service:
NAME      TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
atw-web   LoadBalancer   10.0.216.96   51.138.42.147   80:32027/TCP   2d6h

...

```
 