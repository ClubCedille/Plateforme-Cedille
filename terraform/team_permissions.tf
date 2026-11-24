# Organization-wide team repository permissions.
#
# GitHub organization secrets cannot be assigned to teams directly: secret
# access is granted to repositories (all/private/selected). Teams get access to
# a secret when they have access to one of its selected repositories.
#
# Repositories with github_repository_collaborators resources are excluded here
# because the provider does not allow both resources to manage the same repo.
# Their collaborators are updated in the owning resource instead.

data "github_organization" "this" {
  name                  = var.gh_owner
  ignore_archived_repos = true
}

locals {
  org_wide_team_permissions = {
    members     = "push"
    service     = "push"
    deploiement = "push"
  }

  excluded_repositories = toset(concat(
    [for name in local.clusters_repos : "k8s-${name}"],
    # Repositories being removed from Terraform. Keep them excluded while the
    # removal is applied so no team permissions are created for them.
    [
      "acets.etsmtl.ca",
      "demo-ets.omni.cedille.club",
      "aeroets.etsmtl.ca",
    ],
  ))

  organization_repositories = toset([
    for full_name in data.github_organization.this.repositories : split("/", full_name)[1]
  ])

  org_wide_managed_repositories = setsubtract(
    local.organization_repositories,
    local.excluded_repositories,
  )

  org_wide_team_repository_permissions = {
    for pair in setproduct(keys(local.org_wide_team_permissions), local.org_wide_managed_repositories) :
    "${pair[0]}:${pair[1]}" => {
      team       = pair[0]
      repository = pair[1]
      permission = local.org_wide_team_permissions[pair[0]]
    }
  }
}

resource "github_team_repository" "org_wide" {
  for_each = local.org_wide_team_repository_permissions

  team_id    = each.value.team
  repository = each.value.repository
  permission = each.value.permission
}
