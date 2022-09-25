resource "helm_release" "kube-prometheus-stack" {
  chart            = "kube-prometheus-stack"
  name             = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "40.1.2"
}

# resource "helm_release" "nginx-prometheus-exporter" {
#   chart            = "nginx-exporter"
#   name             = "nginx-prometheus-exporter"
#   namespace        = var.namespace
#   create_namespace = true
#   repository       = "https://nexclipper.github.io/helm-charts"
#   version          = "0.1.3"

#   values = [
#     <<EOT
# nginxServer: "http://${var.client.host}.${var.client.namespace}.svc.cluster.local:${var.client.stats_port}/stub_status"
# serviceMonitor:
#   enabled: true
#   labels:
#     release: "${helm_release.kube-prometheus-stack.name}"
# EOT
#   ]
# }

