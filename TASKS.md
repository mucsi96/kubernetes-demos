- deploy helm template with terraform as part of CI pipeline
- add scheduled backups from db to s3 (mysqldumb)
- add metrics https://k3s.rocks/metrics/ https://getbetterdevops.io/terraform-with-helm/
- add logging https://grafana.com/blog/2022/04/26/set-up-and-observe-a-spring-boot-application-with-grafana-cloud-prometheus-and-opentelemetry/ https://getbetterdevops.io/terraform-with-helm/
- add script to open Traefik Dashboard https://k3s.rocks/traefik-dashboard/ https://doc.traefik.io/traefik/operations/dashboard/
- add helm tests
- use helm lookup function to avoid upgrading ssl and kubernetes dashboard https://helm.sh/docs/chart_template_guide/functions_and_pipelines/#using-the-lookup-function
- generate random secrets https://registry.terraform.io/providers/hashicorp/random/latest/docs


- add docker provider dockerhub auth example (authtoken can be password)
- add support for tags in docker provider