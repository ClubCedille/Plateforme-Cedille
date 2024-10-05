locals {
  clusters_repos = [
    github_repository.k8s_common.name,
    github_repository.k8s_mgmt.name,
    github_repository.k8s_prod.name,
    github_repository.k8s_nonprod.name,
    github_repository.k8s_nextcloud.name
  ]
}

resource "github_repository" "k8s_common" {
    name        = "k8s-common"
    description = "Base pour nos cluster kubernetes"
    visibility = "public"
    auto_init = true
}

resource "github_repository" "k8s_mgmt" {
    name        = "k8s-mgmt"
    description = "Clusters kubernetes pour les outils de management"
    visibility = "public"
    template {
      owner = "Cedille"
      repository = "k8s-common"
    }
}

resource "github_repository" "k8s_prod" {
    name        = "k8s-prod"
    description = "Clusters kubernetes pour les deploiements de production"
    visibility = "public"
    template {
      owner = "Cedille"
      repository = "k8s-common"
    }
}

resource "github_repository" "k8s_nonprod" {
    name        = "k8s-nonprod"
    description = "Clusters kubernetes pour les deploiements de non-production"
    visibility = "public"
    template {
      owner = "Cedille"
      repository = "k8s-common"
    }
}

resource "github_repository" "k8s_nextcloud" {
    name        = "k8s-nextcloud"
    description = "Clusters kubernetes pour les deploiements de non-production"
    visibility = "public"
    template {
      owner = "Cedille"
      repository = "k8s-common"
    }
}

resource "github_repository_collaborators" "k8s_base" {
  for_each = toset(local.clusters_repos)

  repository = each.key

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
  for_each = toset(local.clusters_repos)

  repository_id = each.key

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
      "Terraform Cloud/cedille/${each.key}", 
      "ci/kubernetes-repo-standard/kubescore-check/kube-score",
      "ci/kubernetes-repo-standard/yaml-check/yaml-lint-check",
      "ci/kubernetes-repo-standard/terraform-check/terraform-lint",
    ]
  }
}

resource "tfe_workspace" "workspaces" {
  for_each = toset(local.clusters_repos)
  name                 = each.key
  queue_all_runs       = false
  vcs_repo {
    branch             = "main"
    identifier         = "ClubCedille/${each.key}"
    github_app_installation_id = var.tfe_gh_app_id
  }
}