# Iteration 3 Retrospective

Date: December 6, 2023

## 1. Completed Work

| Task | Responsible |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| [Deploy cert-manager (or equivalent) in the system](https://github.com/ClubCedille/Plateforme-Cedille/issues/26) | Antoine BL |
| [Mayastor Documentation](https://github.com/ClubCedille/Plateforme-Cedille/issues/24) | Michael |
| [Document local environment configuration with Omni](https://github.com/ClubCedille/Plateforme-Cedille/issues/19) | Antoine |
| [Document Kuma and Merbridge](https://github.com/ClubCedille/Plateforme-Cedille/issues/29) | Thomas |
| [Configure OTEL](https://github.com/ClubCedille/Plateforme-Cedille/issues/60) | Thomas |
| [Track Clickhouse with OpenTelemetry](https://github.com/ClubCedille/Plateforme-Cedille/issues/63) | Thomas |
| [Deploy a sample of Grav with git-sync configuration](https://github.com/ClubCedille/Plateforme-Cedille/issues/97) | Simon and Jonathan |
| [Deploy Calidum-Rotae](https://github.com/ClubCedille/Plateforme-Cedille/issues/98) | Jonathan and Thomas|
| [As SRE, create nested span and test and see the traces before proceeding](https://github.com/ClubCedille/Plateforme-Cedille/issues/83) | Thomas |
| [As SRE, update the README.md with the current architecture](https://github.com/ClubCedille/Plateforme-Cedille/issues/71) | Thomas |
| [As SRE, remove the database (PostgreSQL) from the project](https://github.com/ClubCedille/Plateforme-Cedille/issues/70) | Thomas |
| [As SRE, remove the phone number from the sender obj (protobuf)](https://github.com/ClubCedille/Plateforme-Cedille/issues/69) | Thomas |
| [As SRE, instrument the application with OTEL](https://github.com/ClubCedille/Plateforme-Cedille/issues/68) | Thomas |
| [Create an automated deployment flow for a Grav site](https://github.com/ClubCedille/Plateforme-Cedille/issues/132) | Simon |
| [Configure Terraform Cloud](https://github.com/ClubCedille/Plateforme-Cedille/issues/133) | Simon |

---

## 2. Incomplete Work

### 2.1 In Progress

- **[Document
  Vault](https://github.com/ClubCedille/Plateforme-Cedille/issues/69)**:
  Administration part completed, user part (deploying secrets) to be done.
- **[Integration of vclusters with
  ArgoCD](https://github.com/ClubCedille/Plateforme-Cedille/pull/129)**: An
  initial solution was tried and failed. An alternative solution needs to be
  implemented.

### 2.2 Will Not Be Done

- **[Install/Configure k8s-sigs/external-dns in the
  cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/35)**:

### 2.3 To Do

- **[Deploy staging cluster
  [vcluster]](https://github.com/ClubCedille/Plateforme-Cedille/issues/6)**: The
  vcluster is deployed. Integration with ArgoCD remains.
- **[Deploy sandbox cluster
  [vcluster]](https://github.com/ClubCedille/Plateforme-Cedille/issues/7)**: The
  vcluster is deployed. Integration with ArgoCD remains.
- **[Mayastor
  Backup](https://github.com/ClubCedille/Plateforme-Cedille/issues/23)**: Backup
  is planned. An external provider analysis will be done.
- **[Install Vault+ArgoCD
  plugin](https://github.com/ClubCedille/Plateforme-Cedille/issues/103)**:
- **[Update ArgoCD and Grafana SSO secrets with
  Vault](https://github.com/ClubCedille/Plateforme-Cedille/issues/110)**: We
  were waiting for Vault deployment in the cluster to be completed with an
  example of configuration and secret management to accomplish this task. It can
  now be completed with new generated secrets.
- **[Document OTEL (collector and operator
  configuration)](https://github.com/ClubCedille/Plateforme-Cedille/issues/121)**:
  Now that OTEL configuration with a deployment example is completed, we can
  document how the configuration was done.

---

## 3. Issues and Challenges

- **Issue 1**: Deployment of Calidum-rotae service for the OTEL demonstration on
  the production cluster was partially functional. 50% of requests were routed.
  - **Cause**: The service communicates with an API service that receives HTTP
    requests and sends them to a Discord channel using a webhook. We realized
    that the problem is external to the Calidum-rotae service and comes from the
    API service deployed on another Kubernetes cluster.
  - **Solution**: Configuring a Discord webhook directly with the application
    instead of the API service as a temporary solution until the request
    reception issue is resolved with the API.

- **Issue 2**: (Ongoing task) Inability to register virtual clusters (VCluster)
  in ArgoCD securely.
  - **Cause**: Although VCluster is officially supported by ArgoCD, the
    integration was not designed to access private VClusters.
  - **Solution 1**: (Failed) A complex procedure with several bash scripts was
    tried to execute the entire registration process inside the cluster network
    vs. doing it on a developer's machine.
  - **Solution 2**: (To be tried) A better solution proposed by Simon is to use
    Crossplane to configure the registration of vclusters in ArgoCD
    declaratively using the Kubernetes provider in Crossplane.

- **Issue 3**: In our initial attempts, Grav crashed on the first connection.
  - **Cause**: During Grav's initialization, it tries to modify the
    configuration file generated by Vault, as Vault puts the password in plain
    text, and Grav wants to change it to a hash. However, the Vault file is
    read-only.
  - **Solution**: Create a startup script that copies the initial file to the
    destination location. This also allows users to change the configuration in
    the future without going through us.
