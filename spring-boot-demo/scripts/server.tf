locals {
    image_name = "${var.dockerUsername}/spring-boot-demo-server"
}

resource "docker_registry_image" "server_with_version" {
  name = "${local.image_name}:${var.runNumber}"

  build {
    context = abspath("../server")
  }
}

resource "docker_registry_image" "server_latest" {
  name = "${local.image_name}:latest"

  build {
    context = abspath("../server")
  }
}