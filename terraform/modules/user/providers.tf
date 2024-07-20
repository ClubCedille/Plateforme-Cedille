terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.42.0"
    }
    netdata = {
      source = "netdata/netdata"
      version = "0.2.0"
    }
  }
}