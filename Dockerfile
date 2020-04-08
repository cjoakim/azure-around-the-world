FROM openjdk:8-jdk-alpine
RUN  apk update && apk upgrade && apk add netcat-openbsd
RUN  mkdir -p /usr/local/app
ADD  target/app.jar /usr/local/app/

EXPOSE 80

CMD  java -Xmx200m -Dspring.profiles.active=web -jar /usr/local/app/app.jar


# docker build -t cjoakim/azure-around-the-world . 
# docker run -d -e xxx=yyy -p 3001:3000 cjoakim/azure-around-the-world:latest
# curl -v curl http://localhost:3001/health/env
# docker image ls
# docker ps
# docker stop -t 2 008038664a58
#
# DockerHub:
# docker push cjoakim/azure-around-the-world:latest
#
# Azure:
# az acr login --name cjoakimacr
# az acr repository list --name cjoakimacr --output table
# docker tag cjoakim/azure-around-the-world:latest cjoakimacr.azurecr.io/azure-around-the-world:latest
# docker push cjoakimacr.azurecr.io/azure-around-the-world:latest
