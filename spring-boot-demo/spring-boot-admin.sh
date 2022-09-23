#!/bin/bash
POD_NAME=$(kubectl get pods --namespace spring-boot-demo --selector app.kubernetes.io/instance=spring-boot-admin-server | awk '{print $1}' | grep spring-boot-admin-server)
start chrome http://localhost:9090
kubectl port-forward $POD_NAME 9090:http --namespace spring-boot-demo
