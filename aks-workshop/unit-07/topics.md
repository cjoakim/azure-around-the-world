# Unit 7 - Key Topics

- https://docs.microsoft.com/en-us/learn/modules/aks-workshop/07-deploy-ingress

- Deploy an ingress for the front end

## Deploy a Kubernetes ingress controller running NGINX

- Ingress controller (layer 7) vs basic loadbalancer (layer 4)

- Usecase for URL based routing

- reverse proxy, configurable traffic routing, and TLS termination for Kubernetes services

- Use Helm chart to install NGINX ingress controller

## Reconfigure the ratings web service to use ClusterIP

- Replace "type: LoadBalancer" with "type: ClusterIP" in web-service.yaml 

- Delete existing LoadBalancer service and then create the ClusterIP service

## Create an Ingress resource for the ratings web service

- Ingress resource for specifying the configuration of the Ingress controller
    - Ingress rules
    - Specify routing paths to different backend web services

## Test the application
    - Access the FQDN configured on the ingress from a web browser
