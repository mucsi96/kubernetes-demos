module "image_version" {
  source     = "../version"
  tag_prefix = "client-image"
  path       = "../client"
}

data "local_file" "chart_version" {
  filename = "../charts/client/version.txt"
}

resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../client \
        --quiet \
        --tag ${var.image_name}:${module.image_version.version} \
        --tag ${var.image_name}:latest
      docker push ${var.image_name} --all-tags
      echo "New image published ${var.image_name}:${module.image_version.version}"
    EOT
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

  set {
    name  = "service.metricsPort"
    value = var.metrics_port
  }
}
