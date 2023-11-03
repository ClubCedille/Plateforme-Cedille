# We create a service account so vault can access the KMS service
resource "google_service_account" "vault_kms_service_account" {
  account_id   = "${var.name_prefix}-vault-gcpkms"
  display_name = "Vault KMS for auto-unseal"
}

resource "google_service_account_key" "vault_kms_service_account_key" {
  service_account_id = google_service_account.vault_kms_service_account.name
}

# Create a KMS key ring, logical space to contain keys
resource "google_kms_key_ring" "key_ring" {
  name     = "${var.name_prefix}-vault-keyring"
  location = "${var.kms_region}"
}

# Create a crypto key for the key ring. This key will be used
# to automatically unseal Vault
resource "google_kms_crypto_key" "crypto_key" {
  name            = "${var.name_prefix}-vault-cryptokey"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "100000s"
}

# We give vault service account access to that key ring
resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
  key_ring_id = google_kms_key_ring.key_ring.id
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


# This requires that jq and openssl are installed in the runtime environment
# It creates a certificate signing request (CSR) based on the vault-csr.conf file
# The 2 jq at the begining and end of the pipes are used to read the input and wrap the result in json
# since this is how terraform "external" passes data.
data "external" "k8s_cert_request" {
  program = [
    "bash", "-c",
    "jq -rc '.key' | openssl req -new -noenc -config ${path.module}/vault-csr.conf -key /dev/stdin | jq -rRncs '{\"request\": inputs}'"
    ]
  query = {
    "key" = tls_private_key.vault_key.private_key_pem
  }
}

# We make ask Kubernetes to sign the certificate
# https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
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
    ignore_changes = [ spec[0].request ]
    replace_triggered_by = [ tls_private_key.vault_key ]
  }
}

# Makes sure the vault namespace is created before adding secrets
resource "kubernetes_namespace" "vault_ns" {
  metadata {
    name = "vault"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

# This secret contains the certificates used 
resource "kubernetes_secret" "vault_ha_tls" {
  metadata {
    name = "vault-ha-tls"
    namespace = kubernetes_namespace.vault_ns.metadata[0].name
  }

  data = {
    "vault.key" = tls_private_key.vault_key.private_key_pem
    "vault.crt" = kubernetes_certificate_signing_request_v1.vault_kube_cert_req.certificate
    "vault.ca" = var.cluster_ca
  }

  type = "kubernetes.io/generic"
}

# This secret contains the GCP KMS service account that is used to unseal
resource "kubernetes_secret" "kms_creds" {
  metadata {
    name = "kms-creds"
    namespace = kubernetes_namespace.vault_ns.metadata[0].name
  }

  data = {
    "credentials.json" = base64decode(google_service_account_key.vault_kms_service_account_key.private_key)
  }

  type = "kubernetes.io/generic"
}

# Output the override-values.yml files used by the argo-cd deployment
resource "local_file" "vault_values" {
  filename             = "../system/vault/override-values.yml"
  content = templatefile("${path.module}/override-values.yml.tmpl", {
    message = "DO NOT MODIFY THIS FILE, MODIFY TERRAFORM TEMPLATE AT terraform/vault/override-values.yml.tmpl"
    gcp_region = var.kms_region
    gcp_project = var.gcloud_project
    gcp_keyring = google_kms_key_ring.key_ring.name
    gcp_cryptokey = "${var.name_prefix}-vault-cryptokey"
  })
}