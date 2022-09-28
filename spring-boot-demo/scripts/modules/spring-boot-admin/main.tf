module "image_version" {
  source     = "../version"
  tag_prefix = "spring-boot-admin-image"
  path       = "../spring-boot-admin"
}

module "chart_version" {
  source      = "../helm-chart-version"
  app_version = module.image_version.version
  tag_prefix  = "spring-boot-admin-chart"
  path        = "../charts/spring-boot-admin"
}

resource "null_resource" "image" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../spring-boot-admin \
        --quiet \
        --tag ${var.image_name}:${module.image_version.version} \
        --tag ${var.image_name}:latest
      docker push ${var.image_name} --all-tags
      echo "New image published ${var.image_name}:${module.image_version.version}"
    EOT
  }

  triggers = {
    version = module.image_version.version
  }
}

resource "helm_release" "chart" {
  name             = var.host
  version          = module.chart_version.version
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
