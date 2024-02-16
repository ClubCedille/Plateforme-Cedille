module "francis" {
  source          = "./modules/user"
  github_email    = "github@compilade.net"
  github_username = "compilade"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" },
    { teamName = "miroirs", teamRole = "maintainer" },
    { teamName = "sre", teamRole = "member" }
  ]
  cluster_name = var.cluster_name
  cluster_role = "None"
  cluster_repo = var.platform_repo
}

module "philippe" {
  source          = "./modules/user"
  github_email    = "philippelamy12@gmail.com"
  github_username = "lamiphil"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" },
    { teamName = "sre", teamRole = "member" }
  ]
  cluster_name = var.cluster_name
  cluster_role = "Read"
  cluster_repo = var.platform_repo
}