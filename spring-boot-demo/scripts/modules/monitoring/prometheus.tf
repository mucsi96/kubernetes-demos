resource "helm_release" "prometheus" {
  chart            = "prometheus"
  name             = "prometheus"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "15.13.0"

  values = [
    templatefile("${path.module}/templates/prometheus-values", {})
  ]
}

resource "helm_release" "kube-state-metrics" {
  chart            = "kube-state-metrics"
  name             = "kube-state-metrics"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "4.20.0"
}
