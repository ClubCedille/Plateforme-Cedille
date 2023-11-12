locals {
    omni_machine_config = yamldecode(data.external.omni_redactedclustermachineconfigs.result.yaml)
}

data "external" "omni_redactedclustermachineconfigs" {
  program = [
    "bash", "-c", <<EOF
wget https://cedille.omni.siderolabs.io/omnictl/omnictl-linux-amd64 -O omnictl \
&& chmod +x omnictl \
&& ./omnictl get redactedclustermachineconfigs.omni.sidero.dev -o jsonpath="{.spec.data}" | jq -rRncs '{"yaml": inputs}'
EOF 
]
}

module "vault" {
    source = "./vault"
    kms_region = var.gcloud_region
    gcloud_project = var.gcloud_project
    name_prefix = "prod"
    cluster_ca = base64decode(local.omni_machine_config.cluster.ca.crt)
    override_helm_path = "../system/vault/helm/vault.values.yaml"
}