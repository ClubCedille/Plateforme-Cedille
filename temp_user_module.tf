module "svc-cedille-user" {
  source          = "./modules/user"
  github_email    = "saimahelioui@gmail.com"
  github_username = "svc-cedille-user"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" },
    
    { teamName = "sre", teamRole = "member" },
    
    
    { teamName = "webmasters", teamRole = "member" },
    
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
}
