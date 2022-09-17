resource "docker_image" "client" {
  name = "spring-boot-demo-client:latest"
  build {
    path = "../client"
    tag  = ["spring-boot-demo-client:${var.runNumber}"]
  }
}

output "runNumber" {
  value = var.runNumber
}