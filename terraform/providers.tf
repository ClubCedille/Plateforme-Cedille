terraform {
  required_version = ">= 1.7"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.13"
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
