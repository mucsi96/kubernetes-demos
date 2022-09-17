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

  build {
    context = abspath("../client")

    auth_config {
      host_name = "registry.hub.docker.com"
      user_name = var.dockerUsername
      auth = var.dockerAccessToken
    }
  }
}