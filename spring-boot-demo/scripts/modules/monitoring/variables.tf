variable "namespace" {
  type = string
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
