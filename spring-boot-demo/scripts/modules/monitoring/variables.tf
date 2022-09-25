variable "namespace" {
  type = string
}

variable "client" {
  type = object({
    namespace = string
    name      = string
  })
}
