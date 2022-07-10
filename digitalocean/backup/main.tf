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
  count     = 1
  name      = "web-${count.index}"
  region    = "sfo3"
#  size      = "s-1vcpu-512mb-10gb"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.example.id]
  user_data = file("user-data.sh")  
}

