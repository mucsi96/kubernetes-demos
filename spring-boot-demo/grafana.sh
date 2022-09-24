#!/bin/bash
start chrome http://localhost:9097
username=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-user}" | base64 --decode)
password=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)
echo "Username: $username"
echo "Password: $password"
kubectl port-forward services/grafana 9097:80 -n monitoring
