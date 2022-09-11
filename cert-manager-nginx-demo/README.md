# Cert Manager Nginx demo

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

Adding index.html on the server
```bash
mkdir -p /shared/cert-manager-nginx-demo
curl -o /shared/cert-manager-nginx-demo/index.html https://raw.githubusercontent.com/mucsi96/vpsfiles/main/cert-manager-nginx-demo/src/index.html
```

Confiure Traefik
```bash
mkdir -p /var/lib/rancher/k3s/server/manifests
curl -o /var/lib/rancher/k3s/server/manifests/traefik-config.yaml https://raw.githubusercontent.com/mucsi96/vpsfiles/main/cert-manager-nginx-demo/traefik-config.yaml
```


Add the latest helm repository for the ingress-nginx
```bash
helm repo add jetstack https://charts.jetstack.io
```

Update local Helm chart repository cache
```bash
helm repo update
```

Install `cert-manager`
```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.9.1 --set installCRDs=true
```

Create cluster issuer
```bash
kubectl apply -f .\cluster-issuer.yaml
```

Verify
```bash
kubectl get clusterissuers
```

Create certificate
```bash
kubectl apply -f .\certificate.yaml
```

Verify
```bash
kubectl get certificates
```

Install
```bash
helm install app .
```





## Resources:

- [Working Kubernetes for your personal projects for 5 Euros / Month](https://levelup.gitconnected.com/working-kubernetes-for-your-personal-projects-for-5-euros-month-badb0d648c2c)
- [Free SSL Certs in Kubernetes! Cert Manager Tutorial](https://www.youtube.com/watch?v=DvXkD0f-lhY&t=347s)
- [xcad2k/boilerplates](https://github.com/xcad2k/boilerplates/tree/main/kubernetes)
- [Workshop: Getting Started with Traefik](https://www.youtube.com/watch?v=CL5Cxxz-yHo)


