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
  }
}

provider "google" {
  project = var.gcloud_project
  region  = var.gcloud_region
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "cedille-cedille-cluster"
}