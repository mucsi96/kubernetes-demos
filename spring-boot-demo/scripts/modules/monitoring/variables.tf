variable "namespace" {
  type = string
}

variable "client" {
  type = object({
    namespace  = string
    host       = string
    stats_port = string
  })
}
