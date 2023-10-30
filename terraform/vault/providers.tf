terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.1"
    }
  }
}