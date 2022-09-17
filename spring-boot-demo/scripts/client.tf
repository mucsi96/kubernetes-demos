locals {
    image_name = "${var.dockerUsername}/spring-boot-demo-client"
}

# resource "docker_image" "client" {
#   name = "${local.image_name}:${var.runNumber}"

#   build {
#     path = "../client"
#     tag  = ["${local.image_name}:latest"]
#   }

#   triggers = {
#     always_run = timestamp()
#   }
# }

resource "docker_registry_image" "client_with_version" {
  name = "${local.image_name}:${var.runNumber}"

  build {
    context = abspath("../client")
  }
}

resource "docker_registry_image" "client_latest" {
  name = "${local.image_name}:latest"

  build {
    context = abspath("../client")
  }
}