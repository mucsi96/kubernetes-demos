resource "helm_release" "install" {
  name       = "spring-boot-demo"
  chart      = ".."
}