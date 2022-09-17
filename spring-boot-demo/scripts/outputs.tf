output "runNumber" {
  value = var.runNumber
}

output "dockerConfig" {
  value = jsonencode({
    auths = {
      "https://index.docker.io/v1/" = {
        auth = var.dockerAccessToken
      }
    }
  })
}