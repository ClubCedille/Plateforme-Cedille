# Kubernetes Clusters

The Kubernetes clusters of the CEDILLE Platform host the websites of
several student clubs at ETS, as well as the various services offered
to student clubs and the projects of the CEDILLE club.

The clusters are as follows:

- **Production**: Production cluster for the websites of student clubs
  and unique deployments.
- **Shared**: Cluster for any service or deployment that is used by
  multiple entities.
- **Management**: Cluster for internal deployments and development
  tools.

## One Repository per Cluster

To continue with the philosophy of IaC (Infrastructure as Code) and GitOps, each
cluster has its own GitHub repository.

Each of our three repositories is generated from
[k8s-template](https://github.com/ClubCedille/k8s-template).

### Production

The repository for the production cluster is
[k8s-cedille-production-v2](https://github.com/ClubCedille/k8s-cedille-production-v2). The
production cluster is used to host the websites of student clubs and
unique deployments. Any deployment request following a student club's
request is then deployed to this cluster (examples of deployments:
CEDILLE website, Capra wiki, backend application for a club...).

### Shared

The repository for the shared cluster is
[k8s-shared](https://github.com/ClubCedille/k8s-shared). The shared
cluster is used for any deployment that is utilized by multiple clubs
and is often presented as a service to the student community (examples
of deployments: Nextcloud, Authentik, Vaultwarden...).

### Management

The repository for the management cluster is
[k8s-management-v2](https://github.com/ClubCedille/k8s-management-v2). The
management cluster is used for internal tooling deployments (examples
of deployments: ArgoCD, Vault...).

## The Base Repository

We use the GitHub repository
[k8s-base](https://github.com/ClubCedille/k8s-base) to maintain the
same base deployments across our three clusters (examples of
deployments: cert-manager, contour, velero...).

## Organization of Repositories

The deployments in production and shared are located in their own
subdirectories within the `apps` folder.  The deployments in
management are also in subdirectories but within the `system` folder.

All repositories contain an `argoapps.yaml` file at the root and an
`argoapp.yaml` file in each subdirectory containing a
deployment. ArgoCD reads these files to perform automated deployments.
