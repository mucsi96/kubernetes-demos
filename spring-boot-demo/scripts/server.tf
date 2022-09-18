locals {
    server_image_name = "${var.docker_username}/spring-boot-demo-server"
}

resource "null_resource" "docker_server" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build -t ${local.server_image_name}:${var.run_number} -t ${local.server_image_name}:latest ../server
      docker push ${local.server_image_name}:${var.run_number} --all-tags
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}