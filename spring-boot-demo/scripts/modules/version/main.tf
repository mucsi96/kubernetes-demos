data "external" "version" {
  program     = ["bash", abspath("${path.module}/command.sh")]
  working_dir = var.path
  query = {
    tag_prefix = var.tag_prefix
  }
}

resource "null_resource" "debug" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Output ${data.external.version.result}"
    EOT
  }
}
