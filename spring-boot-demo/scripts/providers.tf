terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.21.0"
    }
  }
}

provider "docker" {
  depends_on = [ local_sensitive_file.docker_config ]

  registry_auth {
    address     = "registry-1.docker.io"
    config_file = "docker-config.json"
  }
}