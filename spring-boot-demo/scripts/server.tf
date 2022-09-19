locals {
  server_image_name = "mucsi96/${var.app_namespace}-server"
}

resource "null_resource" "docker_server" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../server --quiet --tag ${local.server_image_name}:${var.run_number} --tag ${local.server_image_name}:latest
      docker push ${local.server_image_name} --all-tags
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "helm_release" "server" {
  name             = "server"
  namespace        = var.app_namespace
  create_namespace = true
  chart            = "../charts/server"
  depends_on = [
    null_resource.docker_server
  ]

  set {
    name  = "image.tag"
    value = var.run_number
  }

  set {
    name  = "service.port"
    value = var.server_port
  }

  set {
    name  = "database.name"
    value = var.app_namespace
  }

  set {
    name  = "database.host"
    value = "database"
  }

  set {
    name  = "database.port"
    value = var.database_port
  }

  set {
    name  = "database.userName"
    value = var.database_user_name
  }

  set {
    name  = "database.password"
    value = var.database_password
  }
}