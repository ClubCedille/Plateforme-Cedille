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

module "cedille-sa" {
  source          = "./modules/user"
  github_email    = "cedille@etsmtl.net"
  github_username = "svc-cedille-user"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" },
    { teamName = "sre", teamRole = "member" }
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
}
