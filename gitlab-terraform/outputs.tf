output "vm_id" {
  description = "The ID of the cloned VM"
  value       = proxmox_virtual_environment_vm.gitlab-vm.id
}