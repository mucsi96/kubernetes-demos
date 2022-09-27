module "chart_version" {
  source     = "../version"
  tag_prefix = var.tag_prefix
  path       = var.path
}

resource "null_resource" "command" {
  provisioner "local-exec" {
    command = <<-EOT
      cd ${abspath(var.chart_path)}
       sed -i "s/^appVersion:.*$/appVersion: \"${var.app_version}\"/" Chart.yaml
       sed -i "s/^version:.*$/version: \"${module.chart_version.version}.${var.app_version}\"/" Chart.yaml
    EOT
  }
}
