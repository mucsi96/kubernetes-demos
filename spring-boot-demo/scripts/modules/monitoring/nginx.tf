resource "kubernetes_config_map" "nginx_dashboard" {
  metadata {
    name      = "nginx-dashboard"
    namespace = var.namespace
    labels = {
      grafana_dashboard = 1
    }
  }

  data = {
    "nginx_rev1.json" = file("${path.module}/dashboards/nginx_rev1.json")
  }
}
