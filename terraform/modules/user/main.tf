# Add a user to the organization
resource "github_membership" "user_membership" {
  username = var.github_username
  role     = var.github_role
}

resource "github_team_membership" "user_team_memberships" {
  for_each = { for v in var.teams : v.teamName => v.teamRole }
  team_id  = each.key
  username = var.github_username
  role     = each.value
}

# Kubernetes access is expressed through groups, not through the cluster_role.
# Omni adds system:masters to every Operator/Admin, and ACLs cannot remove it.
locals {
  default_kubernetes_groups = {
    None     = []
    Reader   = ["cedille-reader"]
    Operator = []
    Admin    = []
  }

  kubernetes_groups = var.kubernetes_groups != null ? var.kubernetes_groups : lookup(local.default_kubernetes_groups, var.cluster_role, [])

  omni_rule = {
    users    = [var.github_email]
    clusters = [var.cluster_name]
    role     = var.cluster_role
    kubernetes = {
      impersonate = {
        groups = local.kubernetes_groups
      }
    }
  }
}

resource "github_repository_file" "omni_acl" {
  repository     = var.cluster_repo
  file           = "omni/${var.github_username}.acl.yaml"
  commit_message = "Creating/Updating user [Automated]"
  content = join("\n", [
    "# MANAGED BY TERRAFORM; DO NOT MODIFY",
    yamlencode({
      spec = {
        rules = [local.omni_rule]
        tests = [
          {
            name = "${var.github_username} maps to expected Kubernetes groups on ${var.cluster_name}"
            user = {
              name = var.github_email
            }
            cluster = {
              name = var.cluster_name
            }
            expected = {
              role = var.cluster_role
              kubernetes = {
                impersonate = {
                  groups = local.kubernetes_groups
                }
              }
            }
          }
        ]
      }
    })
  ])
}

# Netdata Cloud is being decommissioned. Forget the membership without
# calling the Netdata API: the space is cancelled separately and the provider
# has been removed from the configuration.
removed {
  from = netdata_space_member.cedille_membership

  lifecycle {
    destroy = false
  }
}
