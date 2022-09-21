#!/bin/bash

nl=$'\n'
namespace=spring-boot-demo

kubectl create configmap version-table --namespace $namespace >/dev/null 2>/dev/null

versions=$(kubectl get configmap version-table --namespace $namespace -o jsonpath="{.data.content}" | tr '|' '\n')

get_dir_sha() {
    dir_path=$1
    git ls-files $dir_path -z | sed 's/^/\.\//' -z | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}'
}

get_remote_sha() {
    type=$1
    name=$2
    echo "$versions" | grep "^$name $type " | awk '{print $3}'
}

get_remote_version() {
    type=$1
    name=$2
    echo "$versions" | grep "^$name $type " | awk '{print $4}'
}

set_remote() {
    type=$1
    name=$2
    sha=$3
    version=$4
    if [[ -z $(echo "$versions" | grep "^$name $type ") ]]
    then
        versions=$(echo "$versions" | sed "$ a $name $type $sha $version")
    else
        versions=$(echo "$versions" | sed "s/^$name $type .*$/$name $type $sha $version/")
    fi
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
    remote_sha=$(get_remote_sha $type $name)
    remote_version=$(get_remote_version $type $name)
    version=$(get_version $local_sha $remote_sha $remote_version)
    set_remote $type $name $local_sha $version

    if [[ $local_sha == $remote_sha ]]
    then
        echo "same sha for $type $name $local_sha $remote_sha"
    else
        echo "NOT same sha for $type $name $local_sha $remote_sha"
    fi

    if [[ "$type" == "chart" ]]
    then
        if [[ -f "./$name/version.txt" ]]
        then
            image_version=$(cat ./$name/version.txt)
            sed -i "/^appVersion: /s/[0-9]\+.[0-9]\+.[0-9]\+\|latest/$image_version/" ./charts/$name/Chart.yaml
            print_version="0.$version.$image_version"
        else
            print_version="0.0.$version"
        fi

        echo -n $print_version > "./charts/$name/version.txt"
        sed -i "/^version: /s/[0-9]\+.[0-9]\+.[0-9]\+/$print_version/" ./charts/$name/Chart.yaml
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

echo "$versions"
content=$(echo "$versions" | tr '\n' '|')
kubectl patch configmap version-table --namespace $namespace --patch "{\"data\":{\"content\":\"$content\"}}"
