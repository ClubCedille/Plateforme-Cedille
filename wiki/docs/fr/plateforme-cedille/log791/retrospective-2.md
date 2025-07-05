# Rétrospective de l'itération 2

Date: 8 novembre 2023

## 1. Travail réalisé

| Tâche                                                                                                                                             | Responsable                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| [Deployer cluster sandbox (vcluster)](https://github.com/ClubCedille/Plateforme-Cedille/issues/7)                                                 | Antoine                         |
| [Installation/Configuration de k8s-sigs/external-dns dans le cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/35)                | Michael                         |
| [Deployer/Configurer Hashicorp Vault](https://github.com/ClubCedille/Plateforme-Cedille/issues/14)                                                | Simon                           |
| [Déploiement de cert-manager (ou équivalent) dans le système](https://github.com/ClubCedille/Plateforme-Cedille/issues/26)                        | Antoine                         |
| [Installation/Configuration de Crossplane sur le cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/31)                            | Michael                         |
| [Creation de la structure Kustomize](https://github.com/ClubCedille/Plateforme-Cedille/issues/25)                                                 | Michael                         |
| [Configurer ArgoCD sur le cluster](https://github.com/ClubCedille/Plateforme-Cedille/issues/5)                                                    | Henri, Antoine, Simon, Jonathan |
| [Configuration de Contour (reverse-proxy/ingress)](https://github.com/ClubCedille/Plateforme-Cedille/issues/11)                                   | Jonathan                        |
| [Gabarit de pull request (PR) pour le repo Plateforme CEDILLE](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41043072) | Henri                           |
| [Gabarit de issues pour le repo Plateforme CEDILLE](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41043078)            | Henri                           |
| [Deployer/Configurer Kuma + Merbridge (service-mesh)](https://github.com/ClubCedille/Plateforme-Cedille/issues/20)                                | Thomas                          |
| [Configurer/Deployer grafana](https://github.com/ClubCedille/Plateforme-Cedille/issues/21)                                                        | Thomas                          |
| [Configurer et deployer Gateway API](https://github.com/ClubCedille/Plateforme-Cedille/issues/27)                                                 | Thomas                          |
| [Deployer et configurer Mayastor](https://github.com/ClubCedille/Plateforme-Cedille/issues/33)                                                    | Simon                           |
| [Documenter KubeVirt](https://github.com/ClubCedille/Plateforme-Cedille/issues/28)                                                                | Thomas                          |
| [Documenter Kuma et Merbridge](https://github.com/ClubCedille/Plateforme-Cedille/issues/29)                                                       | Thomas                          |
| [Documenter Contour](https://github.com/ClubCedille/Plateforme-Cedille/issues/30)                                                                 | Jonathan                        |
| [clickhouse operator with sample application](https://github.com/ClubCedille/Plateforme-Cedille/issues/37)                                        | Thomas                          |
| [Configure argocd-lovely-plugin](https://github.com/ClubCedille/Plateforme-Cedille/issues/42)                                                     | Simon                           |
| [Configurer/Deployer clickhouse](https://github.com/ClubCedille/Plateforme-Cedille/issues/58)                                                     | Thomas                          |
| [Configurer OTEL](https://github.com/ClubCedille/Plateforme-Cedille/issues/60)                                                                    | Thomas, Jonathan                |
| [Configure RBAC for grafana and argoCD](https://github.com/ClubCedille/Plateforme-Cedille/issues/61)                                              | Jonathan                        |
| [Configure SSO for argocd and grafana](https://github.com/ClubCedille/Plateforme-Cedille/issues/62)                                               | Jonathan                        |
| [Configurer/Deployer Linkerd](https://github.com/ClubCedille/Plateforme-Cedille/issues/32)                                                        | Thomas                          |
| [Configurer vault avec l'Operateur de Red Hat](https://github.com/ClubCedille/Plateforme-Cedille/issues/65)                                       | Simon                           |

---

## 2. Travail non terminé

### 2.1 En cours

- **[Configurer et deployer Gateway API #27](https://github.com/ClubCedille/Plateforme-Cedille/issues/27)**
  : La configuration de la Gateway API est actuellement en développement.
- **[Configurer OTEL #60](https://github.com/ClubCedille/Plateforme-Cedille/issues/60)**
  : La configuration de l'OpenTelemetry Collector est en cours pour permettre la
  collecte et l'exportation des données de télémétrie.

### 2.2 Ne sera pas fait

- **[Configurer/Deployer Linkerd #32](https://github.com/ClubCedille/Plateforme-Cedille/issues/32)**
  : Nous avons choisi de ne pas aller de l'avant avec Linkerd en tant que
  maillage de service pour le moment. Nous avons rencontrés des problèmes
  similaires à des issues ouvertes sur ce projet
  ([11156](https://github.com/linkerd/linkerd2/issues/11156) &
  [10994](https://github.com/linkerd/linkerd2/issues/10994)). Sans solution
  proposé, ont a decidé de se diriger vers une alternative (Kuma).
- **[Résoudre les problèmes de stabilité Rook/Ceph](https://github.com/ClubCedille/Plateforme-Cedille/issues/34)**
  : Les problèmes récurrents de stabilité avec ceph ne semblait pas se résoudre.
  Possiblement du au fait que le logiciel est concu pour beaucoup plus de
  serevurs et disques. Nous avons plutôt décidé d'utiliser Mayastor, qui est
  beaucoup plus stable pour nous (voir
  [Deployer et configurer Mayastor](https://github.com/ClubCedille/Plateforme-Cedille/issues/33))

### 2.3 À faire

- **[Deployer cluster staging (vcluster) #6](https://github.com/ClubCedille/Plateforme-Cedille/issues/6)**
  &
  **[Deployer cluster sandbox (vcluster) #7](https://github.com/ClubCedille/Plateforme-Cedille/issues/7)**
  : Le déploiement du cluster de staging et sandbox avec vcluster est prévu.
- **[Documenter le déploiement avec Omni #17](https://github.com/ClubCedille/Plateforme-Cedille/issues/17)**
  : La documentation du processus de déploiement en utilisant Omni doit être
  créée.
- **[Documenter la configuration d'environnement locale avec Omni #19](https://github.com/ClubCedille/Plateforme-Cedille/issues/19)**
  : Il est nécessaire de documenter la configuration de l'environnement local
  pour Omni.
- **[Configuration des routes sur Talos #0](https://github.com/orgs/ClubCedille/projects/3/views/5?pane=issue&itemId=41582552)**
  : La configuration des routes pour le système d'exploitation Talos doit être
  mise en place.
- **[Configurer la gestion à distance des serveurs physiques #16](https://github.com/ClubCedille/Plateforme-Cedille/issues/16)**
  : Pour permettre à l'équipe d'intéragir avec les serveurs à distance.
- **[Acheter SSDs](https://github.com/ClubCedille/Plateforme-Cedille/issues/9)**

---

## 3. Problèmes et défis

- **Problème 1** : Stabilité de Rook/Ceph. Le redémarrage d'un node rend le
  cluster ceph non-healthy. Les pods de ceph sur le serveurs associé ne
  finissent jamais leur processus de démarrage et ces disques ne sont jamais
  disponible.
  - **Cause** : Le problème semble être du au fait qu'un nouveau mon est créé
    puisque celui du node redémarré est mort. Puisqu'on ne permet pas la
    colocation de mon, il ne redémarre sur aucun autre serveur. Quand on
    redémarre sur le serveur on dirait que le nouveau et ancien mon se font
    compétition. Après une investigation approfondie, du au petit scale du
    cluster ceph (3 nodes), il semble y avoir une complexité et risque
    additionel.
  - **Solution** : Nous avons décidé que résoudre tous ces problèmes est trop de
    problèmes. Après une rapide preuve de concept, nous avons décidé de changer
    vers [Mayastor](https://openebs.io/docs/concepts/mayastor). Ce système est
    bati pour kubernetes à partir de 0, ce qui devrait réduire le genre de
    problèmes opérationnels rencontrés avec ceph. Voir #33 pour plus de détails.

- **Problème 2** : Configuration d'un service mesh pour kubernetes
  - **Cause** : La nécessité de prendre en charge mTLS dans le cadre de la
    configuration du service mesh. Le choix du service mesh doit aussi supporter
    Gateway API.
  - **Solution** : Nous avions prévu d'installer Linkerd comme service mesh,
    mais nous avons été confrontés à un problème lié à l'erreur
    [#11156](https://github.com/linkerd/linkerd2/issues/11156), qui n'était pas
    résolu au moment de notre installation. Face à cette difficulté, nous avons
    choisi de nous orienter vers Kuma, qui prend également en charge la Gateway
    API et offre la gestion du mTLS nécessaire pour nos besoins.

- **Problème 3** : **Installation et configuration du service External-DNS** :
  Le service a été installé selon les instructions, cependant il ne marche pas
  et offre peu de détails sur l'erreur.
  - **Cause** : La cause n'a pas été identifiée pour le moment.
  - **Solution** : Il est possible qu'on fasse quelques enquêtes de plus pour
    faire fonctionner le service. On est aussi en train de regarder des
    solutions alternatives comme: Gestion du DNS avec crossplane et/ou migration
    du DNS vers Google Cloud.

- **Problème 4** : Configuration du SSO pour ArgoCD sans gestion sécurisée des
  secrets. Nous avons rencontré un problème récurrent lors de la recréation des
  pods d'ArgoCD où les secrets nécessaires à la configuration du SSO ne
  pouvaient pas être conservés de manière sécurisée. La configuration initiale a
  été effectuée en utilisant le fichier `values` d'un Helm chart, incluant un
  token secret provenant de GitHub pour permettre l'authentification. Cependant,
  cela posait un problème de sécurité puisque le secret se retrouvait exposé sur
  GitHub lorsque le fichier `values` était sauvegardé. De plus, le secret devait
  être saisi à nouveau via `kubectl` à chaque fois que le namespace était recréé
  pour des raisons de débogage, ce qui ajoutait des tâches répétitives et
  fastidieuses à notre travail.
  - **Solution** : Pour résoudre ce problème, nous devons configuré le service
    Vault par HashiCorp, qui permettra de centraliser la gestion des secrets et
    de les injecter de manière sécurisée dans nos configurations sans les
    exposer dans notre dépôt GitHub. Cela réduirait considérablement les risques
    liés à la sécurité et optimiserait notre flux de travail en évitant la
    resaisie manuelle des secrets à chaque intervention sur l'infrastructure.

- **Problème 5**: Le _bootstrapping_ de Hashicorp Vault demandait beaucoup
  d'étapes manuelles, notamment la génération de certificats TLS.
  - **Cause**: Un déploiement demande plusieurs étapes qui étaient difficiles à
    connecter ensemble de facon automatiser:
    1. Générer des certificats
    2. Configurer google cloud KMS pour unseal
    3. Générer une configuration Helm de Vault
    4. Déployer avec Helm
    5. Initialiser Vault
    6. Créer manuellement l'authentification Kubernetes
  - **Solution**: En utilisant des fonctionnalité de terraform permettant de
    rouler des commandes manuelles sur le client, nous avons réussi à
    automatiser plusieurs des opérations qui ne s'automatisais pas facilement
    avec terraform. La solution est un peu complexe et moins "propre" mais elle
    fonctionne bien. Nous avons aussi décidé que la fin du process terraform est
    la génération d'un fichier values.yaml qui est commit sur le répertoire git
    afin de configurer le déploiement Helm de Vault. Enfin, il reste certaines
    étapes manuelles, mais elles sont minimes et seront bien documenté à
    l'itération 3.
