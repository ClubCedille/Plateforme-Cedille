terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.4.0"
    }
    tfe = {
      source = "hashicorp/tfe"
      version = "0.50.0"
    }
  }
}
