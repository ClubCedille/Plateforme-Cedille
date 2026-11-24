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

variable "cluster_name" {
  type = string
}

variable "netdata_space_id" {
  type = string
}

variable "netdata_token" {
  type      = string
  sensitive = true
}
