resource "helm_release" "kube-prometheus-stack" {
  chart            = "kube-prometheus-stack"
  name             = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "40.1.2"
}

resource "kubernetes_config_map" "grafana-dashboards" {
  metadata {
    name      = "grafana-dashboards"
    namespace = var.namespace
    labels = {
      grafana_dashboard = 1
    }
  }

  data = {
    "traefik-2_rev1.json" = file("${path.module}/dashboards/traefik-2_rev1.json")
  }
}
