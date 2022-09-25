# CRD Ref: https://prometheus-operator.dev/docs/operator/api/#monitoring.coreos.com/v1.PodMonitor
resource "kubernetes_manifest" "client_service_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "PodMonitor"
    metadata = {
      name      = "client"
      namespace = var.namespace
      labels = {
        "release" = helm_release.kube-prometheus-stack.name
      }
    }
    spec = {
      podMetricsEndpoints = [{
        port = "metrics"
        path = "/metrics"
      }]
      namespaceSelector = {
        matchNames = [var.client.namespace]
      }
      selector = {
        matchLabels = {
          "app.kubernetes.io/instance" = var.client.name
        }
      }
    }
  }
}

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
