locals {
    client_image_name = "${var.dockerUsername}/spring-boot-demo-client"
}

resource "docker_registry_image" "client_with_version" {
  name = "${local.client_image_name}:${var.runNumber}"

  build {
    context = abspath("../client")
  }
}

resource "docker_registry_image" "client_latest" {
  name = "${local.client_image_name}:latest"

  build {
    context = abspath("../client")
  }
}