# vpsfiles

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

## Adding Kubernetes Dashboard

Add helm repository for kubernetes-dashboard
```bash
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard
```

Update local Helm chart repository cache
```bash
helm repo update
```

Install Kubernetes Dashboard
```bash
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --set extraArgs="{--enable-skip-login,--enable-insecure-login}" --set protocolHttp=true
```

Forward a local port to a port on the Pod
```
kubectl -n default port-forward <POD_NAME> 9090:9090
```

Obtain the Bearer Token
```
kubectl create token kubernetes-dashboard
```

Open http://localhost:9090/ and click sign in and provide the created token.
