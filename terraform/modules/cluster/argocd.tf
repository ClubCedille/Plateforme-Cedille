data "external" "cluster_token" {
  depends_on = [ terraform_data.cluster ]
  program = ["bash", "-c", "./omnictl kubeconfig --cluster ${var.name} --service-account --user argocd --force tmp-${var.name}-kubeconfig && cat tmp-${var.name}-kubeconfig | yq -j -c '.users[0].user'"]
}

resource "argocd_project" "project" {
  metadata {
    name      = var.name
    namespace = "argocd"
  }

  spec {
    description = "simple project"

    source_namespaces = ["argocd"]
    source_repos      = ["*"]

    destination {
      server    = "${var.omni_url}?cluster=${var.name}"
      namespace = "*"
    }

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }
}

resource "argocd_cluster" "talos" {
  server = "${var.omni_url}?cluster=${var.name}"
  name   = var.name

  config {
    bearer_token = data.external.cluster_token.result["token"]
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