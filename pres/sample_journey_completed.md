# sample completed journey

The **messages** array in the JSON document is **aggregated** as the Journey visits
each HTTP endpoint around the world.

Note how the **buildUser** and **buildDate** is in the messages;
these values are "baked into" the container at build time.
These values come from the build_user.txt and build_date.txt resources
embedded into the JAR file at maven build/compile time.

This particular journey took **555 milliseconds** to traverse the 5-hop route of 
**AKS deployments within the Azure Network**.

```
{
  "id": "3996a261-cdb6-441c-8481-aa38416c1d15",
  "pk": "j1586280492",
  "function": "relay",
  "originLocation": "eastus",
  "originResourceName": "atw",
  "originStartEpoch": 1586280493013,
  "originFinishEpoch": 1586280493568,
  "elapsedMs": 555,
  "currentLocation": "eastus",
  "currentResourceName": "atw",
  "currentRouteIndex": 5,
  "nextUrl": "http://52.149.174.186:80/journey/relay?info=cjoakim-atw-aks-1-eastus",
  "verbose": false,
  "persistPolicy": "final",
  "route": [
    "http://51.138.42.147:80/journey/relay?info=cjoakim-atw-aks-2-westeurope",
    "http://13.71.55.252:80/journey/relay?info=cjoakim-atw-aks-3-centralindia",
    "http://20.44.168.96:80/journey/relay?info=cjoakim-atw-aks-4-japaneast",
    "http://13.83.71.106:80/journey/relay?info=cjoakim-atw-aks-5-westus",
    "http://52.149.174.186:80/journey/relay?info=cjoakim-atw-aks-1-eastus"
  ],
  "messages": [
    "2020-04-07T17:28:13.013Z[GMT]: ---",
    "2020-04-07T17:28:13.013Z[GMT]: received @ eastus resource: atw routeIndex: 0 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.013Z[GMT]: journey starting -> http://51.138.42.147:80/journey/relay?info=cjoakim-atw-aks-2-westeurope",
    "2020-04-07T17:28:13.013Z[GMT]: shouldPersistNow -> false",
    "2020-04-07T17:28:13.077Z[GMT]: ---",
    "2020-04-07T17:28:13.077Z[GMT]: received @ westeurope resource: atw routeIndex: 1 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.077Z[GMT]: journey continuing -> http://13.71.55.252:80/journey/relay?info=cjoakim-atw-aks-3-centralindia",
    "2020-04-07T17:28:13.077Z[GMT]: shouldPersistNow -> false",
    "2020-04-07T17:28:13.265Z[GMT]: ---",
    "2020-04-07T17:28:13.265Z[GMT]: received @ centralindia resource: atw routeIndex: 2 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.265Z[GMT]: journey continuing -> http://20.44.168.96:80/journey/relay?info=cjoakim-atw-aks-4-japaneast",
    "2020-04-07T17:28:13.265Z[GMT]: shouldPersistNow -> false",
    "2020-04-07T17:28:13.362Z[GMT]: ---",
    "2020-04-07T17:28:13.362Z[GMT]: received @ japaneast resource: atw routeIndex: 3 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.362Z[GMT]: journey continuing -> http://13.83.71.106:80/journey/relay?info=cjoakim-atw-aks-5-westus",
    "2020-04-07T17:28:13.362Z[GMT]: shouldPersistNow -> false",
    "2020-04-07T17:28:13.461Z[GMT]: ---",
    "2020-04-07T17:28:13.462Z[GMT]: received @ westus resource: atw routeIndex: 4 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.462Z[GMT]: journey continuing -> http://52.149.174.186:80/journey/relay?info=cjoakim-atw-aks-1-eastus",
    "2020-04-07T17:28:13.462Z[GMT]: shouldPersistNow -> false",
    "2020-04-07T17:28:13.568Z[GMT]: ---",
    "2020-04-07T17:28:13.568Z[GMT]: received @ eastus resource: atw routeIndex: 5 buildUser: vsts buildDate: Tue Apr  7 17:14:24 UTC 2020",
    "2020-04-07T17:28:13.568Z[GMT]: journey finished, elapsedMs 555",
    "2020-04-07T17:28:13.568Z[GMT]: shouldPersistNow -> true -> PERSIST_POLICY_FINAL"
  ],
  "relay": true,
  "completed": true
}
```

## Executing a Journey

```
$ cd admin
$ ./journey.sh
```
