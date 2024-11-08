name = "k8s-test-tf-2"
cephfs_datastore_id = "CephFS"
cephrbd_datastore_id = "RBD_Common"
domain = "etsmtl.club"
proxmox_base_id = 300000


# net.ifnames=0 vlan=eth0.30:eth0 ip=eth0.30:dhcp
talos_image_id = "iso/metal-amd64-omni-cedille-v1.8.0-2.iso"
tfe_gh_oauth_token_id = "value"

network_config = {
  internal_vlan_id = 21
  external_vlan_id = 247
  cidr = 24
  subnet = "10.0.21.0"
  dns = ["1.1.1.1", "1.0.0.1"]
  ip_gateway = "10.0.21.1"
}

controlplanes = {
  cpu_cores = 4
  disk_size = 40
  memory = 4096
  nodes = [
    {
      ip = "10.0.21.10"
      proxmox_node = "pve01"
    },
    # {
    #   ip = "10.0.21.11"
    #   proxmox_node = "pve02"
    # },
    # {
    #   ip = "10.0.21.12"
    #   proxmox_node = "pve03"
    # }
  ]
}
workers = {
  cpu_cores = 12
  disk_size = 100
  memory = 16384
  nodes = [
    {
      ip = "10.0.21.13"
      proxmox_node = "pve01"
    },
    # {
    #   ip = "10.0.21.14"
    #   proxmox_node = "pve02"
    # },
    {
      ip = "10.0.21.15"
      proxmox_node = "pve03"
    }
  ]
}

talos_version = "v1.8.0"
k8s_version = "v1.30.0"