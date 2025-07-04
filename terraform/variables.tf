variable "gcloud_region" {
  type = string
}

variable "gcloud_project" {
  type = string
}

variable "kube_host" {
  type = string
}

variable "kube_token" {
  type      = string
  sensitive = true
}

variable "gh_owner" {
  type = string
}

variable "gh_app_id" {
  type = string
}

variable "gh_install_id" {
  type = string
}

variable "gh_pem" {
  type      = string
  sensitive = true
}

variable "platform_repo" {
  type = string
}

variable "tfe_workspace" {
  type = string
}

variable "cluster_ca" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "netdata_token" {
  type = string
  sensitive = true
}

variable "tfe_gh_oauth_token_id" {
  type = string
}

variable "tfe_token" {
  type = string
  sensitive = true
}

variable "netdata_role" {
  type = string
  default = "observer"
}