data "external" "cluster_token" {
  depends_on = [ terraform_data.cluster ]
  program = ["bash", "-c", "./omnictl kubeconfig --cluster ${var.name} --service-account --user argocd --force tmp-${var.name}-kubeconfig && cat tmp-${var.name}-kubeconfig | yq -j -c '.users[0].user'"]
}

module "argocd" {
  source = "../argocd"
  argocd_server = var.argocd_server
  argocd_token = data.external.cluster_token.result
  cluster_project_name = var.name
}