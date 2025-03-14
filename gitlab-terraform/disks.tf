resource "proxmox_virtual_environment_vm" "gitlab_disks" {
  node_name = "proxmoxlab"
  started = false
  on_boot = false

  disk {
    datastore_id = "truenas-lvmthin"
    file_format  = "raw"
    interface    = "scsi1"
    size         = 50
  }
}