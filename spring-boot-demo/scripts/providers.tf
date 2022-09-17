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
    address  = "registry.hub.docker.com"
    username = var.dockerUsername
    password = var.dockerAccessToken
  }
}