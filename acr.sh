#!/bin/bash

# Bash and az CLI script to interact with Azure Container Registry.
# Chris Joakim, 2020/04/13

source app-config.sh

arg_count=$#

display_help() {
    echo "script options:"
    echo "  ./acr.sh           (default: login, list, show, tag, push, list, show)"
    echo "  ./acr.sh login"
    echo "  ./acr.sh list"
    echo "  ./acr.sh show"
    echo "  ./acr.sh tag"
    echo "  ./acr.sh push"
}

login() {
    echo "az acr login: "$AZURE_ACR_NAME
    az acr login --name $AZURE_ACR_NAME
}

list() {
    echo "az acr repository list: "$AZURE_ACR_NAME
    az acr repository list --name $AZURE_ACR_NAME --output json
}

show() {
    echo "az acr repository show-tags: "$AZURE_ACR_NAME" image: "$CONTAINER_SHORTNAME
    az acr repository show-tags --name $AZURE_ACR_NAME --repository $CONTAINER_SHORTNAME

    echo "az acr repository show: "$ACR_CONTAINER_FULLNAME" image: "$ACR_CONTAINER_SHORTNAME
    az acr repository show --name $AZURE_ACR_NAME --image $ACR_CONTAINER_SHORTNAME
}

tag() {
    echo "docker tag source: "$DOCKERHUB_CONTAINER_FULLNAME
    echo "docker tag target: "$ACR_CONTAINER_FULLNAME
    docker tag $DOCKERHUB_CONTAINER_FULLNAME $ACR_CONTAINER_FULLNAME 
    docker images --all | grep $DOCKERHUB_USER_NAME"/" | grep $POM_ARTIFACT_ID | grep latest 
    docker images --all | grep $AZURE_ACR_NAME | grep $POM_ARTIFACT_ID | grep latest 
}

push() {
    # $ source ./app-config.sh ; env | grep DOCKERHUB_CONTAINER_FULLNAME
    # DOCKERHUB_CONTAINER_FULLNAME=cjoakim/azure-around-the-world:v10

    # $ source ./app-config.sh ; env | grep ACR_CONTAINER_FULLNAME
    # ACR_CONTAINER_FULLNAME=cjoakimacr.azurecr.io/azure-around-the-world:v10

    echo "docker push: "$ACR_CONTAINER_FULLNAME
    docker push $ACR_CONTAINER_FULLNAME
}

if [ $arg_count -gt 0 ]
then
    if [ $1 == "help" ] 
    then
        display_help
    fi

    if [ $1 == "login" ] 
    then
        login
    fi

    if [ $1 == "list" ] 
    then
        list
    fi

    if [ $1 == "show" ] 
    then
        show
    fi

    if [ $1 == "tag" ] 
    then
        tag
    fi

    if [ $1 == "push" ] 
    then
        push
    fi
else
    login
    list
    show
    tag
    push
    list
    show
fi

echo 'done'
