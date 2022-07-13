terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
}

# Configure the docker provider
provider "docker" {}

# Create a docker image resource
# -> docker pull nginx:latest
#resource "docker_image" "myapp_image" {
#  name         = "kogoon/test_commit:1.0"
#  keep_locally = false
#}

data "docker_registry_image" "specific" {
  name      = "kogoon/test_commit:1.0"
}

resource "docker_image" "kogoon" {
  name          = data.docker_registry_image.specific.name
  pull_triggers = [data.docker_registry_image.specific.sha256_digest] 
}

# Create a docker container resource
# -> same as 'docker run --name nginx -p 8080:80 -d nginx:latest'
resource "docker_container" "myapp" {
  image = docker_image.kogoon
  name  = var.container_name
  ports {
    internal = 80
    external = 8000
  }
}

# Or Create a service resource
# -> same as 'docker service create -d -p 


