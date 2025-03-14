resource "proxmox_virtual_environment_vm" "gitlab-vm" {
  # Basic VM configuration
  name        = "gitlab"
  node_name = "proxmoxlab"
  
  clone {
    vm_id = 9999
  }

    agent {
    enabled = true
  }

  cpu {
  sockets = 2
  cores   = 2  # 2 cores per socket * 2 sockets = 4 cores total
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
    for_each = { for idx, val in proxmox_virtual_environment_vm.gitlab_disks.disk : idx => val }
    iterator = data_disk
    content {
      datastore_id      = data_disk.value["datastore_id"]
      path_in_datastore = data_disk.value["path_in_datastore"]
      file_format       = data_disk.value["file_format"]
      size              = data_disk.value["size"]
      # assign from scsi1 and up
      interface         = "scsi${data_disk.key + 1}"
    }
  }
  
  initialization {
    datastore_id      = "cheapssds"
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
    ip_config {
      ipv4 {
        address = "192.168.2.125/24"
        gateway = "192.168.2.1"
      }
    }
  }

}





