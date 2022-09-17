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

resource "docker_registry_image" "client" {
  name = "spring-boot-demo-client:latest"
}