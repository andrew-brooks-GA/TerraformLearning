terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "valheim-server" {
  name         = "lloesche/valheim-server"
  keep_locally = false
}

resource "docker_container" "valheim-server" {
  image = docker_image.valheim-server.repo_digest
  name  = "valheim-server"

  ports {
    internal = 2456
    external = 2456
    protocol = "udp"
  }

  ports {
    internal = 2457
    external = 2457
    protocol = "udp"
  }
}
