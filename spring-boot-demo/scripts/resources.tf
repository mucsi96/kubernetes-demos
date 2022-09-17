resource "local_sensitive_file" "docker_config" {
  filename = "docker-config.json"
  content  = <<EOT
    {
      "auths": {
        "https://index.docker.io/v1/": {
          "auth": "${var.dockerAccessToken}"
        }
      }
    }
    EOT
}