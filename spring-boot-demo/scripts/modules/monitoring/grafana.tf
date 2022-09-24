resource "helm_release" "grafana" {
  chart            = "grafana"
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  namespace        = var.namespace
  create_namespace = true
  version          = "6.38.7"
}
