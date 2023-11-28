terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.42.0"
    }
  }
}

provider "github" {
  # Configuration options
}