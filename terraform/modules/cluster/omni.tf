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
    command = "envsubst < machineclasses.template.yaml | cat; envsubst < machineclasses.template.yaml | ./omnictl delete -f /dev/stdin"
  }
}

resource "terraform_data" "cluster" {

  depends_on = [ proxmox_virtual_environment_vm.controlplanes, proxmox_virtual_environment_vm.workers, terraform_data.machine_classes ]
  input = var.name

  provisioner "local-exec" {
    when = create
    environment = {
      "NAME" = var.name
      "K8S_VERSION" = var.k8s_version
      "TALOS_VERSION" = var.talos_version
    }
    command = "envsubst < cluster.template.yaml | cat; envsubst < cluster.template.yaml | ./omnictl cluster template sync -f /dev/stdin"
  }

  provisioner "local-exec" {
    when = destroy
    environment = {
      "NAME" = self.output
    }
    command = "./omnictl cluster delete $NAME --destroy-disconnected-machines"
  }
}