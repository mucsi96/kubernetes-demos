resource "null_resource" "command" {
  provisioner "local-exec" {
    command = <<-EOT
    cd ${var.path}
    current_sha=$(git ls-files -z | sed 's/^/\.\//' -z | sort -z | xargs -0 sha1sum | sha1sum | awk '{print $1}')
    echo $current_sha
    echo -n "$current_sha" > version.txt
    EOT
  }

  triggers = {
    always_run = timestamp()
  }
}

data "local_file" "version" {
  filename = "${var.path}/version.txt"

  depends_on = [
    null_resource.command
  ]
}
