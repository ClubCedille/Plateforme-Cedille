# Clusters Kubernetes

Les clusters Kubernetes de la Plateforme CEDILLE hébergent les sites web de
plusierus clubs étudiants de l'ÉTS, ainsi que les différents services offerts
aux clubs étudiants et les projets du club CEDILLE.

Les clusters sont les suivants :

- **Production** : Cluster de production pour les sites web des clubs étudiants
  et les déploiements uniques.
- **Shared** : Cluster pour tout service ou déploiement qui est utilisé par
  plusieurs entités.
- **Management** : Cluster pour les déploiements internes et les outils de
  développement.

## Un répertoire par cluster

Pour continuer avec la philosophie d'IaC (Infrastructure as Code) et de GitOps,
chacun des clusters a son propre dépôt GitHub.

Chacun de nos trois répertoires est généré à partir de
[k8s-template](https://github.com/ClubCedille/k8s-template).

### Production

Le repo pour le cluster production est
[k8s-cedille-production-v2](https://github.com/ClubCedille/k8s-cedille-production-v2).
Le cluster production est utilisé pour héberger les sites web des clubs
étudiants et les déploiements uniques. Toute requête de déploiement suite à une
demande d'un club étudiant est alors déployée sur ce cluster (exemples de
déploiements : site web CEDILLE, wiki de Capra, application backend pour un
club...).

### Shared

Le repo pour le cluster shared est
[k8s-shared](https://github.com/ClubCedille/k8s-shared). Le cluster shared est
utilisé pour tout déploiement qui est utilisé par plusieurs clubs et souvent
présenté comme un service à la communauté étudiante (exemples de déploiements :
Nextcloud, Authentik, Vaultwarden...).

### Management

Le repo pour le cluster management est
[k8s-management-v2](https://github.com/ClubCedille/k8s-management-v2). Le
cluster management est utilisé pour tout déploiement d'outil interne (exemples
de déploiements : ArgoCD, Vault...).

## Le répertoire de base

Nous utilisons le répertoire GitHub
[k8s-base](https://github.com/ClubCedille/k8s-base) pour avoir les mêmes
déploiements de base dans nos trois clusters (exemples de déploiements :
cert-manager, contour, velero...).

## L'organisation des répertoires

Les déploiements sur production et shared sont dans leurs propres sous-dossiers
du dossier `apps`.  Les déploiements sur management sont aussi en sous-dossiers,
mais dans le dossier `system`.

Tous les répertoires ont un fichier `argoapps.yaml` à la racine et un
`argoapp.yaml` dans chaque sous-dossier qui contient un déploiement. ArgoCD lit
ces fichiers pour effectuer les déploiements automatisés.
