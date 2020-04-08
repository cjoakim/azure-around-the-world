#!/bin/bash

# Build and containerize this Spring Boot web application with Maven, sass, Docker.
# Chris Joakim, 2020/03/27

source app-config.sh

mvn_args="-Dpom.artifact.id="$POM_ARTIFACT_ID" -Dpom.artifact.version="$POM_ARTIFACT_VERSION
echo "mvn_args: "$mvn_args

JARFILE="target/azure-around-the-world-0.0.5.jar"

arg_count=$#

display_help() {
    echo "script options:"
    echo "  ./build.sh           (default: does sass, mvn compile, and docker build)"
    echo "  ./build.sh compile"
    echo "  ./build.sh sass"
    echo "  ./build.sh package"
    echo "  ./build.sh mvn_tree"
    echo "  ./build.sh mvn_classpath"
}

mvn_clean_compile() {
    echo "mvn clean compile"
    mvn clean compile $mvn_args
}

sass_preprocess() {
    echo 'sass preprocess'
    rm   src/main/resources/static/css/atw.css
    sass src/main/resources/static/css/atw.scss src/main/resources/static/css/atw.css
    cat  src/main/resources/static/css/atw.css | wc -l
}

mvn_package_app() {
    sass_preprocess
    create_build_resources
    rm target/*.jar
    echo "building web app with pom.xml"
    mvn -f pom.xml -Dmaven.test.skip=$MAVEN_TEST_SKIP $mvn_args clean package

    echo "copy jar from: "$MAVEN_JAR_FILENAME
    echo "copy jar to:   "$STANDARD_JAR_FILENAME
    cp $MAVEN_JAR_FILENAME $STANDARD_JAR_FILENAME

    ls -al target/ | grep jar$ 

    echo "mvn dependency:build-classpath"
    mvn dependency:build-classpath > mvn-build-classpath.txt

    echo "mvn dependency:tree"
    mvn dependency:tree > mvn-dependency-tree.txt
}

create_build_resources() {
    echo 'create_build_resources'
    date -u > src/main/resources/build_date.txt
    whoami  > src/main/resources/build_user.txt
    cat src/main/resources/build_date.txt
    cat src/main/resources/build_user.txt
}

if [ $arg_count -gt 0 ]
then
    if [ $1 == "help" ] 
    then
        display_help
    fi

    if [ $1 == "compile" ] 
    then
        mvn_clean_compile
    fi

    if [ $1 == "sass" ] 
    then
        sass_preprocess
    fi

    if [ $1 == "package" ]
    then
        mvn_package_app  
    fi

    if [ $1 == "mvn_tree" ]
    then
        echo "mvn dependency:tree"
        mvn dependency:tree
    fi

    if [ $1 == "mvn_classpath" ]
    then
        echo "mvn dependency:build-classpath"
        mvn dependency:build-classpath > mvn-build-classpath.txt
        cat mvn-build-classpath.txt | tr ":" "\n" > mvn-build-classpath-lines.txt
        cat mvn-build-classpath-lines.txt | grep repository | sort 
        rm mvn-build-classpath*
    fi
else
    mvn_package_app

    if [ -f "$JARFILE" ]; then
        echo 'building container: '$DOCKERHUB_CONTAINER_FULLNAME
        echo '  jar_filename:     '$STANDARD_JAR_FILENAME
        docker build -t $DOCKERHUB_CONTAINER_FULLNAME .
        # docker build --build-arg jar_filename=$STANDARD_JAR_FILENAME -t $DOCKERHUB_CONTAINER_FULLNAME .

        echo 'listing image: '$DOCKERHUB_CONTAINER_NAME
        docker images | grep $DOCKERHUB_CONTAINER_NAME
    else
        echo 'container not created due to compilation errors'
    fi
fi

echo 'done'
