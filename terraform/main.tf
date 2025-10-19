resource "digitalocean_droplet" "workers" {
  count  = 3
  name   = "infra-${count.index + 1}"
  region = "fra1"
  size   = "s-1vcpu-512mb-10gb"
  image  = "ubuntu-24-04-x64"
  monitoring = true
  ssh_keys = [var.ssh_fingerprint]
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("${path.module}/inventory.tpl", {
    droplet_ips = digitalocean_droplet.workers[*].ipv4_address
    droplet_names = digitalocean_droplet.workers[*].name
    ssh_private_key_path = pathexpand(var.ssh_private_key_path)
  })
  filename = "${path.module}/../ansible/inventory.ini"
}

