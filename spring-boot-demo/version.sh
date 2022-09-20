#!/bin/bash

namespace=spring-boot-demo

kubectl create configmap chart-version --namespace $namespace >/dev/null 2>/dev/null
kubectl create configmap image-version --namespace $namespace >/dev/null 2>/dev/null
kubectl create configmap chart-sha --namespace $namespace >/dev/null 2>/dev/null
kubectl create configmap image-sha --namespace $namespace >/dev/null 2>/dev/null

get_dir_sha() {
    dir_path=$1
    git ls-files $dir_path | awk '{printf("./%s\0", $0)}' | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}'
}

get_remote() {
    kubectl get configmap "$1-$2" --namespace $namespace -o jsonpath="{.data.$3}"
}

set_remote() {
    kubectl patch configmap "$1-$2" --namespace $namespace --patch "{\"data\":{\"$3\":\"$4\"}}"
}

get_local_sha() {
    if [[ "$1" == "chart" ]]
    then
        get_dir_sha "./charts/$2" 
    elif [[ "$1" == "image" ]]
    then
        get_dir_sha "./$2" 
    fi
}

get_version() {
    local_sha=$1
    remote_sha=$2
    remote_version=$3

    if [[ "$local_sha" == "$remote_sha" ]]
    then
        echo $remote_version
    elif [[ -z "$remote_version" ]]
    then
        echo 1
    else
        echo $((remote_version + 1))
    fi
}

set_version() {
    type=$1
    name=$2
    local_sha=$(get_local_sha $type $name)
    remote_sha=$(get_remote $type sha $name)
    remote_version=$(get_remote $type version $name)
    version=$(get_version $local_sha $remote_sha $remote_version)
    set_remote $type sha $name $local_sha
    set_remote $type version $name $version

    if [[ "$type" == "chart" ]]
    then
        if [[ -f "./$name/version.txt" ]]
        then
            image_version=$(cat ./$name/version.txt)
            echo -n "0.$version.$image_version" > "./charts/$name/version.txt" 
        else
            echo -n "0.0.$version" > "./charts/$name/version.txt" 
        fi
    elif [[ "$type" == "image" ]]
    then
        echo -n $version > "./$name/version.txt" 
    fi
}

set_version image server
set_version image client
set_version chart client
set_version chart server
set_version chart database
set_version chart ingress
