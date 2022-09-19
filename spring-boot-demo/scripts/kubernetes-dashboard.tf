resource "helm_release" "kubernetes-dashboard" {
  name             = "kubernetes-dashboard"
  namespace        = "kubernetes-dashboard"
  create_namespace = true
  chart            = "kubernetes-dashboard"
  repository       = "https://kubernetes.github.io/dashboard"
  version          = "5.10.0"

  set {
    name  = "metricsScraper.enabled"
    value = "true"
  }

  set {
    name  = "protocolHttp"
    value = "true"
  }

  set {
    name  = "extraArgs"
    value = "{--enable-skip-login, --enable-insecure-login}"
  }
}