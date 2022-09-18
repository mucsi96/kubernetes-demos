locals {
    client_image_name = "${var.docker_username}/${var.app_namespace}-client"
}

resource "docker_registry_image" "client_with_version" {
  name = "${local.client_image_name}:${var.run_number}"

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

resource "helm_release" "client" {
  name             = "client"
  namespace        = var.app_namespace
  create_namespace = true
  chart            = "../charts/client"
  depends_on       = [
    docker_registry_image.client_with_version,
    docker_registry_image.client_latest
  ]

  set {
    name = "image.tag"
    value = var.run_number
  }

  set {
    name = "image.pullPolicy"
    value = "IfNotPresent"
  }
}