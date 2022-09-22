data "local_file" "ingress_chart_version" {
  filename = "../charts/ingress/version.txt"
}

resource "helm_release" "chart" {
  name             = "app-ingress"
  version          = data.local_file.ingress_chart_version.content
  namespace        = var.namespace
  create_namespace = true
  chart            = "../charts/ingress"

  set {
    name  = "hostName"
    value = var.hostname
  }

  set {
    name  = "clientHost"
    value = var.client_host
  }

  set {
    name  = "serverHost"
    value = var.server_host
  }

  set {
    name  = "tlsSecretName"
    value = var.tls_secret_name
  }
}
