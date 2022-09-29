module "chart_version" {
  source     = "../helm-chart-version"
  tag_prefix = "database-chart"
  path       = "../charts/database"
}

resource "helm_release" "chart" {
  name             = var.host
  version          = module.chart_version.version
  namespace        = var.namespace
  create_namespace = true
  chart            = "../charts/database"

  set {
    name  = "name"
    value = var.name
  }

  set {
    name  = "service.port"
    value = var.port
  }

  set {
    name  = "rootPassword"
    value = var.root_password
  }

  set {
    name  = "userName"
    value = var.username
  }

  set {
    name  = "password"
    value = var.password
  }

  set {
    name  = "service.metricsPort"
    value = var.metrics_port
  }
}
