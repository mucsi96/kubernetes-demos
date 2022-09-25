resource "helm_release" "kube-prometheus-stack" {
  chart            = "kube-prometheus-stack"
  name             = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "40.1.2"
}

resource "helm_release" "nginx-prometheus-exporter" {
  chart            = "nginx-prometheus-exporter"
  name             = "nginx-prometheus-exporter"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://nexclipper.github.io/helm-charts"
  version          = "0.1.3"

  set {
    name  = "nginxServer"
    value = "http://app-client.spring-boot-demo.svc.cluster.local:8080/stub_status"
  }

  set {
    name = "serviceMonitor.labels"
    value = {
      "release" = helm_release.kube-prometheus-stack.name
    }
  }
}

resource "kubernetes_config_map" "traefik_dashboard" {
  metadata {
    name      = "traefik-dashboard"
    namespace = var.namespace
    labels = {
      grafana_dashboard = true
    }
  }

  data = {
    "traefik-2_rev1.json" = file("${path.module}/dashboards/traefik-2_rev1.json")
  }
}

resource "kubernetes_config_map" "nginx_dashboard" {
  metadata {
    name      = "nginx-dashboard"
    namespace = var.namespace
    labels = {
      grafana_dashboard = true
    }
  }

  data = {
    "nginx_rev1.json" = file("${path.module}/dashboards/nginx_rev1.json")
  }
}

# CRD Ref: https://prometheus-operator.dev/docs/operator/api/#monitoring.coreos.com/v1.PodMonitor
resource "kubernetes_manifest" "traefik_pod_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "PodMonitor"
    metadata = {
      name      = "traefik"
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
        matchNames = ["kube-system"]
      }
      selector = {
        matchLabels = {
          "app.kubernetes.io/name" = "traefik"
        }
      }
    }
  }
}

# CRD Ref: https://prometheus-operator.dev/docs/operator/api/#monitoring.coreos.com/v1.PodMonitor
resource "kubernetes_manifest" "traefik_pod_monitor" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "PodMonitor"
    metadata = {
      name      = "traefik"
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
        matchNames = ["kube-system"]
      }
      selector = {
        matchLabels = {
          "app.kubernetes.io/name" = "traefik"
        }
      }
    }
  }
}
