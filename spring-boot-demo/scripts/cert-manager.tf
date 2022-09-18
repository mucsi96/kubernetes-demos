resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  chart            = "jetstack/cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.9.1"

  set {
    name = "installCRDs"
    value = "true"
  }
}