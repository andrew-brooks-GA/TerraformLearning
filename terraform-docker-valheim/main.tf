terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
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

  volumes {
    container_path = "/config"
    volume_name    = "shared_volume"
    read_only      = false
  }

  env = [
    "SERVER_NAME=${var.ServerName}",
    "WORLD_NAME=${var.WorldName}",
    "SERVER_PUBLIC=${var.ServerPublic}",
    "BACKUPS=${var.Backups}",
    "TZ=${var.Timezone}"
  ]
}


