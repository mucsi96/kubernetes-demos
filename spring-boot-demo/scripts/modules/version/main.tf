data "external" "version" {
  program     = [abspath("${path.module}/command.sh")]
  working_dir = var.path
  query = {
    tag_prefix = var.tag_prefix
  }
}
