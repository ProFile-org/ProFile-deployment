resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "digitalocean_ssh_key" "profileorg" {
  name       = "Terraform ssh key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "digitalocean_droplet" "profileorg_dev" {
  image    = local.instance.image
  name     = local.instance.name
  region   = local.instance.region
  size     = local.instance.size
  ssh_keys = [digitalocean_ssh_key.profileorg.fingerprint]
}

resource "cloudflare_record" "profileorg_dev" {
  depends_on = [digitalocean_droplet.profileorg_dev]
  zone_id    = var.zone_id
  name       = local.instance.dns_record.base
  value      = digitalocean_droplet.profileorg_dev.ipv4_address
  type       = "A"
  proxied    = true
}

resource "cloudflare_record" "profileorg_dev_api" {
  depends_on = [digitalocean_droplet.profileorg_dev]
  zone_id    = var.zone_id
  name       = local.instance.dns_record.api
  value      = digitalocean_droplet.profileorg_dev.ipv4_address
  type       = "A"
  proxied    = true
}

resource "cloudflare_record" "traefik" {
  depends_on = [digitalocean_droplet.profileorg_dev]
  zone_id    = var.zone_id
  name       = local.instance.dns_record.traefik
  value      = digitalocean_droplet.profileorg_dev.ipv4_address
  type       = "A"
  proxied    = true
}