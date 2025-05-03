resource "github_repository" "repo_aeroets" {
  name = "aeroets.etsmtl.ca"
  auto_init = true
  homepage_url = "https://aeroets.etsmtl.ca"
  description = "Site web de AeroÉTS"
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

resource "github_repository_webhook" "webhook_aeroets" {
  repository = github_repository.repo_aeroets.name

  configuration {
    url          = "https://aeroets.prod.cedille.club/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_aeroets" {
  repository  = github_repository.repo_aeroets.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_aeroets" {
  repository = github_repository.repo_aeroets.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
