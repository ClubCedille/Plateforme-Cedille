data "external" "cluster_token" {
  depends_on = [ terraform_data.cluster ]
  program = ["bash", "-c", "./omnictl kubeconfig --cluster ${var.name} --service-account --user argocd --force tmp-${var.name}-kubeconfig && cat tmp-${var.name}-kubeconfig | yq -j -c '.users[0].user'"]
}

resource "argocd_cluster" "talos" {
  server = data.external.cluster_token.result
  name   = var.name

  config {
    bearer_token = data.external.cluster_token.result
  }

  metadata {
      labels = {
        "etsmtl.club/external-network" = "true"
      }
      annotations = {
        "etsmtl.club/external-ip" = "${var.network_config.public_ip}"
      }
    }

}