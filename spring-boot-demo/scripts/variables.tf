variable "run_number" {
  type = string
}

variable "docker_username" {
  type = string
}

variable "docker_access_token" {
  type = string
}

variable "kubernetes_host" {
  type = string
}

variable "kubernetes_client_certificate" {
  type = string
}

variable "kubernetes_client_key" {
  type = string
}

variable "kubernetes_cluster_ca_certificate" {
  type = string
}

variable "app_namespace" {
  default = "spring-boot-demo"
}