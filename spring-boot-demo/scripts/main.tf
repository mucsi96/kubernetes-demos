locals {
  hostname                  = "demo.ibari.ch"
  namespace                 = "spring-boot-demo"
  email                     = "mucsi96@gmail.com"
  certificate_issuer_server = "https://acme-v02.api.letsencrypt.org/directory"
  spring-boot-admin = {
    host = "spring-boot-admin-server"
    port = 9090
  }
}

module "client" {
  source       = "./modules/client"
  namespace    = local.namespace
  image_name   = "mucsi96/${local.namespace}-client"
  host         = "app-client"
  port         = 80
  metrics_port = 8085
}

module "database" {
  source    = "./modules/database"
  namespace = local.namespace
  name      = local.namespace
}

module "server" {
  source     = "./modules/server"
  namespace  = local.namespace
  image_name = "mucsi96/${local.namespace}-server"
  host       = "app-server"
  port       = 8080
  database = {
    host       = module.database.host
    port       = module.database.port
    name       = module.database.name
    username   = module.database.username
    papassword = module.database.papassword
  }
  management_port = 8082
  admin_server    = local.spring-boot-admin
}

module "ingress" {
  source                    = "./modules/ingress"
  namespace                 = local.namespace
  hostname                  = local.hostname
  client_host               = "app-client"
  server_host               = "app-server"
  certificate_issue_email   = local.email
  certificate_issuer_server = local.certificate_issuer_server
  tls_secret_name           = "app-tls-secret"
}

module "cert-manager" {
  source = "./modules/cert-manager"
}

module "sealed-secrets" {
  source = "./modules/sealed-secrets"
}

module "kubernetes-dashboard" {
  source = "./modules/kubernetes-dashboard"
}

module "spring-boot-admin" {
  source     = "./modules/spring-boot-admin"
  namespace  = local.namespace
  image_name = "mucsi96/${local.namespace}-admin-server"
  host       = local.spring-boot-admin.host
  port       = local.spring-boot-admin.port
}

module "monitoring" {
  source           = "./modules/monitoring"
  namespace        = "monitoring"
  scrape_namespace = local.namespace
}
