terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.21.0"
    }
  }
}

provider "docker" {
  registry_auth {
    address     = "registry-1.docker.io"
    config_file = "docker-config.json"
  }
}