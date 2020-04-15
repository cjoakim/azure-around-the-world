# Unit 6 - Key Topics

- https://docs.microsoft.com/en-us/learn/modules/aks-workshop/06-deploy-ratings-web

- Deploy the ratings front end

## Create a Kubernetes deployment for the web front end

- Deployment Yaml overview
    - env variable for frontend to access API 
- Viewing logs
    - kubectl logs <pod name> --namespace ratingsapp
    - kubectl describe pod <pod name> --namespace ratingsapp

## Create a Kubernetes service manifest file to expose the web front end as a load-balanced service

- Kubernetes Service Yaml overview
    - type: LoadBalancer

## Test the web front end
