resource "helm_release" "ingress" {
  name             = "app-ingress"
  namespace        = var.app_namespace
  create_namespace = true
  chart            = "../charts/ingress"

  set {
    name  = "hostName"
    value = var.host_name
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
