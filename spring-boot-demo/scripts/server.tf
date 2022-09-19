locals {
  server_image_name = "mucsi96/${var.app_namespace}-server"
}

resource "null_resource" "docker_server" {
  provisioner "local-exec" {
    command = <<-EOT
      docker build ../server --quiet --tag ${local.server_image_name}:${var.run_number} --tag ${local.server_image_name}:latest
      docker push ${local.server_image_name} --all-tags
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}