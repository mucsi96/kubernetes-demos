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

Add helm repository for cert-manager and sealed-secrets
```bash
helm repo add jetstack https://charts.jetstack.io
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
```

Update local Helm chart repository cache
```bash
helm repo update
```

Install `cert-manager`
```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.9.1 --set installCRDs=true
helm install sealed-secrets --namespace kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets
```

Install `kubeseal` from [https://github.com/bitnami-labs/sealed-secrets/releases](latest releases)

Create `SealedSecrets`
```
echo -n foo | kubeseal --raw --scope cluster-wide
```

Install app
```bash
helm install spring-boot-demo .
```

## Resources:

- [Working Kubernetes for your personal projects for 5 Euros / Month](https://levelup.gitconnected.com/working-kubernetes-for-your-personal-projects-for-5-euros-month-badb0d648c2c)
- [Free SSL Certs in Kubernetes! Cert Manager Tutorial](https://www.youtube.com/watch?v=DvXkD0f-lhY&t=347s)
- [xcad2k/boilerplates](https://github.com/xcad2k/boilerplates/tree/main/kubernetes)
- [Workshop: Getting Started with Traefik](https://www.youtube.com/watch?v=CL5Cxxz-yHo)
- [K3S Rocks](https://k3s.rocks/)


