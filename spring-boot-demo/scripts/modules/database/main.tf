data "local_file" "database_chart_version" {
  filename = "../charts/database/version.txt"
}

resource "helm_release" "chart" {
  name             = var.host
  version          = data.local_file.database_chart_version.content
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
}
