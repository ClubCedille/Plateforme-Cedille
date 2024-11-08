variable "name" {
  type = string
}

variable "tfe_gh_oauth_token_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "controlplanes" {
  type = object({
    nodes = list(object({
      ip = string,
      proxmox_node = string,
    })),
    cpu_cores = number,
    memory = number,
    disk_size = number,
  })

  validation {
     condition = anytrue([
        length(var.controlplanes.nodes) == 1,
        length(var.controlplanes.nodes) == 3,
        length(var.controlplanes.nodes) == 5
        ])
    error_message = "must have 1, 3 or 5 nodes"
  }
}

variable "workers" {
  type = object({
    nodes = list(object({
      ip = string,
      proxmox_node = string,
    })),
    cpu_cores = number,
    memory = number,
    disk_size = number,
  })
}

variable "network_config" {
  type = object({
    internal_vlan_id = number,
    external_vlan_id = number,
    subnet = string,
    cidr = number,
    ip_gateway = string,
    dns = list(string),
  })
  
}

variable "proxmox_base_id" {
    type = number
}

variable "talos_image_id" { // "iso/metal-amd64-omni-cedille-v1.7.6.iso"
  type = string
}

variable "cephfs_datastore_id" { //Ceph_Common
  type = string
}

variable "cephrbd_datastore_id" { //Ceph_Common
  type = string
}

variable "talos_version" {
  type = string
}

variable "k8s_version" {
  type = string
  
}