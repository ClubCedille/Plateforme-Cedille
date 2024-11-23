resource "random_uuid" "controlplanes_uuids" {
  count = length(var.controlplanes.nodes)
}

resource "random_uuid" "workers_uuids" {
  count = length(var.workers.nodes)
}

resource "proxmox_virtual_environment_vm" "controlplanes" {
  for_each = { for i,node in var.controlplanes.nodes : i => node }
  
  name = "${var.name}-controlplane-${each.key}"
  node_name = each.value.proxmox_node

  tags = ["K8S-CONTROLPLANE", "TERRAFORM", var.owner_tag, var.environment_tag]
  # vm_id = var.proxmox_base_id + parseint(each.key, 10)

  cpu {
    cores = var.controlplanes.cpu_cores
    type = "host"
    numa = false
  }

  memory {
    dedicated = var.controlplanes.memory
    # hugepages = "disable"
  }

  disk {
    size = var.controlplanes.disk_size
    interface = "scsi0"
    datastore_id = var.cephrbd_datastore_id
    file_format = "raw"
  }

  cdrom {
    enabled = true
    file_id = "${var.cephfs_datastore_id}:${var.talos_image_id}"
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr1"
  }

  on_boot = true

  smbios {
    uuid = "${random_uuid.controlplanes_uuids[each.key].result}"
  }
}

resource "proxmox_virtual_environment_vm" "workers" {
  for_each = { for i,node in var.workers.nodes : i => node }
  
  name = "k8s-${var.name}-worker-${each.key}"
  node_name = each.value.proxmox_node
  # vm_id = var.proxmox_base_id + 10 + parseint(each.key, 10) //first 10 reserved for controlplanes
  tags = ["K8S-WORKER", "TERRAFORM", var.owner_tag, var.environment_tag]

  cpu {
    cores = var.workers.cpu_cores
    type = "host"
    numa = false
  }

  memory {
    dedicated = var.workers.memory
    # hugepages = "disable"
  }

  disk {
    size = var.workers.disk_size
    interface = "scsi0"
    datastore_id = var.cephrbd_datastore_id
    file_format = "raw"
  }

  cdrom {
    enabled = true
    file_id = "${var.cephfs_datastore_id}:${var.talos_image_id}"
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr1"
  }

  on_boot = true

  smbios {
    uuid = "${random_uuid.workers_uuids[each.key].result}"
  }
}

