resource "github_repository" "k8s_base" {
  name        = "k8s-base"
  description = "Base pour nos cluster kubernetes"
  visibility = "public"
}

resource "github_reposiory" "k8s_mgmt" {
    name        = "k8s-mgmt"
    description = "Clusters kubernetes pour les outils de management"
    visibility = "public"
}

resource "github_repository" "k8s_prod" {
    name        = "k8s-prod"
    description = "Clusters kubernetes pour les deploiements de production"
    visibility = "public"
}

resource "github_repository" "k8s_nonprod" {
    name        = "k8s-nonprod"
    description = "Clusters kubernetes pour les deploiements de non-production"
    visibility = "public"
}

resource "github_repository_collaborators" "k8s_base" {
  for_each = toset([
    github_repository.k8s_base.name, 
    github_repository.k8s_mgmt.name, 
    github_repository.k8s_prod.name, 
    github_repository.k8s_nonprod.name])
    
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