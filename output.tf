output "public_ip" {
  value = digitalocean_droplet.profileorg_dev.ipv4_address
  sensitive = true
}

output "ssh_private_keys" {
  value     = tls_private_key.ssh_key.private_key_openssh
  sensitive = true
}

output "instance_info" {
  value = local.instance
}