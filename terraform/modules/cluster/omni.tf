resource "terraform_data" "controlplanes_machine_configs" {
  depends_on = [ proxmox_virtual_environment_vm.controlplanes]
  for_each = { for i,node in var.controlplanes.nodes : i => node }

  input = {
      "UUID" = random_uuid.controlplanes_uuids[each.key].result
      "NETWORK_CONFIG_INTERNAL_VLAN_ID" = var.network_config.internal_vlan_id
      "NETWORK_CONFIG_CIDR" = var.network_config.cidr
      "NETWORK_CONFIG_SUBNET" = var.network_config.subnet
      "NETWORK_CONFIG_IP_GATEWAY" = var.network_config.ip_gateway
      "NETWORK_CONFIG_DNS" = join("\",\"", var.network_config.dns)
      "IP" = each.value.ip
      "NAME" = var.name
      "DOMAIN" = var.domain
      "KEY" = each.key
    }
  
  provisioner "local-exec" {
    when = create
    environment = self.input
    command = "envsubst < machineconfig-controlplane.template.yaml | cat; envsubst < machineconfig-controlplane.template.yaml | ./omnictl apply -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = self.output
    command = "./omnictl delete ConfigPatches 600-$UUID; ./omnictl delete MachineLabels $UUID"
  }
}

resource "terraform_data" "workers_machine_configs" {
  depends_on = [ proxmox_virtual_environment_vm.workers]
  for_each = { for i,node in var.workers.nodes : i => node }

  input = {
      "UUID" = random_uuid.workers_uuids[each.key].result
      "NETWORK_CONFIG_INTERNAL_VLAN_ID" = var.network_config.internal_vlan_id
      "NETWORK_CONFIG_EXTERNAL_VLAN_ID" = var.network_config.external_vlan_id
      "NETWORK_CONFIG_CIDR" = var.network_config.cidr
      "NETWORK_CONFIG_SUBNET" = var.network_config.subnet
      "NETWORK_CONFIG_IP_GATEWAY" = var.network_config.ip_gateway
      "NETWORK_CONFIG_DNS" = join("\",\"", var.network_config.dns)
      "IP" = each.value.ip
      "PUBLIC_IP" = var.network_config.public_ip
      "NAME" = var.name
      "DOMAIN" = var.domain
      "KEY" = each.key
    }
  
  provisioner "local-exec" {
    when = create
    environment = self.input
    command = "envsubst < machineconfig-worker.template.yaml | cat; envsubst < machineconfig-worker.template.yaml | ./omnictl apply -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = self.output
    command = "./omnictl delete ConfigPatches 600-$UUID; ./omnictl delete MachineLabels $UUID"
  }
}

resource "terraform_data" "machine_classes" {

  input = var.name

  provisioner "local-exec" {
    when = create
    environment = {
      "NAME" = var.name
    }
    command = "envsubst < machineclasses.template.yaml | cat; envsubst < machineclasses.template.yaml | ./omnictl apply -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = {
      "NAME" = self.output
    }
    command = "./omnictl delete machineclass $NAME-controlplane; ./omnictl delete machineclass $NAME-worker"
  }
}

resource "terraform_data" "cluster" {

  depends_on = [ proxmox_virtual_environment_vm.controlplanes, proxmox_virtual_environment_vm.workers, terraform_data.machine_classes, terraform_data.controlplanes_machine_configs, terraform_data.workers_machine_configs ]
  input = {
    "NAME" = var.name
    "K8S_VERSION" = var.k8s_version
    "TALOS_VERSION" = var.talos_version
  }

  provisioner "local-exec" {
    when = create
    environment = self.input
    command = "envsubst < cluster.template.yaml | cat; envsubst < cluster.template.yaml | ./omnictl cluster template sync -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = self.output
    command = "envsubst < cluster.template.yaml | cat; envsubst < cluster.template.yaml | ./omnictl cluster template delete -v --destroy-disconnected-machines -f /dev/stdin &;"
  }
}