# Add a user to the organization
resource "github_membership" "user_membership" {
  username = var.github_username
  role     = var.github_role
}

resource "github_team_membership" "user_team_memberships" {
  for_each = toset(var.teams)
  team_id  = each.value.teamName
  username = var.github_username
  role     = each.value.teamRole
}

resource "github_repository_file" "omni_acl" {
  repository = var.cluster_repo
  file = "omni/${var.github_username}.acl.yaml"
  commit_message = "Creating/Updating user [Automated]"
  content = yamlencode({
    metadata = {
        namespace = "default"
        type = "AccessPolicies.omni.sidero.dev"
        id = "${var.github_username}-acl"
    }
    spec = {
        rules = [{
            users = [var.github_email]
            clusters = [var.cluster_name]
            role = var.cluster_role
            kubernetes = {
                impersonate = {
                    groups = [var.github_username]
                }
            }
        }]
    }
})
}