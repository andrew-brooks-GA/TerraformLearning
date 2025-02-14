resource "proxmox_virtual_environment_vm" "template-vm" {  # Change the resource name.
  name        = "template"
  node_name = "proxmoxlab"
  
  clone {
    vm_id = 9999
  }

    agent {
    enabled = true
  }

  cpu {
  sockets = 2
  cores   = 2
  type    = "Broadwell"
  }
  
  memory {
    dedicated = 8192
  }

  disk {
    datastore_id = "cheapssds"
    file_format  = "raw"
    interface    = "scsi0"
    size         = 10
  }

  # attached disks from data_vm
  dynamic "disk" {
    for_each = { for idx, val in proxmox_virtual_environment_vm.persistent-disks-template.disk : idx => val }  # Change persistent-disks-template to match the resource name in disks.tf
    iterator = data_disk
    content {
      datastore_id      = data_disk.value["datastore_id"]
      path_in_datastore = data_disk.value["path_in_datastore"]
      file_format       = data_disk.value["file_format"]
      size              = data_disk.value["size"]
      interface         = "scsi${data_disk.key + 1}"
    }
  }
  
  initialization {
    datastore_id = "cheapssds"
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
}





