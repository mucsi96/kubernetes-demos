# Kubernetes Nginx demo

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
mkdir -p /shared/helm-nginx-demo
curl -o /shared/helm-nginx-demo/index.html https://raw.githubusercontent.com/mucsi96/vpsfiles/main/helm-nginx-demo/src/index.html
```

Install
```bash
helm install
```


## Resources:

- [Working Kubernetes for your personal projects for 5 Euros / Month](https://levelup.gitconnected.com/working-kubernetes-for-your-personal-projects-for-5-euros-month-badb0d648c2c)
- [Free SSL Certs in Kubernetes! Cert Manager Tutorial](https://www.youtube.com/watch?v=DvXkD0f-lhY&t=347s)
- [xcad2k/boilerplates](https://github.com/xcad2k/boilerplates/tree/main/kubernetes)


