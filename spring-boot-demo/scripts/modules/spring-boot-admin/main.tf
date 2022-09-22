data "local_file" "chart_version" {
  filename = "../charts/spring-boot-admin/version.txt"
}

resource "helm_release" "chart" {
  name             = var.host
  version          = data.local_file.chart_version.content
  namespace        = var.namespace
  create_namespace = true
  chart            = "../charts/spring-boot-admin"

  set {
    name  = "service.port"
    value = var.port
  }
}
