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

resource "github_repository_file" "omni_acl" {
  repository = var.cluster_repo
  file = "omni/${var.github_username}.acl.yaml"
  commit_message = "Creating/Updating user [Automated]"
  content = join("\n", [
    "# MANAGED BY TERRAFORM; DO NOT MODIFY",
    yamlencode({
      spec = {
          rules = [{
              users = [var.github_email]
              clusters = [var.cluster_name]
              role = var.cluster_role
              kubernetes = {
                  impersonate = {
                      groups = ["reader", var.github_username]
                  }
              }
          }]
      }
    })
  ])
}

# Add user to netdata
resource "netdata_space_member" "cedille_membership" {
  email    = var.github_email
  space_id = "dd43c8b4-1ae4-4ef3-84b9-2dbfa7b7b009"
  role     = var.netdata_role
}
