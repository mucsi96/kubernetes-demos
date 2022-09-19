#!/bin/bash
POD_NAME=$(kubectl get pods --namespace kubernetes-dashboard | awk '{print $1}' | grep kubernetes-dashboard)
# kubectl create token kubernetes-dashboard --namespace kubernetes-dashboard | clip
# echo "Your token is in clipboard."
start chrome http://localhost:9090/\#/pod?namespace=spring-boot-demo
kubectl port-forward $POD_NAME 9090:9090 --namespace kubernetes-dashboard
