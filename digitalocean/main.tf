variable "do_token" {}

data "digitalocean_ssh_key" "mykey" {
  name = "do_workspace"
}

provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "master" {
  image     = "centos-7-x64"
  count     = 1
  name      = "master-${count.index}"
  region    = "sfo3"
#  size      = "s-1vcpu-512mb-10gb"
  size      = "s-1vcpu-1gb"
#  size      = "s-2vcpu-2gb"
  ssh_keys  = [data.digitalocean_ssh_key.mykey.id]
  user_data = file("user-data.sh")  
}

#resource "digitalocean_droplet" "worker" {
#  image     = "centos-7-x64"
#  count     = 2
#  name      = "worker-${count.index}"
#  region    = "sfo3"
#  size      = "s-1vcpu-512mb-10gb"
#  size      = "s-1vcpu-1gb"
#  ssh_keys  = [data.digitalocean_ssh_key.mykey.id]
#  user_data = file("user-data.sh")
#}
