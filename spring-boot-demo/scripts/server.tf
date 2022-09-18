locals {
    server_image_name = "mucsi96/${var.app_namespace}-server"
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