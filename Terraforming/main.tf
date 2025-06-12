terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "flask_app" {
  name = "myflaskapp:latest"
  build {
    context = "${path.module}/flask_app"
  }
}

resource "docker_container" "flask_container" {
  name  = "flask-app"
  image = docker_image.flask_app.name

  ports {
    internal = 5000
    external = 5000
  }
}
