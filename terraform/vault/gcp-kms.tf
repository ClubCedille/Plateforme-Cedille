resource "google_service_account" "vault_kms_service_account" {
  account_id   = "${var.name_prefix}-vault-gcpkms"
  display_name = "Vault KMS for auto-unseal"
}

resource "google_service_account_key" "vault_kms_service_account_key" {
  service_account_id = data.google_service_account.vault_kms_service_account.name
}

# Create a KMS key ring
resource "google_kms_key_ring" "key_ring" {
  project  = "${var.gcloud_project}"
  name     = "${var.name_prefix}-vault-keyring"
  location = "${var.keyring_location}"
}

# Create a crypto key for the key ring
resource "google_kms_crypto_key" "crypto_key" {
  name            = "${var.name_prefix}-vault-cryptokey"
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

# Vault certificates

resource "tls_private_key" "vault_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


data "external" "k8s_cert_request" {
  program = [
    "bash", "-c",
    "jq -rc '.key' | openssl req -new -noenc -config vault-csr.conf | jq -rRncs '{\"key\": inputs}'"
    ]
  query = {
    "key" = tls_private_key.vault_key.private_key_pem
  }
}

resource "kubernetes_certificate_signing_request_v1" "vault_kube_cert_req" {
  metadata {
    name = "vault.svc"
  }
  spec {
    request = data.external.k8s_cert_request.result["request"]
    signer_name = "kubernetes.io/kubelet-serving"
    usages = ["digital signature", "key encipherment", "server auth"]
  }
  auto_approve = true
  lifecycle {
    ignore_changes = [ spec.request ]
    replace_triggered_by = [ tls_private_key.vault_key ]
  }
}

resource "kubernetes_namespace" "vault_ns" {
  metadata {
    name = "vault"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "kubernetes_secret" "vault_ha_tls" {
  metadata {
    name = "vault-ha-tls"
    namespace = "vault"
  }

  data = {
    "vault.key" = tls_private_key.vault_key.private_key_pem
    "vault.crt" = kubernetes_certificate_signing_request_v1.vault_kube_cert_req.certificate
    "vault.ca" = var.cluster_ca
  }

  type = "kubernetes.io/generic"
}

output "vault_kms_service_account" {
  value       = base64decode(google_service_account_key.vault_kms_service_account_key.private_key)
  sensitive   = true
}