data "external" "version" {
  program     = ["${path.module}/command.sh"]
  working_dir = var.path
  query = {
    tag_prefix = var.tag_prefix
  }
}
