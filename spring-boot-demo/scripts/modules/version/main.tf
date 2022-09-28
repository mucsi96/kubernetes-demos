data "external" "version" {
  program     = ["bash", "${path.module}/command.sh"]
  working_dir = var.path
  query = {
    tag_prefix = var.tag_prefix
  }
}
