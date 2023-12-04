terraform {
  required_version = ">= 0.12"
  
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "cedille"

    workspaces {
      name = "Plateforme-Cedille"
    }
  }
}

provider "google" {
  project = var.gcloud_project
  region  = var.gcloud_region
}

provider "kubernetes" {
  host = var.kube_host
  token = var.kube_token
}

provider "github" {
  owner = var.gh_owner
  app_auth {
    id              = var.gh_app_id              # or `GITHUB_APP_ID`
    installation_id = var.gh_install_id # or `GITHUB_APP_INSTALLATION_ID`
    pem_file        = var.gh_pem        # or `GITHUB_APP_PEM_FILE`
  }
}