data "local_file" "ingress_chart_version" {
  filename = "../charts/ingress/version.txt"
}

resource "helm_release" "ingress" {
  name             = "app-ingress"
  namespace        = var.app.namespace
  create_namespace = true
  chart            = "../charts/ingress"

  set {
    name  = "hostName"
    value = var.app.hostname
  }

  set {
    name  = "clientHost"
    value = var.app.client.host
  }

  set {
    name  = "serverHost"
    value = var.app.server.host
  }

  set {
    name  = "tlsSecretName"
    value = var.app.tls.secret_name
  }
}
