locals {
  issuer_name = "tls-issuer"
}

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

resource "kubernetes_manifest" "tls_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "tls-certificate"
      namespace = var.namespace
    }
    spec = {
      secretName = var.tls_secret_name
      issuerRef = {
        name = local.issuer_name
        kind = "ClusterIssuer"
      }
      dnsNames = [var.hostName]
    }
  }
}

resource "kubernetes_manifest" "tls_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = local.issuer_name
    }
    spec = {
      acme = {
        server = var.certificate_issuer_server
        email  = var.certificate_issue_email
        privateKeySecretRef = {
          name = var.tls_secret_name
        }
        solvers = [{ http01 = { ingress = { class = "traefik" } } }]
      }
    }
  }
}
