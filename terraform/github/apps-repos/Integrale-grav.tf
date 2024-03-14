resource "github_repository" "repo_Integrale" {
  name = "integrale.etsmtl.ca"
  auto_init = true
  homepage_url = "https://integrale.etsmtl.ca"
  description = "Site web de Integrale"
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

resource "github_repository_webhook" "webhook_Integrale" {
  repository = github_repository.repo_Integrale.name

  configuration {
    url          = "https://integrale.etsmtl.ca/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_Integrale" {
  repository  = github_repository.repo_Integrale.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_Integrale" {
  repository = github_repository.repo_Integrale.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
