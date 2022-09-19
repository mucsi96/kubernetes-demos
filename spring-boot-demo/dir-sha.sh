#!/bin/bash

> terraforms.tfvars

dirSha() {
    git ls-files $1 | awk '{printf("./%s\0", $0)}' | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}'
}

client_src_sha=$(dirSha ./client)
server_src_sha=$(dirSha ./server)
client_chart_sha=$(dirSha ./charts/client)
server_chart_sha=$(dirSha ./charts/server)
database_chart_sha=$(dirSha ./charts/database)
ingress_chart_sha=$(dirSha ./charts/ingress)


echo "client_src_sha = \"$client_src_sha\"" >> terraforms.tfvars
echo "server_src_sha = \"$server_src_sha\"" >> terraforms.tfvars
echo "server_src_sha = \"$server_src_sha\"" >> terraforms.tfvars
echo "server_chart_sha = \"$server_chart_sha\"" >> terraforms.tfvars
echo "client_chart_sha = \"$client_chart_sha\"" >> terraforms.tfvars
echo "database_chart_sha = \"$database_chart_sha\"" >> terraforms.tfvars
echo "ingress_chart_sha = \"$ingress_chart_sha\"" >> terraforms.tfvars

cat terraforms.tfvars
