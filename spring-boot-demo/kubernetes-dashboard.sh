#!/bin/bash
POD_NAME=$(kubectl get pods | awk '{print $1}' | grep kubernetes-dashboard)
kubectl create token kubernetes-dashboard | clip
echo "Your token is in clipboard."
start chrome http://localhost:9090
kubectl -n default port-forward $POD_NAME 9090:9090
