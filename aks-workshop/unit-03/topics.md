# Unit 3 - Key Topics

## Azure Container Registry

- Private repository for:
    - Docker and Open Container Initiative (OCI) images
    - Other related artifacts, example - Helm charts

- Azure CLI or Docker CLI to push or pull container images
- Azure portal integration
- Geo-replication (premium tier)
- Image signing with Docker Content Trust

- https://docs.microsoft.com/en-in/azure/container-registry/container-registry-intro
- https://azure.microsoft.com/en-us/pricing/details/container-registry/

## Create a container registry by using the Azure CLI

- CLI, portal, or API
- Clone code for ratings-api and ratings web images from github

## Build container images by using Azure Container Registry Tasks

- Automate builds with triggers, example - on source code commit or base image update
- Suite of features for image building and update
- az acr build

## Verify container images in Azure Container Registry

- az acr repository list

## Configure an AKS cluster to authenticate to an Azure Container Registry

- az aks update

## Other tips

- Delete unused resources in your subscription - especially those using MSDN Visual Studio subscription
