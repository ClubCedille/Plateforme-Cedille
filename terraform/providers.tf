terraform {
  required_version = ">= 1.7"

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

# Temporary: three legacy module.gcp resources are still in state
# (google_project_iam_member, google_service_account and
# google_service_account_key). Destroying them requires the Google provider
# to be configured, even though its module was removed from the config.
# Credentials and project come from the standard environment:
#   GOOGLE_APPLICATION_CREDENTIALS, GOOGLE_PROJECT, GOOGLE_REGION
provider "google" {}
