resource "random_uuid" "controlplanes_uuids" {
  count = length(var.controlplanes.nodes)
}

resource "random_uuid" "workers_uuids" {
  count = length(var.workers.nodes)
}

resource "proxmox_virtual_environment_vm" "controlplanes" {
  for_each = { for i,node in var.controlplanes.nodes : i => node }
  
  name = "k8s-${var.name}-controlplane-${each.key}"
  node_name = each.value.proxmox_node
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

  provisioner "local-exec" {
    when = create
    environment = {
      "UUID" = random_uuid.controlplanes_uuids[each.key].result
      "NETWORK_CONFIG_EXTERNAL_VLAN_ID" = var.network_config.external_vlan_id
      "NETWORK_CONFIG_INTERNAL_VLAN_ID" = var.network_config.internal_vlan_id
      "NETWORK_CONFIG_CIDR" = var.network_config.cidr
      "NETWORK_CONFIG_SUBNET" = var.network_config.subnet
      "NETWORK_CONFIG_IP_GATEWAY" = var.network_config.ip_gateway
      "NETWORK_CONFIG_DNS" = join("\",\"", var.network_config.dns)
      "IP" = each.value.ip
      "NAME" = var.name
      "DOMAIN" = var.domain
      "ROLE" = "controlplane"
      "KEY" = each.key
    }
    command = "envsubst < machineconfig.template.yaml | cat; envsubst < machineconfig.template.yaml | ./omnictl apply -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = {
      "UUID" = self.smbios[0].uuid
    }
    command = "./omnictl delete ConfigPatches 600-$UUID; ./omnictl delete MachineLabels $UUID"
  }
}

resource "proxmox_virtual_environment_vm" "workers" {
  for_each = { for i,node in var.workers.nodes : i => node }
  
  name = "k8s-${var.name}-worker-${each.key}"
  node_name = each.value.proxmox_node
  # vm_id = var.proxmox_base_id + 10 + parseint(each.key, 10) //first 10 reserved for controlplanes

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

  provisioner "local-exec" {
    environment = {
      "UUID" = random_uuid.workers_uuids[each.key].result
      "NETWORK_CONFIG_EXTERNAL_VLAN_ID" = var.network_config.external_vlan_id
      "NETWORK_CONFIG_INTERNAL_VLAN_ID" = var.network_config.internal_vlan_id
      "NETWORK_CONFIG_CIDR" = var.network_config.cidr
      "NETWORK_CONFIG_SUBNET" = var.network_config.subnet
      "NETWORK_CONFIG_IP_GATEWAY" = var.network_config.ip_gateway
      "NETWORK_CONFIG_DNS" = join("\",\"", var.network_config.dns)
      "IP" = each.value.ip
      "NAME" = var.name
      "DOMAIN" = var.domain
      "ROLE" = "worker"
      "KEY" = each.key
    }
    command = "envsubst < machineconfig.template.yaml | cat;  envsubst < machineconfig.template.yaml | ./omnictl apply -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = {
      "UUID" = self.smbios[0].uuid
    }
    command = "./omnictl delete ConfigPatches 600-$UUID; ./omnictl delete MachineLabels $UUID"
  }
}

