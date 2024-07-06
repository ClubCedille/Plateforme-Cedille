# Workflow

This document describes the available development and deployment pipelines used
for the Cedille platform.

## Terraform Cloud

The Cedille platform uses Terraform Cloud for infrastructure management and
resource deployment. The Terraform configuration files are stored in the GitHub
repository `Plateforme-Cedille` under the `terraform` folder. The Terraform
configuration files are organized into modules to manage different aspects of
the infrastructure, such as GitHub repositories, GitHub users, resources for our
HashiCorp Vault instance, etc. The Terraform modules are deployed using
Terraform Cloud, which is configured to trigger automatic deployments when a
commit is made to the `master` branch of the `Plateforme-Cedille` repository.

## ArgoCD

The Cedille platform uses ArgoCD for continuous deployment of Kubernetes
applications. The ArgoCD configuration files are stored in the GitHub repository
`Plateforme-Cedille` under the `apps` and `system` folders. The ArgoCD
configuration files are organized into applications to manage different aspects
of the Kubernetes applications, such as high-level applications (apps) and
system applications (system). An automatic synchronization is configured for the
ArgoCD applications with the `Plateforme-Cedille` repository.

## Add a New Member to the Organization

To add a new member to the Cedille club's GitHub organization, the
`add-new-member` workflow is available. This workflow creates a pull request to
add a new member to the Cedille club's GitHub organization. To execute the
workflow, simply click on the following link: [Add a New
Member](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/add-new-member.yml).

## Request a Kubernetes Sandbox

An automated sandbox environment deployment workflow for Cedille club members is
available and accessible by executing the GitHub workflow [request a Kubernetes
sandbox](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-sandbox.yml).
The workflow creates a pull request to deploy a sandbox environment with
vcluster for the user who triggered the workflow. Additional details on using
the sandbox environment are available in the generated pull request.

## Apply Omni Config Files

The `apply-omni` workflow is used to apply the omni configuration files in the
Cedille platform's Kubernetes cluster. The workflow runs automatically when a
commit is made to the `master` branch of the `Plateforme-Cedille` repository.

## Request a GRAV Website

An automated GRAV website deployment workflow for student clubs is available and
accessible by executing the GitHub workflow [request a GRAV
website](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-grav.yml).
The workflow creates a pull request to deploy a GRAV website for the student
club for which the workflow was triggered. Additional details on using the GRAV
website are available in the generated pull request.
