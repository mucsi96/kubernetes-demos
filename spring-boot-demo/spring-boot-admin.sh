#!/bin/bash
POD_NAME=$(kubectl get pods --namespace spring-boot-demo --selector app.kubernetes.io/instance=spring-boot-admin-server | awk '{print $1}' | grep spring-boot-admin-server)
start chrome http://localhost:8099
kubectl port-forward $POD_NAME 8099:http --namespace spring-boot-demo
