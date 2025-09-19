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
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
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
  netdata_space_id = var.netdata_space_id
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
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
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
  netdata_space_id = var.netdata_space_id
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
  netdata_space_id = var.netdata_space_id
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
  netdata_space_id = var.netdata_space_id
  netdata_role = "admin"
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
  netdata_space_id = var.netdata_space_id
  netdata_role = "admin"
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
  netdata_space_id = var.netdata_space_id
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
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}

module "raphaelNguimbus" {
  source          = "./modules/user"
  github_email    = "raphagwem@gmail.com"
  github_username = "raphaelNguimbus"

  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}

module "HassaanBahsoun" {
  source          = "./modules/user"
  github_email    = "hassaan.bahsoun.1@ens.etsmtl.ca"
  github_username = "HassaanBahsoun"

  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}

module "christiano-maker" {
  source          = "./modules/user"
  github_email    = "christianjrdjomga@gmail.com"
  github_username = "christiano-maker"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}

module "Hertinox0" {
  source          = "./modules/user"
  github_email    = "hertinox0@gmail.com"
  github_username = "Hertinox0"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "nqlp" {
  source          = "./modules/user"
  github_email    = "nqlpaul@gmail.com"
  github_username = "nqlp"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "kingNomad3" {
  source          = "./modules/user"
  github_email    = "benjamin.joinvil.1@ens.etsmtl.ca"
  github_username = "kingNomad3"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "AmineFanid" {
  source          = "./modules/user"
  github_email    = "fan.aminee@gmail.com"
  github_username = "AmineFanid"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "boredsimo" {
  source          = "./modules/user"
  github_email    = "mfatene02@gmail.com"
  github_username = "boredsimo"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "lilianfelix-prog" {
  source          = "./modules/user"
  github_email    = "lilian.felenc@gmail.com"
  github_username = "lilianfelix-prog"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "LucaChouinard" {
  source          = "./modules/user"
  github_email    = "luca.chouinard.tech@protonmail.com"
  github_username = "LucaChouinard"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Reader"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}


module "hodux" {
  source          = "./modules/user"
  github_email    = "hoduxs@gmail.com"
  github_username = "hodux"
  github_role     = "member"
  teams = [
    { teamName = "members", teamRole = "member" }, { teamName = "sre", teamRole = "member" }, 
  ]
  cluster_name = var.cluster_name
  cluster_role = "Operator"
  cluster_repo = var.platform_repo
  netdata_space_id = var.netdata_space_id
  netdata_role = "observer"
}
