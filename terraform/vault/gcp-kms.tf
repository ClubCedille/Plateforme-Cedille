resource "google_service_account" "vault_kms_service_account" {
  account_id   = "vault-gcpkms"
  display_name = "Vault KMS for auto-unseal"
}

resource "google_service_account_key" "vault_kms_service_account_key" {
  service_account_id = data.google_service_account.vault_kms_service_account.name
}

# Create a KMS key ring
resource "google_kms_key_ring" "key_ring" {
  project  = "${var.gcloud-project}"
  name     = "vault-keyring"
  location = "${var.keyring_location}"
}

# Create a crypto key for the key ring
resource "google_kms_crypto_key" "crypto_key" {
  name            = "vault-cryptokey"
  key_ring        = "${google_kms_key_ring.key_ring.self_link}"
  rotation_period = "100000s"
}

resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
  key_ring_id = "${google_kms_key_ring.key_ring.id}"
  role = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.vault_kms_service_account.email}",
  ]
}

resource "null_resource" "tls_cert_request" {
  triggers = {
    trigger = value
  }

  provisioner "local-exec" {
    command = "/bin/bash ./vault-keys.sh"
  }
}

resource "tls_cert_request" "example" {
  private_key_pem = tls_private_key.vault_key.private_key_pem
  
  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }
}

output "vault_kms_service_account" {
  value       = base64decode(google_service_account_key.vault_kms_service_account_key.private_key)
  sensitive   = true
}