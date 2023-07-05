locals {
  instance = {
    image  = "ubuntu-22-04-x64"
    name   = "ProFileOrg-dev"
    region = "sgp1"
    size   = "s-4vcpu-8gb"
    dns_record = {
      base       = "dev-profileorg"
      api        = "api-dev-profileorg"
      traefik    = "traefik-dev-profileorg"
      prometheus = "prom-dev-profileorg"
      grafana    = "grafana-dev-profileorg"
    }
  }
}