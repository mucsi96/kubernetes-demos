#!/bin/bash
POD_NAME=$(kubectl get pods | awk '{print $1}' | grep kubernetes-dashboard)
echo -------------------------------------------------- TOKEN --------------------------------------------------
kubectl create token kubernetes-dashboard
echo -----------------------------------------------------------------------------------------------------------
start chrome http://localhost:9090
kubectl -n default port-forward $POD_NAME 9090:9090
