#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

eval "$(jq -r '@sh "app_version=\(.app_version)" chart_version=\(.chart_version)"')"

new_version="$chart_version.$app_version"

sed -i "s/^appVersion:.*$/appVersion: \"$app_version\"/" Chart.yaml
sed -i "s/^version:.*$/version: \"$new_version\"/" Chart.yaml

jq -n --arg verson "$new_version" '{"verson":$verson}'