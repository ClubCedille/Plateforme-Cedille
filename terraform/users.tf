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
  cluster_role = "Operator"
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

  module "justlac" {
  source          = "./modules/user"
  github_email    = "justlac@hotmail.fr"
  github_username = "justlac"
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

 module "mataai" {
  source          = "./modules/user"
  github_email    = "code@matai.info"
  github_username = "mataai"
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

module "Kyohkotsu" {
  source          = "./modules/user"
  github_email    = "fenrir200791@gmail.com"
  github_username = "Kyohkotsu"
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


module "Stoaties" {
  source          = "./modules/user"
  github_email    = "corentin.gouanvic@gmail.com"
  github_username = "Stoaties"
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

module "AppleComputer381" {
  source          = "./modules/user"
  github_email    = "emilbus@outlook.fr"
  github_username = "AppleComputer381"
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
  
  
module "SamGame" {
  source          = "./modules/user"
  github_email    = "samuel.bond.pro@gmail.com"
  github_username = "SamGame"
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


module "Meddad-Red" {
  source          = "./modules/user"
  github_email    = "mohamed-redha.meddad.1@ens.etsmtl.ca"
  github_username = "Meddad-Red"
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


module "Vianpyro" {
  source          = "./modules/user"
  github_email    = "vianney+github@veremme.org"
  github_username = "Vianpyro"
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

module "GreatSymphonia" {
  source          = "./modules/user"
  github_email    = "louis.raymond2017@gmail.com"
  github_username = "GreatSymphonia"
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

