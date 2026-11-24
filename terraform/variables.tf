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
  type        = string
  default     = "k8s-shared"
  description = "Omni cluster name (ID), e.g. k8s-shared. Must be a real cluster or the generated ACL rule matches nothing."

  validation {
    condition     = can(regex("^k8s-", var.cluster_name))
    error_message = "cluster_name must be a real Omni cluster ID such as k8s-shared (the legacy \"cedille-cluster\" no longer exists)."
  }
}
