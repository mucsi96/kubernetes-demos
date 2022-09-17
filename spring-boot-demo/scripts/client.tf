locals {
    image_name = "${var.dockerUsername}/spring-boot-demo"
}

# resource "null_resource" "docker_build" {

#     triggers = {
#         always_run = timestamp()
#     }

#     provisioner "local-exec" {
#         command = "docker build -t ${local.image_name}:latest -t ${local.image_name}:${var.runNumber} ../client"
#     }
# }

# resource "null_resource" "docker_login" {

#     depends_on = [ null_resource.docker_build ]

#     triggers = {
#         always_run = timestamp()
#     }

#     provisioner "local-exec" {
#         command = "docker login --username ${var.dockerUsername} --password ${var.dockerAccessToken}"
#     }
# }

# resource "null_resource" "docker_push" {

#     depends_on = [ null_resource.docker_login ]

#     triggers = {
#         always_run = timestamp()
#     }

#     provisioner "local-exec" {
#         command = "docker push ${local.image_name}"
#     }
# }

resource "docker_image" "client" {
  name = "${local.image_name}:${var.runNumber}"

  build {
    path = "../client"
    tag  = ["${local.image_name}:latest"]
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "docker_registry_image" "client" {
  name = "${local.image_name}:${var.runNumber}"

  build {
    context = abspath("../client")
  }
}