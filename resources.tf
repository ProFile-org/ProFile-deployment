resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file(var.my_ssh_key)
}


resource "digitalocean_droplet" "profileorg" {
    image  = "ubuntu-22-04-x64"
    name   = "ProFileOrg"
    region = "sgp1"
    size   = "s-1vcpu-1gb"
    ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}