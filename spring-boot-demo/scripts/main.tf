resource "docker_image" "client" {
  name = "spring-boot-demo-client:latest"

  build {
    path = "../client"
    tag  = ["spring-boot-demo-client:${var.runNumber}"]
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "docker_push" {
  depends_on = [
    docker_image.client
  ]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "docker push spring-boot-demo-client:latest"
  }
}