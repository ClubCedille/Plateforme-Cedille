resource "github_repository" "repo_edvin" {
  name = "edvin.test.ca"
  auto_init = true
  homepage_url = "https://edvin.test.ca"
  description = "Site web de edvin"
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

resource "github_repository_webhook" "webhook_edvin" {
  repository = github_repository.repo_edvin.name

  configuration {
    url          = "https://edvin.test.ca/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_edvin" {
  repository  = github_repository.repo_edvin.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_edvin" {
  repository = github_repository.repo_edvin.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
