# Docker Nginx demo

```bash
sudo apt-get update
```

```bash
sudo apt-get upgrade
```

Install the Compose plugin.

```bash
sudo apt-get install docker-compose-plugin
```

```bash
mkdir -p ~/docker-nginx-demo/src/
curl -o ~/docker-nginx-demo/docker-compose.yml https://raw.githubusercontent.com/mucsi96/vpsfiles/main/docker-nginx-demo/docker-compose.yml
curl -o ~/docker-nginx-demo/src/index.html https://raw.githubusercontent.com/mucsi96/vpsfiles/main/docker-nginx-demo/src/index.html
docker compose up
curl localhost
```