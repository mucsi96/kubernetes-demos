variable "namespace" {
  type = string
}

variable "image_name" {
  type = string
}

variable "host" {
  type = string
}

variable "port" {
  type = number
}

variable "database" {
  type = object({
    name     = string,
    host     = string,
    port     = number,
    username = string,
    password = string
  })
}

variable "management_port" {
  type = string
}
