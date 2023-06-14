locals {
  instance = {
    image = "ubuntu-22-04-x64"
    name = "ProFileOrg-dev"
    region = "sgp1"
    size = "s-1vcpu-1gb"
    dns_record = {
        base = "dev.profileorg"
        api = "api.dev.profileorg"
    }
  }
}