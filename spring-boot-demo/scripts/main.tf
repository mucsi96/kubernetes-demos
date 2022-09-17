resource "docker_image" "client" {
  name = "spring-boot-demo-client:latest"
  build {
    path = "../client"
    tag  = ["spring-boot-demo-client:${var.runNumber}"]
  }
  triggers = {
    always_run = timestamp()
    # dir_sha1 = sha1(join("", [for f in fileset(path.module, "../client/**") : filesha1(f)]))
  }
}