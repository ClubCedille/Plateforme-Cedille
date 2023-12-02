resource "github_repository" "repo_acets" {
  name = "acets.omni.cedille.club"
  auto_init = true
  homepage_url = "https://acets.omni.cedille.club"
  security_and_analysis {
    advanced_security {
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
    content_type = "form"
    insecure_ssl = false
  }

  active = true

  events = ["push"]
}

resource "github_repository_dependabot_security_updates" "dependabot_acets" {
  repository  = github_repository.repo_acets.name
  enabled     = true
}

resource "github_repository_collaborators" "colaborators_acets" {
  repository = github_repository.repo_acets.name

  user {
    permission = "maintain"
    username  = ""
  }

  team {
    permission = "admin"
    team_id = "sre"
  }
}
