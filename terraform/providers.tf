terraform {
  required_version = ">= 0.12"

  required_providers {
    # Temporary: needed only to destroy legacy module.gcp resources that are
    # still in state. Remove this block after the destroy apply.
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.13"
    }
    netdata = {
      source  = "registry.terraform.io/netdata/netdata"
      version = "0.2.0"
    }
  }

  backend "kubernetes" {
    namespace     = "terraform"
    secret_suffix = "state-plateforme-cedille"
    config_path   = "~/.kube/config"
  }
}

provider "github" {
  owner = var.gh_owner
  app_auth {
    id              = var.gh_app_id     # or `GITHUB_APP_ID`
    installation_id = var.gh_install_id # or `GITHUB_APP_INSTALLATION_ID`
    pem_file        = var.gh_pem        # or `GITHUB_APP_PEM_FILE`
  }
}

provider "netdata" {
  url        = "https://app.netdata.cloud"
  auth_token = var.netdata_token
}
