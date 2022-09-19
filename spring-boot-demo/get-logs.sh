#!/bin/bash
POD_NAME=$(kubectl get pods --namespace spring-boot-demo | awk '{print $1}' | grep $1)
kubectl logs ${POD_NAME}