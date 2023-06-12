resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "digitalocean_ssh_key" "profileorg" {
  name       = "Terraform ssh key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "digitalocean_droplet" "profileorg_dev" {
  image    = "ubuntu-22-04-x64"
  name     = "ProFileOrg-dev"
  region   = "sgp1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.profileorg.fingerprint]
}

resource "cloudflare_record" "profileorg_dev" {
  depends_on = [digitalocean_droplet.profileorg_dev]
  zone_id    = var.zone_id
  name       = "profileorg-dev"
  value      = digitalocean_droplet.profileorg_dev.ipv4_address
  type       = "A"
}