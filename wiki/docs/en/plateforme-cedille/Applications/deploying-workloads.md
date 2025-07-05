# Deploying Workload Applications

## Sample Application (httpbin)

The sample application is set up to document the methodology that should be used
to deploy production applications with Kustomize and ArgoCD.

- Source code:
  [/apps/samples/kustomize-example-app](https://github.com/ClubCedille/Plateforme-Cedille/tree/master/apps/samples/kustomize-example-app)

## Overview of Steps to Deploy a New App

1. Create a folder for the application. Ex.: `/apps/new-app`
2. Create the resource directory structure described in this document
3. Add a reference to the new application in the high-level application
   `/apps/argo-apps/kustomization.yaml`

## Working with Kustomize

### Base

Each application should define a `base` folder that contains all the Kubernetes
resources the application needs. This folder should also contain a Kustomization
file that points to all the Kubernetes files in `base`:

```yaml
# base/Kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - network.yaml
  - deployment.yaml
```

### Envrionments

Next, define the `prod` and `staging` folders, which will modify properties in
`base` according to different needs and add resources that are not common to all
environments.

For example, here's how it works for `prod`:

```yaml
# prod/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../base
  - ingress.yaml
  - dns.yaml

patches:
  - path: patch.yaml
```

In the above snippet:

1. We include the base
2. We include the resources
3. We apply `patches`:

```yaml
# prod/patches.yaml
# [...]
replicas: 3
containers:
  - name: httpbin
    resources:
      requests:
        cpu: '0.1'
        memory: '256Mi'
---
# Other patches can be added with separators ---
---
```

Here we apply resource requests that will be different from base.

### Adding the New Application in /argo-apps

Create the following files in your application directory:

```yaml
# argo.yaml : Contains the ArgoCD "Application" resource for your application
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kustomize-example-app-prod
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: '2'
spec:
  project: default
  destination:
    server: https://kubernetes.default.svc
    namespace: kustomize-example-app-prod
  source:
    repoURL: https://github.com/ClubCedille/Plateforme-Cedille
    path: apps/samples/kustomize-example-app/prod # Point ArgoCD to our subdirectory for the prod environment
    targetRevision: HEAD
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kustomize-example-app-staging
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: '2'
spec:
  project: default
  destination:
    server: https://kubernetes.default.svc
    namespace: kustomize-example-app-staging
  source:
    repoURL: https://github.com/ClubCedille/Plateforme-Cedille
    path: apps/samples/kustomize-example-app/staging # Point ArgoCD to our subdirectory for the staging environment
    targetRevision: HEAD
  syncPolicy:
    syncOptions:
      - CreateNamespace=true
```

```yaml
# kustomization.yaml: Kustomization that contains a single reference to the above argo.yaml
apiVersion: kustomize.config.k8s.io/v1beta1 kind: Kustomization

resources:
 - argo.yaml
```

Finally, modify the `/apps/argo-apps/kustomization.yaml` file to include our new
application:

```yaml
# /apps/argo-apps/kustomization.yaml
kind: Kustomization

resources:
  # System
  - ../../system/crossplane/
  - ../../system/grafana/
  # Workload
  - ../samples/kustomize-example-app/ # Adding the new application
```

### Global Structure

**Files and Resources**:

```less
  [argo.yaml] : ArgoCD Application
  [kustomization.yaml] : Pointeur vers argo.yaml
  ── base
  │  ├── [deployment.yaml]  Deployment httpbin
  │  ├── [kustomization.yaml]  Kustomization
  │  └── [network.yaml]  Service httpbin
  ├── prod
  │   ├── [dns.yaml]  RecordSet prod-dns-record
  │   ├── [ingress.yaml]  Ingress httpbin
  │   ├── [kustomization.yaml]  Kustomization
  │   └── [patch.yaml]  Deployment httpbin
  └── staging
      ├── [dns.yaml]  RecordSet staging-dns-record
      ├── [ingress.yaml]  Ingress httpbin
      ├── [kustomization.yaml]  Kustomization
      └── [patch.yaml]  Deployment httpbin
```

**Overview in ArgoCD**
![Apperçu dans
ArgoCD](img/argocd-kustomize-example-app.png)
