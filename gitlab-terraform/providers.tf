terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.virtual_environment_endpoint

  username = var.virtual_environment_username
  password = var.virtual_environment_password
  insecure = true
}