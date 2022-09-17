data "kubernetes_resource" "example" {
  api_version = "apps/v1"
  kind        = "Deployment"

  metadata {
    name      = "spring-boot-demo-client"
    namespace = "default"
  }
}

output "test" {
  value = data.kubernetes_resource.example.object
}