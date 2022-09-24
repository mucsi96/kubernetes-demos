#!/bin/bash
start chrome http://localhost:9090/\#/pod?namespace=spring-boot-demo
kubectl port-forward services/kubernetes-dashboard 9090:443 --namespace kubernetes-dashboard
