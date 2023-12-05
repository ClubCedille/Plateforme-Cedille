resource "google_service_account" "tf_account" {
  account_id   = "tf-account"
  display_name = "TF Account"
}

resource "google_service_account_key" "tf_account_key" {
  service_account_id = google_service_account.tf_account.name
}

resource "google_project_iam_member" "project" {
  project = var.gcloud_project
  role    = "roles/owner"
  member  = google_service_account.tf_account.member
}

resource "tfe_variable" "gcp_creds" {
  key          = "GOOGLE_CREDENTIALS"
  value        = replace(base64decode(google_service_account_key.tf_account_key.private_key), "\n", "")
  category     = "env"
  workspace_id = var.tfe_workspace
  sensitive = true
}