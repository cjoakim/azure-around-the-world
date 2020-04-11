# Azure Foundations for Azure Kubernetes Service (AKS)

## Azure Portal

- Dashboard
- Provisioning Resources
- Views
- Cost Management
- [Logging, Monitoring, Alerts](https://azure.microsoft.com/en-us/services/monitor/)
- [Management Heirarchy - EA, Subscriptions, Resource Groups](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/)

```
EA
    Subscription 1
        Resource Group 1a
        Resource Group 1b
    Subscription 2
        Resource Group 2a
        Resource Group 2b
        Resource Group 2x
```

---

## Breadth of Offerings

- [Offerings](https://docs.microsoft.com/en-us/azure/?product=all)
- The Role of the **Azure Cloud Solution Architect**

---

## Docker and Containers

- [Azure Container Registry (ACR)](https://azure.microsoft.com/en-us/services/container-registry/)
- [Azure Container Instances (ACI)](https://azure.microsoft.com/en-us/services/container-instances/)
- [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-us/services/kubernetes-service/)
- [Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/environment/intro)
- [Azure Batch & Shipyard](https://docs.microsoft.com/en-us/azure/batch/batch-technical-overview)
- [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image)
- [Azure Logic Apps & ACI Example](https://github.com/cjoakim/azure-logicapp-blob-aci-dotnet)

---

## Automation - with the Command Line Interface

- [Azure Command Line Interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

### Get --help for any command and level of detail 

```
az --help
az acr --help
az acr create --help
```

### Example - Create and Use an Azure Container Registry

```
az login 

az acr create \
    --resource-group $RESOURCE_GROUP \
    --location $REGION_NAME \
    --name $AZURE_ACR_NAME \
    --sku Standard

az acr login --name $AZURE_ACR_NAME

az acr repository show-tags --name $AZURE_ACR_NAME --repository $CONTAINER_SHORTNAME

az acr repository show --name $AZURE_ACR_NAME --image $ACR_CONTAINER_SHORTNAME

az acr repository list --name $AZURE_ACR_NAME --output json

# two ways to push an image to ACR:

docker push $ACR_CONTAINER_FULLNAME

az acr build \
    --registry $ACR_NAME \
    --image ratings-api:v1 .
```

---

## Automation - ARM Templates

- [Azure Resource Manager (ARM)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview)
  - Desired State Configuration
  - JSON templates and parameters - **ARM Templates**
  - Can either be authored in an IDE, or exported from existing Azure resources/groups
  - Submit an ARM deploment with PowerShell or az CLI
  - https://github.com/cjoakim/azure-logicapp-blob-aci-dotnet/blob/master/automation/deploy-logic-app.sh

### Example ARM Deployment using the az CLI

Environment variables can be used (i.e. - $resource_group)

```
echo 'Create the Resource Group (RG) with command: az group create...'
az group create --name $resource_group --location $rg_region

echo 'Deploy to the Resource Group (RG) with command: az group deployment create...'
az group deployment create \
  --name $dep_name \
  --resource-group $resource_group \
  --template-file template.json \
  --parameters @parameters.json
```

**PowerShell** can also be used to submit an ARM template.
