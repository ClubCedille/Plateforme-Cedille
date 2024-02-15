variable "github_email" {
  type = string
}

variable "github_username" {
  type = string
}

variable "github_role" {
  type = string
  default = "member"
  validation {
    condition = var.github_role == "member" || var.github_role == "admin"
    error_message = "Must be member or admin"
  }
}

variable "teams" {
  type = list(object({
    teamName = string,
    teamRole = string
  }))
  validation {
    condition = alltrue([for o in var.teams : o.teamRole == "member" || o.teamRole == "maintainer"])
    error_message = "Must be member or maintainer"
  }
}

variable "cluster_name" {
  type = string
}

variable "cluster_role" {
  type = string
  validation {
    condition = var.cluster_role == "Operator" || var.cluster_role == "Admin" || var.cluster_role == "Member" || var.cluster_role == "None"
    error_message = "cluster_role must be one of: Operator, Admin, Member or None"
  }
}

variable "cluster_repo" {
  type = string
}