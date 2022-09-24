locals {
  hostname                  = "demo.ibari.ch"
  namespace                 = "spring-boot-demo"
  email                     = "mucsi96@gmail.com"
  certificate_issuer_server = "https://acme-v02.api.letsencrypt.org/directory"
  database = {
    host          = "app-database"
    port          = 3306
    name          = local.namespace
    root_password = "AgAwRhwa2K6F0aeaND1rfR8JqnBq3/adpSrpwNe/ZUuM8eom1h1eZm+Nloov2UVK/haUK9QYGBZUkwY4RLSOMiuiegBkn3afdPXKUHaccvvCiQneBNnR6KgMLzrF0QuuqtXNcGB2Uz3jS31KeYhjNdHa0DW11Y1LZeSCAWoQk2Hvlju/4OVEy76set21oOBTe7AV6rYPh/nPvL5H8TU36isCuPvDr1p8sUz+cEXr97iKubv/bduWV/z2ZgYQA+QlpBEDhWf448ijL+dENnI1QaUydfmRYFa6EaFYrPgmv06EWzQrLc0xxpxryrhSv/rprSR3Cw/ugdC3qCcpNZuDgAYRDH6wyHqRuUrWiU/DirNof+qooVf4rd0kFvBjLVmPyFa5FczHyyMrk0Bw5QFxFCr7/hJcpPMRpb1O9UqMPRsyUVqNawFuufE7mDjqcmTon0pfl+04gLKSr+aA+vgtJuc2RIZxENc7tP9QQMhWBz07SNwIEFcgRqMg6T8B2OM1iqRJF3k2354weoCecPhMmAqEKfbCMG70nba1heUoQMICRMLdbqQRaB6wkTcTAHoqVqiSbuSTgDP8++Ibfk/VmChWEb5/L1KKazNWGwjbZT+8c8Aq8hoQdSecLvFu2zXJJNdN0Php2/ANmztnk+85eayO0gle8Js4YMTJsR8Ew9PLkIIn6aQrL2MpHORO2BgmNYrGvcEuhQ6pzzGVcFr3LgQp"
    username      = "AgAcvCEeDAMxqAo8FfaQPJkO1s0+kpts6eiNoiZ+ugHt5TuAVoVeH4ns/TLOGv6MMtPPIxPL57pKhtWLKr5MVashLR3i1JrpZ094gqbS9vyk4jkkabKXS9sqdFy+P0LDu9OOydsNnsHAl9IkHPoDcAXdEt+TGZl/PLkdIvots3ZJXqBzrWuU0dEG1gifYnP5oA1AJiIC463YgbFEh7v1JCLe3lPa0Z3EM2goFsapdKTzXW4MlwNaZ+oIL9k0ZdwZaXKVja4WjuIuzotMD5ejMVWps27dYoVpBZ8FkHlZtfW4bnbM1PWxgMCKn4WeYen3UmQJz5M9UZAYxWG6wMDWoy/e8k+aziFa88jAlUn0JhrFL3EPk5jeqf4X+/OgaxmULiwzRW6OxQ90baio6lm1X/TBDqU5IGPVFcfnW6+8cKwQFuIxVwbH0vw0LYyOT47tElL4YVjDOPnuR0K0z1vZPTt+nvhjR35HWbYuAqF0RX6EUaSGT4TMFvhLcIvya9Ht/lXGKePjIChSGV71ykhcM/MYm4yI9WfO9ZYosl7nr5O9aDXw7WJ63+QxTrUCuJkFcCjtkOrY/wqtKpGgYzVingsTk8X4K+wbT/32rCoOxhjJSwf4csmDBEWMerB/Em7DED+HLZlVYirq8FOOo4u9ZcAzg0zaOlhDyrFPNuY1ylY+IFQMdgTCVnkJQDzZSCMphbmiuGynqAKDRw=="
    password      = "AgDZJXPHdTTubhQO+KVlKmGbMOZ7eWRi2twGOd7Ly2qxYMkK7dZ+qPAkoOiZ/TcmAXvez0LxgDOc4ZdCIBKfmYK63GL9RoMTDaFwlM74eNdyqSdCfDKgyuqW+duFPo0Y3JMcPpcCcyI0pvWcj2hmoNURHQK7TyAhzU6AZuJRAJjeM1NTrrqCstkuw+vr6NPcGMGUsPPWyW3XUmfejZQdTIVJqzVKdywvNL4PQ3Ib1tdidj9XUJxRJyOwi2NeE3eRsfeLhElMe2hz/kK53+1A4/YxUMSGv3lz0xKbyZEgrLTbO0nxLYQqx0iKoP9J2zHvz26c0SbgMsaQEHNLmnsDQ1HY68K60o05Dz/5CVoMDn1r5izsYCgixMb8a6pBw2ZaP3LrJo6ZLgp9XlnIxabIdnP39cjtJPsD0OYhqkRsysD5FnLEo3Ffz6MWFipmxDwI37xJNxTQhUvb43StamWd1z2Pe8qMNY+tlWNouC0887uLOXmipSzO1XUjbJrXRguPbiqTFBJvmOLH3yS2X11JRHU1GJjy8/0H5M7IRMIqLSedV1SRd9efozgZqNiFXK/fRe0OtcnQq794MxqSX8AHxV38Nq9oBOWqXqTb/GTBDroTozzaVTQ3HRfEyhTqsS5wYNUtKU/Bx7qO1Y5TfRRq0DAd8eAc78ZeqXvBlaqbV+LUDCN0XjNWYWk3FWxaYh/RrYcsONHgmIHDdTXxzm3TN7N2"
  }
  spring-boot-admin = {
    host = "spring-boot-admin-server"
    port = 9090
  }
}

module "client" {
  source     = "./modules/client"
  namespace  = local.namespace
  image_name = "mucsi96/${local.namespace}-client"
  host       = "app-client"
  port       = 80
}

module "server" {
  source          = "./modules/server"
  namespace       = local.namespace
  image_name      = "mucsi96/${local.namespace}-server"
  host            = "app-server"
  port            = 8080
  database        = local.database
  management_port = 8082
  admin_server    = local.spring-boot-admin
}

module "database" {
  source        = "./modules/database"
  namespace     = local.namespace
  host          = local.database.host
  port          = local.database.port
  name          = local.database.name
  root_password = local.database.root_password
  username      = local.database.username
  password      = local.database.password
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

# module "monitoring" {
#   source    = "./modules/monitoring"
#   namespace = "monitoring"
#   database  = local.database
# }
