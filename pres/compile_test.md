# compile and test locally

## setup

It is assumed that you have the following installed on your workstation:
- git 
- Java 8
- Apache Maven
- Docker Desktop (Docker & Compose)
- Python 3
- The az CLI program
- A terminal program that can execute bash scripts
  - Alternatively, you can create PowerShell scripts from the generated bash scripts

First, clone this git repository:
```
$ git clone <this-repo-url>
```

Next, set the necessary **environment variables** on your system,
see file [app-config](../app-config.sh) in the root of this repository.
Don't directly edit file app-config.sh, as this is one of the generated files.

Next, modify method **generate_config_json()** in python script [main.py](../admin/main.py).
This methods define values which drive subsequent script and YAML file generation.
Page [Automated File Generation With Python](python_automation.md) describes the
script and YAML file generation process.

Next, generate the bash scripts and YAML files as follows:
```
$ cd admin/
$ ./gen-files-all-aks.sh
```

---

## compile & build

Clone the git repository:
```
$ git clone <this repo>
```

cd into the repo root directory, then:

```
$ ./build.sh     # java compile, capture build user and date, build Docker container
```

---

## test locally with Docker Compose

I execute **docker-compose** as follows with this custom script:
```
$ ./compose.sh up
```

The compose.sh script "sources" file app-config.sh to set **environment variables**.

File **docker-compose.yml** looks like this, and uses the environment variables:
```
version: '3'
services:
  web:
    image: ${DOCKERHUB_CONTAINER_FULLNAME}
    ports:
      - "3000:80"
    environment:
    - AZURE_RESOURCE_LOC=${AZURE_RESOURCE_LOC}
    - AZURE_RESOURCE_NAME=${AZURE_RESOURCE_NAME}
    - AZURE_COSMOSDB_URI=${AZURE_COSMOSDB_URI}
    - AZURE_COSMOSDB_KEY=${AZURE_COSMOSDB_KEY}
    - AZURE_COSMOSDB_DATABASE=${AZURE_COSMOSDB_DATABASE}
```

Invoke the app at http://localhost:3000/ per the above "3000:80" **port mapping**.
```
$ cd admin/
$ source bin/activate
$ python http-client.py post_journey_relay http://127.0.0.1:3000 relay-local-3.json [pk]
```

In another terminal window, to check the running process(es) then shutdown the test:
```
$ ./compose.sh ps
$ ./compose.sh down
```

---

## optionally push the image to ACR

The DevOps Pipeline process will also do this.

```
$ ./acr.sh      # az login, list, show, tag, push, list, show
```
