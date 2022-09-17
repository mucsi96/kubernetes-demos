resource "helm_release" "install" {
  name       = "spring-boot-demo"
  chart      = ".."
  depends_on = [
    docker_registry_image.client_with_version,
    docker_registry_image.client_latest,
    docker_registry_image.server_with_version,
    docker_registry_image.server_latest
  ]
}