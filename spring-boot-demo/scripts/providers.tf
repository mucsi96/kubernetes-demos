terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "docker" {
  # registry_auth {
  #   address     = "registry-1.docker.io"
  #   config_file = pathexpand("~/.docker/config.json")
  # }
}
