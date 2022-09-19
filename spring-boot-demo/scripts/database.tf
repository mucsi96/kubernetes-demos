resource "helm_release" "database" {
  name             = var.database_host
  namespace        = var.app_namespace
  create_namespace = true
  chart            = "../charts/database"

  set {
    name  = "name"
    value = var.app_namespace
  }

  set {
    name  = "service.port"
    value = var.database_port
  }

  set {
    name  = "rootPassword"
    value = var.database_root_password
  }

  set {
    name  = "userName"
    value = var.database_user_name
  }

  set {
    name  = "password"
    value = var.database_password
  }
}
