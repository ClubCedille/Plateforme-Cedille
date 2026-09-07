# Add a team to the organization
resource "github_team" "sre_team" {
  name        = "sre"
  description = "Groupe Site Reliability Engineering (SRE)"
  privacy     = "closed"
}

resource "github_team" "cloud_team" {
  name        = "cloud"
  description = "Groupe en charge des projets cloud (Accès aux repos qui gère gcp et +)"
  privacy     = "closed"
}

resource "github_team" "service_team" {
  name        = "service"
  description = "Groupe en charge des services k8s"
  privacy     = "closed"
}

resource "github_team" "deploiement_team" {
  name        = "deploiement"
  description = "Groupe en charge des déploiements pour les clubs étudiants"
  privacy     = "closed"
}

resource "github_team" "dev_team" {
  name        = "dev"
  description = "Groupe en charge des projets de développement"
  privacy     = "closed"
}

resource "github_team" "infra_team" {
  name        = "infra"
  description = "Groupe en charge des projets infra"
  privacy     = "closed"
}

resource "github_team" "members_team" {
  name        = "members"
  description = "Membres du club CEDILLE ÉTS"
  privacy     = "closed"
}
