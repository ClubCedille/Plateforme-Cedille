# Kubernetes Cluster

The Kubernetes cluster of the Cedille Platform hosts the websites of all the
student clubs at the school, as well as the projects of the Cedille club.

## Host Cluster

The host cluster hosts the system services and basic infrastructure. The host
cluster is deployed on the servers of the Cedille club. The operating system
used is Talos Linux.

## V-Clusters for Each Environment

Environments are each hosted on a v-cluster managed by the host cluster, but use
[vcluster](https://www.vcluster.com/) to isolate environments in separate
virtual clusters.

## Environments

The environments are as follows:

- **Production**: Production environment for the websites of student clubs and
  Cedille club projects.
- **Staging**: Staging environment for the websites of student clubs and Cedille
  club projects.
- **Sandbox**: Development environment for Cedille club projects.

### Production

The production environment is used to host the websites of student clubs and
Cedille club projects. It is publicly accessible and uses SSL certificates to
secure connections.

### Staging

The staging environment is used to test updates and new deployments before
deploying them to production. It is accessible to members of the Cedille club
and student clubs to verify changes and potential issues.

### Sandbox

The sandbox environment is used for the development and testing of Cedille club
projects. It is isolated from other environments to avoid interference and
conflicts.

An automated deployment workflow for a sandbox environment for Cedille club
members is available and accessible by running the GitHub workflow [request a
Kubernetes
sandbox](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-sandbox.yml).
The workflow creates a pull request to deploy a sandbox environment for the user
who triggered the workflow. Additional details on using the sandbox environment
are available in the generated pull request.
