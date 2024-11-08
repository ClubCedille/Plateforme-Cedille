resource "argocd_cluster" "kubernetes" {
  server = var.argocd_server

  config {
    bearer_token = var.argocd_token
  }
 
}

resource "kubernetes service_account" "argocd_manager" {
  metadata {
    name = "argocd-manager-role"
    namespace = "argocd"
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role" "argocd_manager" {
  metadata {
    name = "argocd-manager-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "argocd_manager" {
  metadata {
    name = "argocd-manager-role-binding"
    namespace = "argocd"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.argocd_manager.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_manager.metadata.0.name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}

data "kubernetes_secret" "argocd_manager" {
  metadata {
    name      = kubernetes_service_account.argocd_manager.default_secret_name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}

resource "argocd_cluster" "talos" {
  server = format("https://%s", var.argocd_server)
  name   = "gke"

  config {
    bearer_token = data.kubernetes_secret.argocd_manager.data["token"]
  }
}

resource "argocd_repository" "argo_repo" {
  repo = "git@github.com:clubcedille/k8s-${var.cluster_project_name}.git"
  type = "git"
}


resource "argocd_project" "cluster_project" {
  metadata {
    name      = var.cluster_project_name
    namespace = "argocd"
  }

  spec {
    description = "Project for deploying everything from ${var.cluster_project_name}"

    source_repos = [argocd_repository.argo_repo.repo]

    destination {
      server    = var.argocd_server
      namespace = ""
    }

  }

  role {
    name = "admin"
    policies = [
      "p, proj:${var.cluster_project_name}:*, applications, allow",
      "p, applications, get, allow",
      "p, applications, list, allow",
      "p, applications, create, allow",
      "p, applications, update, allow",
      "p, applications, sync, allow",
      "p, applications, delete, allow",
      "p, projects, get, allow",
      "p, projects, list, allow",
      "p, projects, create, allow",
      "p, projects, update, allow",
      "p, projects, delete, allow",
      "p, repositories, get, allow",
      "p, repositories, list, allow",
      "p, repositories, create, allow",
      "p, repositories, update, allow",
      "p, repositories, delete, allow",
    ]
  }
  role {
    name = "contributor"
    policies = [
      "p, proj:${var.cluster_project_name}:*, applications, allow",
      "p, applications, get, allow",
      "p, applications, list, allow",
      "p, applications, create, allow",
      "p, applications, update, allow",
      "p, applications, sync, allow",
      "p, applications, delete, allow",
    ]
  }
}
