resource "null_resource" "docker_build" {

    triggers = {
        always_run = timestamp()
    }

    provisioner "local-exec" {
        command = "docker build -t ${var.dockerUsername}/spring-boot-demo-client:latest -t ${var.dockerUsername}/spring-boot-demo-client:${var.runNumber} ../client"
    }
}

resource "null_resource" "docker_login" {

    depends_on = [ null_resource.docker_build ]

    triggers = {
        always_run = timestamp()
    }

    provisioner "local-exec" {
        command = "docker login --username ${var.dockerUsername} --password ${var.dockerAccessToken}"
    }
}

resource "null_resource" "docker_push" {

    depends_on = [ null_resource.docker_login ]

    triggers = {
        always_run = timestamp()
    }

    provisioner "local-exec" {
        command = "docker push ${var.dockerUsername}/spring-boot-demo-client"
    }
}