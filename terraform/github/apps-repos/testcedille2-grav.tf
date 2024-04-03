resource "github_repository" "repo_testcedille2" {
  name = "test2.cedille.club"
  auto_init = true
  homepage_url = "https://test2.cedille.club"
  description = "Site web de testcedille2"
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

resource "github_repository_webhook" "webhook_testcedille2" {
  repository = github_repository.repo_testcedille2.name

  configuration {
    url          = "https://test2.cedille.club/_git_webhook"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_testcedille2" {
  repository  = github_repository.repo_testcedille2.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_testcedille2" {
  repository = github_repository.repo_testcedille2.name

  team {
    permission = "admin"
    team_id = "sre"
  }
}
