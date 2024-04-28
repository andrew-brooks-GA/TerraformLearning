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
  
  cpu_set = var.cpu
  
  memory = var.memory

  ports { // Game port.
    internal = 2456
    external = var.server_port
    protocol = "udp"
  }

  ports { // Steam query port.
    internal = 2457
    external = 2457
    protocol = "udp"
  }

  volumes {
    container_path = "/config"
    volume_name    = "shared_volume"
    read_only      = false
  }

// Environment variable options can be found at "https://hub.docker.com/r/lloesche/valheim-server"
  env = [
    "SERVER_NAME=${var.server_name}",
    "WORLD_NAME=${var.world_name}",
    "SERVER_PUBLIC=${var.server_public}",
	"SERVER_PASS=${var.server_pass}",
	"SERVER_PORT=${var.server_port}",
    "BACKUPS=${var.backups}",
    "TZ=${var.timezone}"
  ]
}


