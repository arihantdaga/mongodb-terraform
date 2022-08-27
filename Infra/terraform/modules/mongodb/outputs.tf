output "ids" {
  value = digitalocean_droplet.mongodbdroplets.*.id
}

output "private_ips" {
  value = digitalocean_droplet.mongodbdroplets.*.ipv4_address_private
}

resource "local_file" "ansible_inventory" {
content = templatefile("${path.module}/ansible_inventory.tmpl",
  {
  ip_mongo_nodes = digitalocean_droplet.mongodbdroplets.*.ipv4_address_private
  hostname_mongo_nodes = digitalocean_droplet.mongodbdroplets.*.ipv4_address
  mongodb_port = var.mongodb_port
  replica_set_name = var.replica_set_name

  })
filename = "${path.module}/../../../ansible/mongodb/inventory"
}

resource "local_sensitive_file" "ssh_private_key" {
    content =  tls_private_key.key.private_key_pem
    filename = "${path.module}/../../../ansible/mongodb/ssh_key.pem"
    file_permission = "0400"
} 

resource "local_file" "ssh_public_key" {
  filename       = "${path.module}/../../../ansible/mongodb/ssh_key.pub"
  content = tls_private_key.key.public_key_pem
}
