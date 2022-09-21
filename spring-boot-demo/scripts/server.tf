locals {
  server_image_name = "mucsi96/${var.app.namespace}-server"
}

data "local_file" "server_image_version" {
  filename = "../server/version.txt"
}

data "local_file" "server_chart_version" {
  filename = "../charts/server/version.txt"
}

resource "null_resource" "server_image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../server \
        --quiet \
        --tag ${local.server_image_name}:${data.local_file.server_image_version.content} \
        --tag ${local.server_image_name}:latest
      docker push ${local.server_image_name} --all-tags
    EOT
  }

  triggers = {
    version = data.local_file.server_image_version.content
  }
}

resource "helm_release" "server" {
  name             = var.app.server.host
  version          = data.local_file.server_chart_version.content
  namespace        = var.app.namespace
  create_namespace = true
  chart            = "../charts/server"
  depends_on = [
    null_resource.server_image
  ]

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
