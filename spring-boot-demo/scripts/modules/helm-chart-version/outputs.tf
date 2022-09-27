output "version" {
  value = "${module.chart_version.version}.${var.app_version}"

  depends_on = [
    null_resource.command
  ]
}
