module "github" {
  source = "./github"
}

module "gcp" {
  source         = "./gcp"
  gcloud_project = var.gcloud_project
  tfe_workspace  = var.tfe_workspace
}
