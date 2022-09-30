locals {
  namespace = "spring-boot-demo"
}

module "client" {
  source     = "./modules/client"
  namespace  = local.namespace
  image_name = "mucsi96/${local.namespace}-client"
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
  database = {
    host     = module.database.host
    port     = module.database.port
    name     = module.database.name
    username = module.database.username
    password = module.database.password
  }
  admin_server = {
    host = module.spring-boot-admin.host
    port = module.spring-boot-admin.port
  }
}

module "ingress" {
  source      = "./modules/ingress"
  namespace   = local.namespace
  hostname    = "demo.ibari.ch"
  client_host = module.client.host
  server_host = module.server.host
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
}

module "monitoring" {
  source           = "./modules/monitoring"
  namespace        = "monitoring"
  scrape_namespace = local.namespace
}
