terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

// SSH Key
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "private_key" {
  filename          = "${path.module}/tf-mongodb-key.pem"
  content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

resource "digitalocean_ssh_key" "mongodb_ssh_key" {
  name       = "tf-mongodb-ssh-key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "digitalocean_ssh_key" "mongodb_ssh_key_user" {
  name       = "tf-mongodb-ssh-key-user"
  public_key = file(var.ssh_key_path)
}
  

// Droplets
resource "digitalocean_droplet" "mongodbdroplets" {
  count = var.instance_count

  image     = "ubuntu-20-04-x64"
  name      = "mongodb"
  region    = var.mongodb_region
  size      = var.instance_type
  ssh_keys = [digitalocean_ssh_key.mongodb_ssh_key.fingerprint, digitalocean_ssh_key.mongodb_ssh_key_user.fingerprint]
  tags = ["mongodb"]
  # TODO: Add userdata and create a new user instead of root user. 
}

// Firewall rules
resource "digitalocean_firewall" "mongodbfirewall" {
    name = "mqtt-firewall"
    tags = [ "mqttnew" ]
    inbound_rule  {
      protocol = "tcp"
      port_range    = "22"
      source_tags = [ "mongodb" ]
    }

    inbound_rule  {
      protocol = "tcp"
      port_range    = var.mongodb_port
      source_tags = [ "mongodb" ]
    }

    outbound_rule {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
    outbound_rule {
      protocol              = "tcp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
      port_range = "1-65535"
    }
    outbound_rule {
      protocol              = "udp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
      port_range = "1-65535"
    }
}

resource "null_resource" "ssh_connection" {
  depends_on = [digitalocean_droplet.mongodbdroplets]
  count = var.instance_count
  connection {
    type        = "ssh"
    host        = digitalocean_droplet.mongodbdroplets[count.index].ipv4_address
    user        = "root"
    private_key = tls_private_key.key.private_key_pem
  }

  # create init script
  provisioner "file" {
    content     = templatefile("${path.module}/scripts/init.sh", { local_ip = digitalocean_droplet.mongodbdroplets[count.index].ipv4_address_private })
    destination = "/tmp/init.sh"
  }

  # download MongoDB
  provisioner "remote-exec" {
    inline = [
      "ls"
      // TODO
    ]
  }

  # init system
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh",
    ]
  }
  
}
resource "null_resource" "mongodb_replicaset" {
  // TODO: Create admin username, password
  // Initialize replica sets. 
  
}


