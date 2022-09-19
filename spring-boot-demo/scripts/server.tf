locals {
  server_image_name = "mucsi96/${var.app.namespace}-server"
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
  name             = var.app.server.host
  namespace        = var.app.namespace
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
    value = var.app.server.port
  }

  set {
    name  = "database.name"
    value = var.app.namespace
  }

  set {
    name  = "database.host"
    value = var.app.database.host
  }

  set {
    name  = "database.port"
    value = var.app.database.port
  }

  set {
    name  = "database.userName"
    value = var.app.database.username
  }

  set {
    name  = "database.password"
    value = var.app.database.password
  }
}
