terraform {
  required_version = ">= 0.12"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    tfe = {
      version = "~> 0.50.0"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "0.66.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "proxmox" {
  username = "root@pam"
  password = ""
  endpoint = "https://10.0.21.51:8006/api2/json"
  insecure = true
  random_vm_ids = false
  
}