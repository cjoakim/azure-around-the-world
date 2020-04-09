#!/bin/bash

source ../env.sh display

az acr build \
    --registry $ACR_NAME \
    --image ratings-web:v1 .

echo 'done'

# Output:
# ...
# 2020/04/09 14:58:23 Successfully pushed image: aksworkshopcjoakim.azurecr.io/ratings-web:v1
# 2020/04/09 14:58:23 Step ID: build marked as successful (elapsed time in seconds: 243.509353)
# 2020/04/09 14:58:23 Populating digests for step ID: build...
# 2020/04/09 14:58:26 Successfully populated digests for step ID: build
# 2020/04/09 14:58:26 Step ID: push marked as successful (elapsed time in seconds: 31.237749)
# 2020/04/09 14:58:26 The following dependencies were found:
# 2020/04/09 14:58:26
# - image:
#     registry: aksworkshopcjoakim.azurecr.io
#     repository: ratings-web
#     tag: v1
#     digest: sha256:33b25a66658126a9702a659b46f8702b0379789c1410503dc29f1e487db8412e
#   runtime-dependency:
#     registry: registry.hub.docker.com
#     repository: library/node
#     tag: 13.5-alpine
#     digest: sha256:a5a7ff4267a810a019c7c3732b3c463a892a61937d84ee952c34af2fb486058d
#   git: {}

# Run ID: ca3 was successful after 4m46s
# done
