#!/bin/bash

source ../env.sh display

az acr build \
    --registry $ACR_NAME \
    --image ratings-api:v1 .

echo 'done'


# Output:
# ...
# 2020/04/09 14:47:16 Successfully pushed image: aksworkshopcjoakim.azurecr.io/ratings-api:v1
# 2020/04/09 14:47:16 Step ID: build marked as successful (elapsed time in seconds: 27.294611)
# 2020/04/09 14:47:16 Populating digests for step ID: build...
# 2020/04/09 14:47:18 Successfully populated digests for step ID: build
# 2020/04/09 14:47:18 Step ID: push marked as successful (elapsed time in seconds: 26.443200)
# 2020/04/09 14:47:18 The following dependencies were found:
# 2020/04/09 14:47:18
# - image:
#     registry: aksworkshopcjoakim.azurecr.io
#     repository: ratings-api
#     tag: v1
#     digest: sha256:80716ad0287d40618022c17bc4801510cb6ef1b9ac5ce2c6c105f0072f99fd38
#   runtime-dependency:
#     registry: registry.hub.docker.com
#     repository: library/node
#     tag: 13.5-alpine
#     digest: sha256:a5a7ff4267a810a019c7c3732b3c463a892a61937d84ee952c34af2fb486058d
#   git: {}

# Run ID: ca1 was successful after 1m1s
# done
