# Rétrospective de le l'itération 1

Date: 11 octobre 2023

## 1. Travail réalisé

| Tâche                                                   | Responsable                         |
| ------------------------------------------------------- | ----------------------------------- |
| Préparer les questionnaires par client                  | Jonathan / Thomas                   |
| Entrevue AlgoETS                                        | Jonathan                            |
| Entrevue des membres du club                            | Thomas / Jonathan                   |
| Entrevue club Raconteurs d'angles                       | Jonathan                            |
| Entrevue club Saveurs de génie                          | Jonathan                            |
| Entrevue services TI                                    | Thomas                              |
| À partir des entrevues, définir métriques de succès     | Jonathan / Thomas / Simon / Michael |
| Deployer le cluster physique avec Talos/Omni            | Michael / Simon                     |
| Configuration de base de Rook/Ceph                      | Michael / Simon                     |
| Evaluer stack networking k8s                            | Simon                               |
| Mise en place d'un wiki pour la documentation           | Jonathan                            |
| Rédaction initiale du document de vision                | Jonathan / Thomas / Simon / Michael |
| Migrer les serveurs physiques vers la salle de serveurs | Simon / Jonathan / Thomas           |
| Configuration de KubeVirt                               | Thomas                              |

## 2. Travail non terminé

### 2.1 En cours

- **Achat des nouveaux disques** : L'évaluation de nos besoins a été complétée,
  la requête au TI est sur le point d'être envoyée.

### 2.2 Ne sera pas fait

- **Ajouter le réseautage pour le provideur Terraform XCP-NG** : Nous avons pris
  la décision de ne pas utiliser XCP-NG comme hyperviseur pour nos
  serveurs. Cette décision s'explique par le fait que nous désirons minimiser la
  complexité de l'infrastructure et qu'il n'y avait pas assez de valeurs
  ajoutées pour justifier cette configuration. Nous avons opté pour l'outil
  Vcluster comme alternative pour permettre de configurer différents
  environnements virtuels à l'intérieur de notre cluster Kubernetes.

## 3. Problèmes et défis

- **Installation (bootstrap) du cluster Kubernetes / Talos**: Installation du OS
  Talos Linux a partir de l'ISO généré par Sidero Omni et creation du cluster
  avec toutes les machines.
  - **Problème**: Impossibilité de décrypter les disques durant le premier
    démmrarage après l'installation d'une machine.
    - **Cause**: Malheuresement, après plusieurs ré-installation, on n'a pas pu
      identifier la cause.
    - **Solution**: Désactiver l'option de cryptage avant l'installation.
  - **Problème**: L'installation est brisée dès que la clé USB est retirée de la
    machine après l'installation.
    - **Cause**: L'identifiant du disque avec l'OS `/dev/sdb` n'est plus valide
      si la clé USB est retirée.
    - **Solution**: Ré-installation du cluster en spécifiant des identifiants de
      disque durable (`/dev/disk/by-id/...`) pour _chaque_ machine.

- **Configuration d'un ISO/image dans un PVC pour KubeVirt**: Utiliser un ISO
  ubuntu dans un PVC pour l'utiliser comme CD-ROM lors du boot de la VM.
  - **Solution** : Installer le
    [CDI](https://kubevirt.io/user-guide/operations/containerized_data_importer/)
    de KubeVirt qui permet d'importer des images disque depuis un serveur web ou
    un registre de conteneurs, de cloner des volumes persistants existants, et
    de télécharger des images disque locales, le tout vers un DataVolume. Bref,
    il simplifie et optimise l'utilisation des revendications de volumes
    persistants (PVCs) comme disques pour les machines virtuelles.

- **Installation initiale de Rook-Ceph** : Installation initiale de rook-ceph
  (système de fichiers distribué) comme preuve de concept sur notre cluster
  Kubernetes.
  - **Problème** : Le cluster Ceph est inutilisable
  - **Cause** : La configuration des OSD (Object Storage Daemons) échoue.
  - **Solution** : Manuellement effacer tous les disques et redémarrer
    l'opérateur rook-ceph.

- **Problème 2** : Description détaillée du problème et de son impact.
  - **Solution envisagée** : Description de la solution ou des étapes pour
    résoudre le problème.
- **Défi 3** : Description du défi et pourquoi il a été un obstacle.
  - **Solution envisagée** : Mesures ou étapes pour surmonter ce défi à
    l'avenir.
