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
  netdata_role = "admin"
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
  netdata_role = "admin"
}


module "andrei22131" {
  source          = "./modules/user"
  github_email    = "antonandrei2003@hotmail.com"
  github_username = "andrei22131"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "admin"
}


module "Epsot" {
  source          = "./modules/user"
  github_email    = "sebasperezdoria@hotmail.com"
  github_username = "Epsot"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "RussellJimmies" {
  source          = "./modules/user"
  github_email    = "wlemire.wl@gmail.com"
  github_username = "RussellJimmies"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "alexvegas22" {
  source          = "./modules/user"
  github_email    = "alexrbvegas@gmail.com"
  github_username = "alexvegas22"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "JulienGiguere" {
  source          = "./modules/user"
  github_email    = "juliengiguere887@gmail.com"
  github_username = "JulienGiguere"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "Oxsw1ng" {
  source          = "./modules/user"
  github_email    = "yannmijatovicp@gmail.com"
  github_username = "Oxsw1ng"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" },
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "AlexanderPan96" {
  source          = "./modules/user"
  github_email    = "alexander.pan.1@ens.etsmtl.ca"
  github_username = "AlexanderPan96"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}


module "etienneoh" {
  source          = "./modules/user"
  github_email    = "etienneoh@hotmail.ca"
  github_username = "etienneoh"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_role = "observer"
}
