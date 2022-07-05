terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      versoin = "~> 2.0"
    }
  }
}

viriable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

# Create a web server

