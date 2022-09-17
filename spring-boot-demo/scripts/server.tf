locals {
    server_image_name = "${var.docker_username}/spring-boot-demo-server"
}

resource "docker_registry_image" "server_with_version" {
  name = "${local.server_image_name}:${var.run_number}"

  build {
    context = abspath("../server")
  }
}

resource "docker_registry_image" "server_latest" {
  name = "${local.server_image_name}:latest"

  build {
    context = abspath("../server")
  }
}