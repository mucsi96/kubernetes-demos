data "local_file" "image_version" {
  filename = "../server/version.txt"
}

data "local_file" "chart_version" {
  filename = "../charts/server/version.txt"
}

resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../server \
        --quiet \
        --tag ${var.image_name}:${data.local_file.image_version.content} \
        --tag ${var.image_name}:latest
      docker push ${var.image_name} --all-tags
      echo "New image published ${var.image_name}:${data.local_file.image_version.content}"
    EOT
  }

  triggers = {
    version = data.local_file.image_version.content
  }
}

resource "helm_release" "chart" {
  name             = var.host
  version          = data.local_file.chart_version.content
  namespace        = var.namespace
  create_namespace = true
  chart            = "../charts/server"
  depends_on = [
    null_resource.image
  ]

  set {
    name  = "image.repository"
    value = var.image_name
  }

  set {
    name  = "service.port"
    value = var.port
  }

  set {
    name  = "service.managementPort"
    value = var.management_port
  }

  set {
    name  = "database.name"
    value = var.database.name
  }

  set {
    name  = "database.host"
    value = var.database.host
  }

  set {
    name  = "database.port"
    value = var.database.port
  }

  set {
    name  = "database.userName"
    value = var.database.username
  }

  set {
    name  = "database.password"
    value = var.database.password
  }

  set {
    name  = "adminServer.port"
    value = var.admin_server.port
  }

  set {
    name  = "adminServer.host"
    value = var.admin_server.host
  }
}
