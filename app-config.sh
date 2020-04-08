#!/bin/bash

# Generated script that defines common configuration values for this project
# and is "sourced" by the other bash shell scripts.
# Usage:
#   $ ./app-config.sh          (silent)
#   $ ./app-config.sh display  (verbose)
# Chris Joakim, Microsoft, generated on: 2020-04-08 09:51:50

# Maven
export POM_ARTIFACT_ID="azure-around-the-world"
export POM_ARTIFACT_VERSION="0.0.5"
export MAVEN_TEST_SKIP="true"
export MAVEN_JAR_FILENAME="target/azure-around-the-world-0.0.5.jar"
export STANDARD_JAR_FILENAME="target/app.jar"

# Simulated Azure Regions
export AZURE_RESOURCE_LOC=workstation
export AZURE_RESOURCE_NAME=atw

# Azure Container Registry (ACR)
export AZURE_ACR_NAME=$AZURE_ACR_NAME
export AZURE_ACR_LOGIN_SERVER=$AZURE_ACR_LOGIN_SERVER
export AZURE_ACR_USER_NAME=$AZURE_ACR_USER_NAME
export AZURE_ACR_USER_PASS=$AZURE_ACR_USER_PASS

# Docker
export CONTAINER_SHORTNAME="azure-around-the-world"
export CONTAINER_VERSION="v10"
export DOCKERHUB_USER_NAME="cjoakim"
export DOCKERHUB_CONTAINER_NAME="cjoakim/azure-around-the-world"
export DOCKERHUB_CONTAINER_FULLNAME="cjoakim/azure-around-the-world:v10"
export ACR_CONTAINER_SHORTNAME=""$CONTAINER_SHORTNAME":"$CONTAINER_VERSION
export ACR_CONTAINER_FULLNAME=""$AZURE_ACR_LOGIN_SERVER"/"$ACR_CONTAINER_SHORTNAME

# Azure CosmosDB w/SQL API, Spring JPA env var names
export AZURE_COSMOSDB_URI=$AZURE_COSMOSDB_SQLDB_URI
export AZURE_COSMOSDB_KEY=$AZURE_COSMOSDB_SQLDB_KEY
export AZURE_COSMOSDB_DATABASE=$AZURE_COSMOSDB_SQLDB_DBNAME

# Azure Service Principal for AKS; see create-service-principal.sh
export AZURE_AKS_SP_APP_ID=$AZURE_AKS_SP_APP_ID
export AZURE_AKS_SP_PASSWORD=$AZURE_AKS_SP_PASSWORD

# Azure Regions to deploy to
export REGION_PREFIX="cjoakim-atw"
export REGION_COUNT=5
export REGION1="eastus"
export REGION2="westeurope"
export REGION3="centralindia"
export REGION4="japaneast"
export REGION5="westus"

# Azure Container Instances (ACI)
export REGION1_ACI_RESOURCE="cjoakim-atw-aci-1-eastus"
export REGION2_ACI_RESOURCE="cjoakim-atw-aci-2-westeurope"
export REGION3_ACI_RESOURCE="cjoakim-atw-aci-3-centralindia"
export REGION4_ACI_RESOURCE="cjoakim-atw-aci-4-japaneast"
export REGION5_ACI_RESOURCE="cjoakim-atw-aci-5-westus"

# Azure Kubernetes Service (AKS)
export REGION1_AKS_RESOURCE="cjoakim-atw-aks-1-eastus"
export REGION2_AKS_RESOURCE="cjoakim-atw-aks-2-westeurope"
export REGION3_AKS_RESOURCE="cjoakim-atw-aks-3-centralindia"
export REGION4_AKS_RESOURCE="cjoakim-atw-aks-4-japaneast"
export REGION5_AKS_RESOURCE="cjoakim-atw-aks-5-westus"

export AKS_WEB_SERVICE_NAME="atw-web"
arg_count=$#
if [ $arg_count -gt 0 ]
then
    if [ $1 == "display" ] 
    then
        echo "POM_ARTIFACT_ID:               "$POM_ARTIFACT_ID
        echo "POM_ARTIFACT_VERSION:          "$POM_ARTIFACT_VERSION
        echo "MAVEN_TEST_SKIP:               "$MAVEN_TEST_SKIP
        echo "MAVEN_JAR_FILENAME:            "$MAVEN_JAR_FILENAME
        echo "STANDARD_JAR_FILENAME:         "$STANDARD_JAR_FILENAME
        echo "AZURE_RESOURCE_LOC:            "$AZURE_RESOURCE_LOC
        echo "AZURE_RESOURCE_NAME:           "$AZURE_RESOURCE_NAME
        echo "AZURE_ACR_NAME:                "$AZURE_ACR_NAME
        echo "AZURE_ACR_LOGIN_SERVER:        "$AZURE_ACR_LOGIN_SERVER
        echo "AZURE_ACR_USER_NAME:           "$AZURE_ACR_USER_NAME
        echo "AZURE_ACR_USER_PASS:           "$AZURE_ACR_USER_PASS
        echo "CONTAINER_SHORTNAME:           "$CONTAINER_SHORTNAME
        echo "CONTAINER_VERSION:             "$CONTAINER_VERSION
        echo "DOCKERHUB_USER_NAME:           "$DOCKERHUB_USER_NAME
        echo "DOCKERHUB_CONTAINER_NAME:      "$DOCKERHUB_CONTAINER_NAME
        echo "DOCKERHUB_CONTAINER_FULLNAME:  "$DOCKERHUB_CONTAINER_FULLNAME
        echo "ACR_CONTAINER_SHORTNAME:       "$ACR_CONTAINER_SHORTNAME
        echo "ACR_CONTAINER_FULLNAME:        "$ACR_CONTAINER_FULLNAME
        echo "AZURE_COSMOSDB_URI:            "$AZURE_COSMOSDB_URI
        echo "AZURE_COSMOSDB_KEY:            "$AZURE_COSMOSDB_KEY
        echo "AZURE_COSMOSDB_DATABASE:       "$AZURE_COSMOSDB_DATABASE
        echo "AZURE_AKS_SP_APP_ID:           "$AZURE_AKS_SP_APP_ID
        echo "AZURE_AKS_SP_PASSWORD:         "$AZURE_AKS_SP_PASSWORD
        echo "REGION_PREFIX:                 "$REGION_PREFIX
        echo "REGION_COUNT:                  "$REGION_COUNT
        echo "REGION1:                       "$REGION1
        echo "REGION2:                       "$REGION2
        echo "REGION3:                       "$REGION3
        echo "REGION4:                       "$REGION4
        echo "REGION5:                       "$REGION5
        echo "REGION1_ACI_RESOURCE:          "$REGION1_ACI_RESOURCE
        echo "REGION2_ACI_RESOURCE:          "$REGION2_ACI_RESOURCE
        echo "REGION3_ACI_RESOURCE:          "$REGION3_ACI_RESOURCE
        echo "REGION4_ACI_RESOURCE:          "$REGION4_ACI_RESOURCE
        echo "REGION5_ACI_RESOURCE:          "$REGION5_ACI_RESOURCE
        echo "REGION1_AKS_RESOURCE:          "$REGION1_AKS_RESOURCE
        echo "REGION2_AKS_RESOURCE:          "$REGION2_AKS_RESOURCE
        echo "REGION3_AKS_RESOURCE:          "$REGION3_AKS_RESOURCE
        echo "REGION4_AKS_RESOURCE:          "$REGION4_AKS_RESOURCE
        echo "REGION5_AKS_RESOURCE:          "$REGION5_AKS_RESOURCE
        echo "AKS_WEB_SERVICE_NAME:          "$AKS_WEB_SERVICE_NAME
    fi
fi
