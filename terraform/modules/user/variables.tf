variable "github_email" {
  type = string
}

variable "github_username" {
  type = string
}

variable "github_role" {
  type    = string
  default = "member"
  validation {
    condition     = var.github_role == "member" || var.github_role == "admin"
    error_message = "Must be member or admin"
  }
}

variable "teams" {
  type = list(object({
    teamName = string,
    teamRole = string
  }))
  validation {
    condition     = alltrue([for o in var.teams : o.teamRole == "member" || o.teamRole == "maintainer"])
    error_message = "Must be member or maintainer"
  }
}

variable "cluster_name" {
  type = string
}

variable "cluster_role" {
  type = string
  validation {
    condition     = var.cluster_role == "Operator" || var.cluster_role == "Admin" || var.cluster_role == "Reader" || var.cluster_role == "None"
    error_message = "cluster_role must be one of: Operator, Admin, Reader or None"
  }
}

# Kubernetes groups to impersonate through the Omni AccessPolicy.
#
# This is the Kubernetes permission level, independent from the Omni role.
# Leave null to derive it from cluster_role:
#   None     -> []
#   Reader   -> ["cedille-reader"]
#   Operator -> [] (Omni already adds system:masters = cluster-admin)
#   Admin    -> [] (same)
#
# To give someone operator-level Kubernetes access without making them an
# Omni Operator (who would be cluster-admin everywhere), use
# cluster_role = "Reader" and kubernetes_groups = ["cedille-operator"].
variable "kubernetes_groups" {
  type        = list(string)
  default     = null
  description = "Kubernetes groups impersonated by Omni. Defaults based on cluster_role."

  validation {
    condition = var.kubernetes_groups == null || alltrue([
      for group in var.kubernetes_groups : contains(["cedille-reader", "cedille-operator"], group)
    ])
    error_message = "kubernetes_groups may only contain: cedille-reader, cedille-operator"
  }
}

variable "cluster_repo" {
  type = string
}
