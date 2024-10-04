# Iteration 2 Retrospective

Date: November 8, 2023

## 1. Completed Work

| Task                                                                                                                                              | Responsible                     |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| [Deploy sandbox cluster (vcluster)](https://github.com/ClubCedille/Plateforme-Cedille/issues/7)                                                  | Antoine                         |
| [Install/Configure k8s-sigs/external-dns in the cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/35)                            | Michael                         |
| [Deploy/Configure Hashicorp Vault](https://github.com/ClubCedille/Plateforme-Cedille/issues/14)                                                  | Simon                           |
| [Deploy cert-manager (or equivalent) in the system](https://github.com/ClubCedille/Plateforme-Cedille/issues/26)                                  | Antoine                         |
| [Install/Configure Crossplane on the cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/31)                                        | Michael                         |
| [Create Kustomize structure](https://github.com/ClubCedille/Plateforme-Cedille/issues/25)                                                        | Michael                         |
| [Configure ArgoCD on the cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/5)                                                    | Henri, Antoine, Simon, Jonathan |
| [Configure Contour (reverse-proxy/ingress)](https://github.com/ClubCedille/Plateforme-Cedille/issues/11)                                         | Jonathan                        |
| [Pull request (PR) template for the Plateforme CEDILLE repo](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41043072)  | Henri                           |
| [Issue template for the Plateforme CEDILLE repo](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41043078)              | Henri                           |
| [Deploy/Configure Kuma + Merbridge (service-mesh)](https://github.com/ClubCedille/Plateforme-Cedille/issues/20)                                  | Thomas                          |
| [Configure/Deploy Grafana](https://github.com/ClubCedille/Plateforme-Cedille/issues/21)                                                          | Thomas                          |
| [Configure and deploy Gateway API](https://github.com/ClubCedille/Plateforme-Cedille/issues/27)                                                  | Thomas                          |
| [Deploy and configure Mayastor](https://github.com/ClubCedille/Plateforme-Cedille/issues/33)                                                     | Simon                           |
| [Document KubeVirt](https://github.com/ClubCedille/Plateforme-Cedille/issues/28)                                                                 | Thomas                          |
| [Document Kuma and Merbridge](https://github.com/ClubCedille/Plateforme-Cedille/issues/29)                                                       | Thomas                          |
| [Document Contour](https://github.com/ClubCedille/Plateforme-Cedille/issues/30)                                                                  | Jonathan                        |
| [Clickhouse operator with sample application](https://github.com/ClubCedille/Plateforme-Cedille/issues/37)                                       | Thomas                          |
| [Configure argocd-lovely-plugin](https://github.com/ClubCedille/Plateforme-Cedille/issues/42)                                                    | Simon                           |
| [Configure/Deploy Clickhouse](https://github.com/ClubCedille/Plateforme-Cedille/issues/58)                                                       | Thomas                          |
| [Configure OTEL](https://github.com/ClubCedille/Plateforme-Cedille/issues/60)                                                                    | Thomas, Jonathan                |
| [Configure RBAC for Grafana and ArgoCD](https://github.com/ClubCedille/Plateforme-Cedille/issues/61)                                             | Jonathan                        |
| [Configure SSO for ArgoCD and Grafana](https://github.com/ClubCedille/Plateforme-Cedille/issues/62)                                              | Jonathan                        |
| [Configure/Deploy Linkerd](https://github.com/ClubCedille/Plateforme-Cedille/issues/32)                                                          | Thomas                          |
| [Configure Vault with the Red Hat Operator](https://github.com/ClubCedille/Plateforme-Cedille/issues/65)                                         | Simon                           |

---

## 2. Incomplete Work

### 2.1 In Progress

- **[Configure and deploy Gateway API
  #27](https://github.com/ClubCedille/Plateforme-Cedille/issues/27)**: Gateway
  API configuration is currently in development.
- **[Configure OTEL
  #60](https://github.com/ClubCedille/Plateforme-Cedille/issues/60)**: The
  configuration of the OpenTelemetry Collector is ongoing to allow the
  collection and export of telemetry data.

### 2.2 Will Not Be Done

- **[Configure/Deploy Linkerd
  #32](https://github.com/ClubCedille/Plateforme-Cedille/issues/32)**: We have
  decided not to proceed with Linkerd as the service mesh for now. We
  encountered issues similar to open issues on the project
  ([11156](https://github.com/linkerd/linkerd2/issues/11156) &
  [10994](https://github.com/linkerd/linkerd2/issues/10994)). Without proposed
  solutions, we decided to move towards an alternative (Kuma).
- **[Resolve Rook/Ceph stability
  issues](https://github.com/ClubCedille/Plateforme-Cedille/issues/34)**: The
  recurring stability issues with Ceph did not seem to resolve. Possibly due to
  the software being designed for many more servers and disks. We decided to use
  Mayastor instead, which is much more stable for us (see [Deploy and configure
  Mayastor](https://github.com/ClubCedille/Plateforme-Cedille/issues/33)).

### 2.3 To Do

- **[Deploy staging cluster (vcluster)
  #6](https://github.com/ClubCedille/Plateforme-Cedille/issues/6)** & **[Deploy
  sandbox cluster (vcluster)
  #7](https://github.com/ClubCedille/Plateforme-Cedille/issues/7)**: The
  deployment of the staging and sandbox clusters with vcluster is planned.
- **[Document deployment with Omni
  #17](https://github.com/ClubCedille/Plateforme-Cedille/issues/17)**:
  Documentation of the deployment process using Omni needs to be created.
- **[Document local environment configuration with Omni
  #19](https://github.com/ClubCedille/Plateforme-Cedille/issues/19)**: It is
  necessary to document the local environment configuration for Omni.
- **[Configure routes on Talos
  #0](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41582552)**:
  Route configuration for the Talos operating system needs to be implemented.
- **[Configure remote management of physical servers
  #16](https://github.com/ClubCedille/Plateforme-Cedille/issues/16)**: To allow
  the team to interact with the servers remotely.
- **[Purchase
  SSDs](https://github.com/ClubCedille/Plateforme-Cedille/issues/9)**

---

## 3. Issues and Challenges

- **Issue 1**: Stability of Rook/Ceph. Restarting a node renders the Ceph
  cluster unhealthy. The Ceph pods on the associated server never complete their
  startup process and these disks are never available.
  - **Cause**: The problem appears to be due to a new mon being created since
    the one on the restarted node is dead. Since we do not allow mon colocation,
    it does not restart on any other server. When we restart on the server, the
    new and old mon seem to compete. After thorough investigation, due to the
    small scale of the Ceph cluster (3 nodes), there seems to be additional
    complexity and risk.
  - **Solution**: We decided that solving all these issues is too problematic.
    After a quick proof of concept, we decided to switch to
    [Mayastor](https://openebs.io/docs/concepts/mayastor). This system is built
    for Kubernetes from the ground up, which should reduce the operational
    issues encountered with Ceph. See #33 for more details.

- **Issue 2**: Configuring a service mesh for Kubernetes
  - **Cause**: The need to support mTLS as part of the service mesh
    configuration. The choice of service mesh must also support Gateway API.
  - **Solution**: We initially planned to install Linkerd as the service mesh,
    but we encountered an issue related to error
    [#11156](https://github.com/linkerd/linkerd2/issues/11156), which was not
    resolved at the time of our installation. Facing this difficulty, we chose
    to move towards Kuma, which also supports Gateway API and provides the
    necessary mTLS management for our needs.

- **Issue 3**: **Installation and configuration of the External-DNS service**:
  The service was installed according to instructions, but it does not work and
  offers little detail on the error.
  - **Cause**: The cause has not been identified yet.
  - **Solution**: We may conduct further investigations to make the service
    work. We are also looking at alternative solutions such as: DNS management
    with Crossplane and/or migrating DNS to Google Cloud.

- **Issue 4**: Configuring SSO for ArgoCD without secure secret management. We
  encountered a recurring issue when recreating ArgoCD pods where the secrets
  needed for SSO configuration could not be securely retained. The initial
  configuration was done using the `values` file of a Helm chart, including a
  secret token from GitHub to allow authentication. However, this posed a
  security issue as the secret was exposed on GitHub when the `values` file was
  saved. Additionally, the secret had to be re-entered via `kubectl` every time
  the namespace was recreated for debugging purposes, adding repetitive and
  tedious tasks to our work.
  - **Solution**: To solve this issue, we need to configure the Vault service by
    HashiCorp, which will allow centralized secret management and secure
    injection into our configurations without exposing them in our GitHub
    repository. This would significantly reduce security risks and optimize our
    workflow by avoiding manual re-entry of secrets during infrastructure
    interventions.

- **Issue 5**: Bootstrapping Hashicorp Vault required many manual steps,
  including generating TLS certificates.
  - **Cause**: Deployment requires several steps that were difficult to connect
    together automatically:
    1. Generate certificates
    2. Configure Google Cloud KMS for unsealing
    3. Generate a Helm configuration for Vault
    4. Deploy with Helm
    5. Initialize Vault
    6. Manually create Kubernetes authentication
  - **Solution**: Using Terraform features that allow running manual commands on
    the client, we managed to automate several operations that were not easily
    automated with Terraform. The solution is somewhat complex and less "clean"
    but works well. We also decided that the end of the Terraform process is
    generating a values.yaml file that is committed to the Git repository to
    configure Vault's Helm deployment. Finally, there are still some manual
    steps, but they are minimal and will be well-documented in iteration 3.
