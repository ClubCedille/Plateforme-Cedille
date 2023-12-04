resource "github_repository" "repo_acets" {
  name = "acets.etsmtl.ca"
  auto_init = true
  homepage_url = "https://acets.omni.cedille.club"
  description = "Site web du club Avion Cargo"
  has_downloads = true
  has_issues = true
  has_projects = true
  has_wiki = true
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
  topics = [ "grav" ]
  vulnerability_alerts = true
  visibility = "public"
}

resource "github_repository_webhook" "webhook_acets" {
  repository = github_repository.repo_acets.name

  configuration {
    url          = "https://acets.omni.cedille.club/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_acets" {
  repository  = github_repository.repo_acets.name
  enabled     = true
}

resource "github_repository_collaborators" "collaborators_acets" {
  repository = github_repository.repo_acets.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
