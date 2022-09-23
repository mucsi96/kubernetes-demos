data "local_file" "image_version" {
  filename = "../client/version.txt"
}

data "local_file" "chart_version" {
  filename = "../charts/client/version.txt"
}

resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../client \
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
  chart            = "../charts/client"
  depends_on = [
    null_resource.image
  ]

  set {
    name  = "service.port"
    value = var.port
  }
}
