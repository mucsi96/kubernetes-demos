# kubernetes-demos

[![CI](https://github.com/mucsi96/kubernetes-demos/actions/workflows/build.yml/badge.svg)](https://github.com/mucsi96/kubernetes-demos/actions/workflows/build.yml)

Contains demonstrations from simple to more advanced setups
1. Docker Compose + Nginx
2. Kubernetes + Nginx
3. Helm + Nginx
4. Helm + Nginx + Cert Manager
5. Spring Boot + Nginx + MySQL + Docker + Terraform + Helm + Cert Manager

## Setup the cluster

Install Docker Desktop on local machine.

Install [K3s](https://k3s.io/) on the server.

```bash
curl -sfL https://get.k3s.io | sh -
```

Get Kubernetes configuration and merge it with you local config in `~/.kube`.
Replace `default` with some better name and replace `127.0.0.1` with server IP.
```bash
cat /etc/rancher/k3s/k3s.yaml
```

Get cluster nodes from your local machine.
```bash
kubectl get nodes
```
