terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

data "digitalocean_ssh_key" "example" {
  name = "do_workspace"
}

provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "web" {
  image     = "centos-7-x64"
  name      = "web-1"
  region    = "sfo3"
  size      = "s-1vcpu-512mb-10gb"
  ssh_keys  = [data.digitalocean_ssh_key.example.id]
  user_data = file("user-data.sh")  
}

output "droplet_ip_address" {
  value = digitalocean_droplet.web.ipv4_address
}

