resource "github_repository" "repo_ets-demo" {
  name = "demo-ets.omni.cedille.club"
  auto_init = true
  homepage_url = "https://demo-ets.omni.cedille.club"
  description = "Site web de ets-demo"
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

resource "github_repository_webhook" "webhook_ets-demo" {
  repository = github_repository.repo_ets-demo.name

  configuration {
    url          = "https://demo-ets.omni.cedille.club/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_ets-demo" {
  repository  = github_repository.repo_ets-demo.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_ets-demo" {
  repository = github_repository.repo_ets-demo.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
