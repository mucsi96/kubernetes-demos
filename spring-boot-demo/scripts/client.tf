locals {
  client_image_name = "mucsi96/${var.app.namespace}-client"
}

data "local_file" "client_image_version" {
  filename = "../client/version.txt"
}

data "local_file" "client_chart_version" {
  filename = "../charts/client/version.txt"
}

resource "null_resource" "client_image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../client \
        --quiet \
        --tag ${local.client_image_name}:${data.local_file.client_image_version.content} \
        --tag ${local.client_image_name}:latest
      docker push ${local.client_image_name} --all-tags
    EOT
  }

  triggers = {
    version = data.local_file.client_image_version.content
  }
}

resource "helm_release" "client" {
  name             = var.app.client.host
  namespace        = var.app.namespace
  create_namespace = true
  chart            = "../charts/client"
  depends_on = [
    null_resource.client_image
  ]

  set {
    name  = "service.port"
    value = var.app.client.port
  }

  # triggers = {
  #   version = data.local_file.client_chart_version.content
  # }
}
