module "chart_version" {
  source     = "../helm-chart-version"
  tag_prefix = "database-chart"
  path       = "../charts/database"
}

resource "random_pet" "username" {}

resource "random_password" "password" {
  length = 16
}

resource "random_password" "root_password" {
  length = 16
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
    value = random_password.root_password.result
  }

  set {
    name  = "userName"
    value = random_pet.username.id
  }

  set {
    name  = "password"
    value = random_password.password.result
  }

  set {
    name  = "service.metricsPort"
    value = var.metrics_port
  }
}
