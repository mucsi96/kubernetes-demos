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
    address             = "registry-1.docker.io"
    config_file_content = "{\"auths\":{\"https://index.docker.io/v1/\":{\"username\":\"${var.dockerUsername}\",\"auth\":\"${var.dockerAccessToken}\"}}}"
  }
}