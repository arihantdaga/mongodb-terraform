terraform {
  required_version = "~> 1.2.2"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~>2.22.1"
    }
  }
}


provider "digitalocean" {
  token = var.do_token
}
