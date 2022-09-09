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

Create namespace
```bash
kubectl apply -f .\namespace.yaml
```

Create deployment
```bash
kubectl apply -f .\deployment.yaml
```

Create service
```bash
kubectl apply -f .\service.yaml 
```

Now you should be able to get 404 from Nginx from public.

Adding index.html on the server
```bash
mkdir -p /shared/kubernetes-nginx-demo
curl -o /shared/kubernetes-nginx-demo/index.html https://raw.githubusercontent.com/mucsi96/vpsfiles/main/kubernetes-nginx-demo/src/index.html
```


## Resources:

- [Working Kubernetes for your personal projects for 5 Euros / Month](https://levelup.gitconnected.com/working-kubernetes-for-your-personal-projects-for-5-euros-month-badb0d648c2c)
- [Free SSL Certs in Kubernetes! Cert Manager Tutorial](https://www.youtube.com/watch?v=DvXkD0f-lhY&t=347s)
- [xcad2k/boilerplates](https://github.com/xcad2k/boilerplates/tree/main/kubernetes)


