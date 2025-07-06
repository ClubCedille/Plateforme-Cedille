# Application existantes

## Système

### Mayastor

#### Description de la configuration actuelle

Mayastor est un système de stockage en blocs distribué implémenté avec le
protocole NVMEoF. Entre autres, il permet l'accès et la réplication des données
sur tous les noeuds du cluster Kubernetes.

En ce moment, on maintient deux copies de toute donnée en tout temps:

```yaml
# /system/mayastor/storageclass.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: mayastor
  annotations:
    storageclass.kubernetes.io/is-default-class: 'true'
parameters:
  ioTimeout: '30'
  protocol: nvmf
  repl: '2'
  stsAffinityGroup: 'true'
provisioner: io.openebs.csi-mayastor
```

##### Justification du choix

Comparé à d'autres solutions comme Ceph:

- est très simple à déployer et configurer
- a une basse complexité de son système et ses composantes
- est concu dès le début pour l'utilisation dans Kubernetes

Par exemple, on a fait plusieurs tentatives d'installation de Ceph, mais le
système n'était pas stable pour la petite taille de cluster et était très
mal-adapté pour l'utilisation dans Kubernetes.

##### References utilisés pour le déploiement

- [Mayastor Talos config](https://www.talos.dev/v1.5/kubernetes-guides/configuration/storage/#mayastor)
- [Deploy Mayastor](https://mayastor.gitbook.io/introduction/quickstart/deploy-mayastor)

#### Utilisation

Le `StorageClass` mayastor est selectionné par défault par Kubernetes. Il suffit
de créer des
[PersitentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes)
et les volumesseront crées dans Mayastore automatiquement.

### ArgoCD

ArgoCD est notre système de GitOps. Il s'occupe de déployer et synchronizer
toutes les ressources YAML dans notre repértoire `Plateforme-Cedille`. Pour le
faire, on utiliser Kustomize pour regrouper toutes les ressources de type
`Application` dans le dossier `/apps/argo-apps/`.

Voici un apercu visuel de cette structure:

TODO: Insérer graphique.

#### ArgoCD Configuration

**Permissions RBAC** La configuration RBAC (Role-Based Access Control) dans
ArgoCD permet de définir des politiques de sécurité spécifiques pour différents
utilisateurs et groupes. Dans notre cas, nous avons défini des rôles au sein de
notre organisation CEDILLE qui correspondent aux différents niveaux d'accès
nécessaires.

Les opérateurs (role:org-operators), qui sont membres du groupe ClubCedille:SRE,
ont les permissions suivantes :

Obtenir des informations sur les clusters, certificats et dépôts (repositories).
Synchroniser, créer et supprimer les applications. Lire, créer, mettre à jour et
supprimer les clés GPG. Ces permissions sont configurées via les lignes
commençant par p dans le fichier `system/argocd/argocd-values.yaml` sous
`policy.csv`. Le \* indique que l'action est autorisée pour toutes les instances
de la ressource spécifiée.

Les relations entre les utilisateurs/groupes GitHub et les rôles ArgoCD sont
définies par les lignes commençant par g. Par exemple, tous les membres du
groupe ClubCedille:SRE sur GitHub sont assignés au rôle role:org-operators dans
ArgoCD et ClubCedille:Exec sont assignés au rôle admin.

**Intégration SSO avec GitHub** ArgoCD est configuré pour utiliser OAuth2 de
GitHub comme fournisseur d'authentification. Cela permet aux membres de notre
organisation GitHub de se connecter à ArgoCD avec leurs identifiants GitHub.

### Ingress - Contour

Contour est une solution d'Ingress Controller pour Kubernetes. Elle utilise le
serveur proxy Envoy comme back-end.

#### Contour Configuration

Le service proxy de Envoy a été configuré avec un Nodeport pour diriger le
trafic externe vers contour qui achemine ensuite les requêtes vers les services
dédiés.

#### Tester Contour

Commencer par déployer une application web comme
[httpbin](https://httpbin.org/#/). À partir du repertoire du projet :

```bash
kubectl apply -f apps/testing/httpbin.yaml
```

Vérifier ensuite que les 3 pods arrivent à un status **Running**:

```bash
kubectl get po,svc,ing -l app=httpbin
```

Afin d'utiliser Contour et Envoy, on va utiliser la fonction
`kubectl port-foward` pour diriger le traffic vers envoy :

```bash
kubectl -n projectcontour port-forward service/envoy 8888:80
```

Puis visiter
[local.projectcontour.io:8888](http://local.projectcontour.io:8888/).
Pour notre environnement de production, on utiliserait l'adresse
du service de Envoy.

Pour plus d'informations sur Contour, consultez
[la documentation officielle](https://projectcontour.io/docs/).

### Kubevirt

KubeVirt étend les fonctionnalités de Kubernetes en ajoutant des workloads de
machines virtuelles à côté des conteneurs.

#### Kubevirt Configuration

KubeVirt est configuré pour permettre l'exécution et la gestion de machines
virtuelles au sein du cluster Kubernetes. Il est nécessaire d'avoir
[krew](https://krew.sigs.k8s.io/) installé.

#### Tester kubevirt

Pour tester une machine virtuelle Ubuntu, exécutez cette commande:

```bash
kubectl virt vnc ubuntu-vm -n vms
```

#### Containerized data importer (CDI)

Pour créer votre propre VM à partir d'un ISO, vous devez utiliser le
[CDI](https://kubevirt.io/user-guide/operations/containerized_data_importer/) de
Kubevirt qui est déjà installé sur notre cluster.

Pour ce faire, créez un PVC (dans cette situation, l'iso d'ubuntu 22.04.3 va
être importé dans le PVC):

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: iso-ubuntu-20-04
  namespace: vms
  labels:
    app: containerized-data-importer
  annotations:
    cdi.kubevirt.io/storage.import.endpoint: 'https://releases.ubuntu.com/jammy/ubuntu-22.04.3-desktop-amd64.iso' # Required. Format: (http||s3)://www.myUrl.com/path/of/data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 6Gi
```

Une fois les changements appliqués, un pod sera créé dans le namespace
respectif. Dans cette situation, le pod sera créé dans vms. Ce pod permet de
voir la progression de l'installation de l'ISO dans le PVC. Pour voir le
progrès:

```bash
kubectl logs <nom-du-pod> -n vms -f
```

Lorsque le téléchargement est terminé, vous pouvez créer votre vm basée sur
l'ISO que vous venez de télécharger.

### Grafana

Grafana est une plateforme d'analyse et de visualisation de données pour la
surveillance des systèmes informatiques.

#### Grafana Configuration

Grafana a été configuré pour collecter, analyser et visualiser les métriques,
les logs et les traces des applications de notre infrastructure.

### Clickhouse

Clickhouse est un système de gestion de base de données analytique orienté
colonnes, optimisé pour les requêtes rapides.

#### Clickhouse Configuration

Clickhouse est configuré pour collecter et stocker les métriques ainsi que les
journaux (logs) provenant d'OpenTelemetry, contribuant directement à une
meilleure observabilité. L'intégration avec Grafana, permet d'exploiter ces
données à travers des tableaux de bord interactifs pour un suivi précis des
systèmes.

Créez les PV et le déploiement d'un simple serveur clickhouse (si ce n'est pas
déjà fait. Pour verifier `kubectl get all -n clickhouse-system`):

```bash
kubectl apply -f apps/samples/clickhouse/pv.yml -n clickhouse-system &&
kubectl apply -f apps/samples/clickhouse/simple.yml -n clickhouse-system
```

Ensuite, faites un port-forward et tester la connection sur
[localhost:9000](http://localhost:9000/):

```bash
kubectl port-forward svc/chi-simple-example-deployment-pv-1-1 9000:9000 -n clickhouse-system # Garder la connection ouverte
```

Installer le
[cli](https://clickhouse.com/docs/en/integrations/sql-clients/clickhouse-client-local)
de clickhouse et connectez-vous au serveur pour créer une simple table `users`:

```bash
clickhouse-client -h 127.0.0.1 --port 9000 --user default --password <votre-password>
```

Créer la table users qui va accepter le contenu de `script.py`

```sql
CREATE TABLE users (
    id Int32,
    name String,
    email String,
    preferred_number Int32
) ENGINE = MergeTree()
ORDER BY id;
```

Ensuite, insérer des données en executant le script:

```bash
python3 script.py
```

Par la suite, il sera possible de voir les changements en faisant un
`SELECT * from users;`

### Service Mesh - Kuma

Kuma est une plateforme de gestion de services (Service Mesh) conçue pour le
microservice et l'orchestration de réseaux.

#### Kuma Configuration

Kuma est configuré pour orchestrer, sécuriser et observer les communications
entre les services du cluster Kubernetes. Il y a uniquement un "meshes" qui a
été configurer pour le moment (defaut).

#### Tester Kuma

Commencez par déployer un exemple de service:

```bash
kubectl apply -f apps/samples/kuma-demo/demo.yaml -n kuma-demo &&
kubectl apply -f apps/samples/kuma-demo/demo-v2.yaml -n kuma-demo # Permet d'avoir un UI
```

Ensuite aller visiter l'application déployée:

```bash
kubectl port-forward svc/demo-app 5000:5000 -n kuma-demo
```

Rendez-vous sur [localhost:5000](http://localhost:5000/).

Finalement, analysez le comportement de Kuma:

```bash
kubectl port-forward svc/kuma-control-plane -n kuma-system 5681:5681
```

Rendez-vous sur [localhost:5681/gui/](http://localhost:5681/gui/).

#### Merbridge

Merbridge peut être utilisé avec Kuma pour accélérer le routage du trafic réseau
entre les pods en utilisant eBPF, ce qui permet de contourner kube-proxy pour
des performances améliorées. Lorsqu'il est intégré à Kuma, Merbridge facilite
une communication inter-pods plus rapide et plus efficace, en se synchronisant
avec les fonctionnalités de gestion de Kuma. La configuration de Merbridge se
fait à l'installation de Kuma pour une amélioration directe du débit et de la
latence réseau.

Pour tester Merbridge, il faut simplement vérifier que les pods continuent de
communiquer au sein du service mesh après son intégration.

#### Autres solutions considérées

Linkerd.

Problème: Complexité d'intégration ou de configuration. Voir
[linkerd](https://github.com/linkerd/linkerd2/issues/11156)

## Workloads

### apps/sample/kustomize-example-app

Application qui démontre la structure de base à prendre pour déployer une
nouvelle application avec Kustomize avec des environments prod et staging.

Pour plus de détails, voir:
[Déployer des applications](./deploying-workloads.md)
