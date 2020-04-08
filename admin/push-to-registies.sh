#!/bin/bash

# Bash script to push the built local container to DockerHub or Azure Container Registry.
# Chris Joakim, 2020/01/02
#
# Usage:
#   $ ./push-to-registies.sh dockerhub 
#   $ ./push-to-registies.sh acr 
#   $ ./push-to-registies.sh both 
#   $ ./push-to-registies.sh help 

source ../app-config.sh

source_image=""$DOCKERHUB_CONTAINER_FULLNAME
target_image=""$ACR_CONTAINER_FULLNAME

echo "source_image: "$DOCKERHUB_CONTAINER_FULLNAME
echo "target_image: "$ACR_CONTAINER_FULLNAME

display_help() {
    echo "script options:"
    echo "  ./push-to-registies.sh dockerhub"
    echo "  ./push-to-registies.sh acr"
    echo "  ./push-to-registies.sh both"
    echo "  ./push-to-registies.sh help"
}

push_to_dockerhub() {
    echo "pushing to dockerhub ..."
    docker login -u $DOCKERHUB_USER_NAME -p $DOCKERHUB_USER_PASS
    docker push $source_image
}

push_to_acr() {
    echo "==="
    echo 'az acr login ...'
    az acr login --name $AZURE_ACR_USER_NAME

    echo "current azure acr list ..."
    az acr repository list --name $AZURE_ACR_NAME --output json

    echo "==="
    echo "tagging ..."
    docker tag $source_image $target_image  #cjoakimacr.azurecr.io/azure-around-the-world:latest

    echo "==="  
    echo "pushing to acr ..."
    docker push $target_image  # cjoakimacr.azurecr.io/azure-around-the-world:latest

    echo "==="
    echo "updated azure acr list ..."
    az acr repository list --name $AZURE_ACR_NAME --output json

    echo "az acr repository show: "$POM_ARTIFACT_ID
    az acr repository show --name $AZURE_ACR_NAME --image $POM_ARTIFACT_ID --output json
}

if [ $arg_count -gt 0 ]
then
    if [ $1 == "dockerhub" ] 
    then
        push_to_dockerhub
    fi

    if [ $1 == "acr" ] 
    then
        push_to_acr 
    fi

    if [ $1 == "both" ] 
    then
        push_to_dockerhub
        push_to_acr 
    fi

    if [ $1 == "help" ] 
    then
        display_help 
    fi
else
    display_help
fi
