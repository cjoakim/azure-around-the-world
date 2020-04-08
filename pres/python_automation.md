# automated file generation with python

This repo uses Python 3 and Jinja2 Templates to generate **bash & az cli scripts**,
as well as the **Kubernetes YAML files**.  Python excels at tasks like this.

The things generated are:
- az CLI bash scripts to provision the AKS clusters
- az CLI bash scripts to administer and deploy to the AKS clusters
- Kubernetes YAML files used in the deployments

---

## But Why?

Because I get distracted easily, and manual editing of these many things is error-prone for me.
The files get generated from a relatively few hardcoded values in **main.py**.
It is a high-quality, automated, and repeatable process.

This is a personal practice/preference/convention, not necessarily a Microsoft or AKS recommended practice.

---

## Generating the Files

```
$ cd admin/
$ ./gen-files-all-aks.sh


file written: config.json
your config.json is shown below:

{
  "docker_username": "cjoakim",
  "pom_artifact_id": "azure-around-the-world",
  "pom_artifact_vers": "0.0.5",
  "container_version": "v8",
  "region_prefix": "cjoakim-atw",
  "region_list": [
    "eastus",
    "westeurope",
    "centralindia",
    "japaneast",
    "westus"
  ],
  "region_count": 5
}

...

file written: app-config-gen.sh

...

file written: aks-create-1-eastus.sh
file written: aks-create-2-westeurope.sh
file written: aks-create-3-centralindia.sh
file written: aks-create-4-japaneast.sh
file written: aks-create-5-westus.sh
file written: aks-create-all.sh
file written: aks-get-credentials-all.sh
file written: aks-delete.sh
file written: kub/atw-1-eastus.yaml
file written: kub/atw-2-westeurope.yaml
file written: kub/atw-3-centralindia.yaml
file written: kub/atw-4-japaneast.yaml
file written: kub/atw-5-westus.yaml
file written: aks-clusters-deploy.sh
file written: aks-clusters-info.sh

generate_aks_relay_journey: tmp/aks-clusters-info.txt
atw-web   LoadBalancer   10.0.250.189   52.149.174.186   80:30940/TCP   4h59m
atw-web   LoadBalancer   10.0.216.96   51.138.42.147   80:32027/TCP   4h59m
atw-web   LoadBalancer   10.0.46.168   13.71.55.252   80:32315/TCP   4h59m
atw-web   LoadBalancer   10.0.91.149   20.44.168.96   80:32305/TCP   4h59m
atw-web   LoadBalancer   10.0.73.24   13.83.71.106   80:31258/TCP   4h59m
file written: journeys/relay-planet-aks.json

done
```

### Other Solutions

- https://helm.sh
- https://learnk8s.io/templating-yaml-with-code 
- https://blog.argoproj.io/the-state-of-kubernetes-configuration-management-d8b06c1205
