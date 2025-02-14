variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
}

variable "virtual_environment_username" {
  type        = string
  description = "Proxmox host username"
}

variable "virtual_environment_password" {
  type        = string
  description = "Proxmox host user password"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}
