terraform {
  required_providers {
    argocd = {
      source = "argoproj-labs/argocd"
      version = "7.0.3"
    }
  }
}

provider "argocd" {
  server     = var.argocd_server
  auth_token = data.kubernetes_secret.argocd_manager.data["token"]
  insecure   = true
}