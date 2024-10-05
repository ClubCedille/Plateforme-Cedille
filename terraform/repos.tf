locals {
  clusters_repos = [
    "common",
    "mgmt",
    "prod",
    "nonprod",
    "nextcloud"
  ]
}

resource "github_repository" "k8s_repos" {
    for_each = toset(local.clusters_repos)
    name        = "k8s-${each.key}"
    description = "Cluster Kubernetes: ${each.key}"
    visibility = "public"
    auto_init = true
}

resource "github_repository_collaborators" "k8s_base" {
  depends_on = [ github_repository.k8s_repos ]
  for_each = toset(local.clusters_repos)

  repository = "k8s-${each.key}"

  team {
    permission = "admin"
    team_id = "exec"
  }

  team {
    permission = "maintain"
    team_id = "sre"
  }

  team {
    permission = "write"
    team_id = "members"
  }
  
}

resource "github_branch_protection" "repos_protection" {
  depends_on = [ github_repository.k8s_repos ]
  for_each = toset(local.clusters_repos)

  repository_id = "k8s-${each.key}"

  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false
  allows_force_pushes = false
  required_linear_history = true

  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    require_last_push_approval = true
    required_approving_review_count = 1
  }

  required_status_checks {
    strict = true
    contexts = [ 
      "Terraform Cloud/cedille/k8s-${each.key}", 
      "ci/kubernetes-repo-standard/kubescore-check/kube-score",
      "ci/kubernetes-repo-standard/yaml-check/yaml-lint-check",
      "ci/kubernetes-repo-standard/terraform-check/terraform-lint",
    ]
  }
}

resource "tfe_workspace" "workspaces" {
  depends_on = [ github_repository.k8s_repos ]
  for_each = toset(local.clusters_repos)
  name                 = "k8s-${each.key}"
  queue_all_runs       = false
  vcs_repo {
    branch             = "main"
    identifier         = "ClubCedille/k8s-${each.key}"
    github_app_installation_id = var.tfe_gh_app_id
  }
}