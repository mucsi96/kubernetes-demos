#!/bin/bash
start chrome http://localhost:9095/
kubectl port-forward --namespace monitoring services/prometheus-server 9095:80
