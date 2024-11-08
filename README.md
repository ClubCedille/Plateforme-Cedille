# Plateforme CEDILLE

Nouvelle infra du club CEDILLE

## Configuration kubectl

Ce guide de configuration va assumer l'utilisation de Linux (CEDILLE est un club axé sur l'open source après tout!).

### Krew

L'utilisation de krew est recommandée pour installer les plugins requis pour accéder au cluster CEDILLE.

Pour installer, suivre [les instructions d'installation de krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)

### kubelogin

kubelogin est utilisé pour s'authentifier au cluster CEDILLE en utilisant du SSO avec OIDC. Nous utilisons Sidero Labs Omni comme fournisseur d'identité.

Pour installer kubelogin, exécuter la  commande:

```bash
kubectl krew install oidc-login
```

Pour d'autres options d'installation, voir [le repo de kubelogin](https://github.com/int128/kubelogin)

### kubeconfig

La plateforme CEDILLE est gérée via Sidero Labs Omni. Notre instance de Omni [est accessible ici](https://cedille.omni.siderolabs.io/omni/).

Pour accéder à un cluster, il suffit de naviguer au cluster voulu (par exemple, [le cluster principal](https://cedille.omni.siderolabs.io/cluster/cedille-cluster/overview)) et télécharger le fichier kubeconfig avec le bouton `Download kubeconfig`

Pour tester rapidement l'accès, on peut exécuter les commandes suivantes:

#### Avec Linux/MacOS

```bash
export KUBECONFIG=~/Downloads/cedille-cluster-kubeconfig.yaml #Modifier selon l'emplacement du kubeconfig téléchargé
kubectl get nodes
```

#### Avec Windows

```bash
kubectl oidc-login
$env:KUBECONFIG="C:\Users\<user>\Downloads\cedille-cluster-kubeconfig.yaml" #Modifier selon l'emplacement du kubeconfig téléchargé
kubectl get nodes
```

Tu devrais être redirigé vers une page d'authentification de Omni pour t'authentifier. Une fois authentifié, tu devrais voir un résultat semblable à:

```console
NAME               STATUS   ROLES           AGE    VERSION
controlplane-1     Ready    control-plane   21d    v1.27.3
controlplane-2     Ready    control-plane   21d    v1.27.3
controlplane-3     Ready    control-plane   21d    v1.27.3
omni-endpoint-vm   Ready    <none>          7d2h   v1.27.3
worker-1           Ready    <none>          21d    v1.27.3
worker-2           Ready    <none>          21d    v1.27.3
worker-3           Ready    <none>          20d    v1.27.3
```

Kubectl est prêt à être utilisé! Cependant, cette configuration du KUBECONFIG est temporaire. Il est donc recommandé d'utiliser [la configuration recommandée](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/). Il peut aussi être pertinent de configurer [l'accès à plusieurs clusters](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).
