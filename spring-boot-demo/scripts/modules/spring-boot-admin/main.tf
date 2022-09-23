data "local_file" "image_version" {
  filename = "../spring-boot-admin/version.txt"
}

data "local_file" "chart_version" {
  filename = "../charts/spring-boot-admin/version.txt"
}

resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../spring-boot-admin \
        --quiet \
        --tag ${var.image_name}:${data.local_file.image_version.content} \
        --tag ${var.image_name}:latest
      docker push ${var.image_name} --all-tags
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
  chart            = "../charts/spring-boot-admin"
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
}
