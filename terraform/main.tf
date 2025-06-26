# locals {
#     omni_machine_config = yamldecode(data.external.omni_redactedclustermachineconfigs.result.yaml)
# }



# data "external" "omni_redactedclustermachineconfigs" {
#   program = [
#     "/bin/bash", "-c", <<EOF
# curl -L -o omnictl https://cedille.omni.siderolabs.io/omnictl/omnictl-linux-amd64 \
# && curl -o jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 \
# && chmod +x omnictl && chmod +x jq \
# && ./omnictl get redactedclustermachineconfigs.omni.sidero.dev -o jsonpath="{.spec.data}" | ./jq -rRncs '{"yaml": inputs}'
# EOF
#  ]
# }

# module "vault" {
#   source             = "./vault"
#   kms_region         = var.gcloud_region
#   gcloud_project     = var.gcloud_project
#   name_prefix        = "prod"
#   cluster_ca         = var.cluster_ca # base64decode(local.omni_machine_config.cluster.ca.crt)
#   override_helm_path = "system/vault/helm/vault.values.yaml"
#   platform_repo      = var.platform_repo
# }

module "github" {
  source = "./github"
}

module "gcp" {
  source         = "./gcp"
  gcloud_project = var.gcloud_project
  tfe_workspace  = var.tfe_workspace
}
