#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

read -d EOF
app_version=$(echo "$REPLY" | jq -r .app_version)
chart_version=$(echo "$REPLY" | jq -r .chart_version)

if [[ -z "$app_version" ]]
then
    echo "Missing chart_version"
    exit 2
fi

if [[ -z "$chart_version" ]]
then
    echo "Missing chart_version"
    exit 3
fi

new_version="$chart_version.$app_version"

sed -i "s/^appVersion:.*$/appVersion: \"$app_version\"/" Chart.yaml
sed -i "s/^version:.*$/version: \"$new_version\"/" Chart.yaml

jq -n --arg version "$new_version" '{"version":$version}'