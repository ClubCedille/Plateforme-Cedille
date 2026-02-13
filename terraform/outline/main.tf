terraform {
  required_providers {
    authentik = {
      source = "goauthentik/authentik"
      version = "2025.6.0"
    }
  }
}

provider "authentik" {
  # Configuration options
  url = "https://auth.etsmtl.club"
  token = var.authentik_api_token
}
