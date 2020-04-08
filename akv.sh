#!/bin/bash

# Bash script with AZ CLI to automate the creation/deletion of an
# Azure Key Vault account.
# Chris Joakim, 2020/04/07
#
# See https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest

# az login

source app-config.sh

export akv_region="eastus"
export akv_rg="cjoakimakv"
export akv_name="cjoakimakv"
export akv_sku="standard" 
export subscription=$AZURE_SUBSCRIPTION_ID 

arg_count=$#

delete() {
    echo 'deleting AKV rg: '$akv_rg
    az group delete \
        --name $akv_rg \
        --subscription $subscription \
        --yes \
        > data/output/akv_rg_delete.json
}

create() {
    echo 'creating AKV rg: '$akv_rg
    az group create \
        --location $akv_region \
        --name $akv_rg \
        --subscription $subscription \
        > data/output/akv_rg_create.json

    echo 'creating AKV acct: '$akv_name
    az keyvault create \
        --name $akv_name \
        --resource-group $akv_rg \
        --location $akv_region \
        --sku $akv_sku \
        --subscription $subscription \
        --enabled-for-deployment true \
        --enabled-for-template-deployment true \
        > data/output/akv_create.json

    set_secrets
}

set_secrets() {
    echo 'setting secrets in: '$akv_name
    az keyvault secret set \
        --vault-name $akv_name \
        --name  AcrName \
        --value $AZURE_ACR_NAME

    az keyvault secret set \
        --vault-name $akv_name \
        --name  AcrUserName \
        --value $AZURE_ACR_USER_NAME

    az keyvault secret set \
        --vault-name $akv_name \
        --name  AcrUserPass \
        --value $AZURE_ACR_USER_PASS

    az keyvault secret set \
        --vault-name $akv_name \
        --name  AcrLoginServer \
        --value $AZURE_ACR_LOGIN_SERVER

    az keyvault secret set \
        --vault-name $akv_name \
        --name  SibscriptionId \
        --value $AZURE_SUBSCRIPTION_ID
}

recreate() {
    delete
    create
    info 
}

info() {
    echo 'AKV show: '$akv_name
    az keyvault show \
        --name $akv_name \
        --resource-group $akv_rg \
        --subscription $subscription \
        > data/output/akv_show.json

    echo 'AKV key list: '$akv_name
    az keyvault key list \
        --vault-name $akv_name \
        --subscription $subscription \
        > data/output/akv_key_list.json

    echo 'AKV secret list: '$akv_name
    az keyvault secret list \
        --vault-name $akv_name \
        --subscription $subscription \
        --maxresults 25 \
        > data/output/akv_secret_list.json

    echo 'AKV secret show: '$akv_name
    az keyvault secret show \
        --name  AcrName \
        --vault-name $akv_name \
        --subscription $subscription
        > data/output/akv_secret_show_AcrName.json

    echo 'AKV secret show: '$akv_name
    az keyvault secret show \
        --name  AcrUserName \
        --vault-name $akv_name \
        --subscription $subscription
        > data/output/akv_secret_show_AcrUserName.json

    echo 'AKV secret show: '$akv_name
    az keyvault secret show \
        --name  AcrUserPass \
        --vault-name $akv_name \
        --subscription $subscription
        > data/output/akv_secret_show_AcrUserPass.json

    echo 'AKV secret show: '$akv_name
    az keyvault secret show \
        --name  AcrLoginServer \
        --vault-name $akv_name \
        --subscription $subscription
        > data/output/akv_secret_show_AcrLoginServer.json

    echo 'AKV secret show: '$akv_name
    az keyvault secret show \
        --name  SibscriptionId \
        --vault-name $akv_name \
        --subscription $subscription
        > data/output/akv_secret_show_SibscriptionId.json
}

display_usage() {
    echo 'Usage:'
    echo './akv.sh delete'
    echo './akv.sh create'
    echo './akv.sh recreate'
    echo './akv.sh set_secrets'
    echo './akv.sh info'
}

if [ $arg_count -gt 0 ]
then
    if [ $1 == "delete" ] 
    then
        delete
        exit 0  
    fi

    if [ $1 == "create" ] 
    then
        create
        exit 0
    fi

    if [ $1 == "recreate" ] 
    then
        recreate
        exit 0
    fi

    if [ $1 == "set_secrets" ] 
    then
        set_secrets
        info
        exit 0
    fi

    if [ $1 == "info" ] 
    then
        info
        exit 0
    fi

    display_usage
else
    display_usage
fi

echo 'done'
