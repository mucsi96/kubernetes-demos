locals {
  client_image_name = "mucsi96/${var.app_namespace}-client"
}

resource "null_resource" "docker_client" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../client --quiet --tag ${local.client_image_name}:${var.run_number} --tag ${local.client_image_name}:latest
      docker push ${local.client_image_name} --all-tags
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "helm_release" "client" {
  name             = "client"
  namespace        = var.app_namespace
  create_namespace = true
  chart            = "../charts/client"
  depends_on = [
    null_resource.docker_client
  ]

  set {
    name  = "image.tag"
    value = var.run_number
  }

  set {
    name  = "service.port"
    value = var.client_port
  }
}