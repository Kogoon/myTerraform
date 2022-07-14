output "droplet_ip_address" {
  value = {
    for droplet in digitalocean_droplet.web:
    droplet.name => droplet.ipv4_address
  }
}

#output "droplet_docker_ip_address" {
#  value = {
#    for droplet in digitalocean_droplet.docker-client:
#    droplet.name => droplet.ipv4_address
#  }
#}

#output "docker_worker_ip" {
#  value = {
#    for droplet in digitalocean_droplet.worker:
#    droplet.name => droplet.ipv4_address
#  }
#}
