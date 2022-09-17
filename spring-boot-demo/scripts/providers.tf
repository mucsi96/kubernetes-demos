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
    address     = "https://index.docker.io/v1/"
    config_file = pathexpand("~/.docker/config.json")
  }
}