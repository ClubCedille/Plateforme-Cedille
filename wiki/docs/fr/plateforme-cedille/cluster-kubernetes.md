# Clusters Kubernetes

Les clusters Kubernetes de la Plateforme CEDILLE hébergent les sites web de tous les
clubs étudiants de l'école, ainsi que les différents services offerts aux club étudiants et les projets du club CEDILLE.

Les clusters sont les suivants:

- **Production**: Cluster de production pour les sites web des clubs
  étudiants et les déploiements singulier.
- **Shared**: Cluster pour tout service ou déploiement qui est utilisé par plusieurs entités.
- **Management**: Cluster pour les déploiements internes et outils de développement.


## Un répertoire par cluster
Pour continuer avec la philosophie d'IaC (Infrasctructure as Code) chacun des clusters a son propre dépot GitHub.

Chacun de nos trois répertoires sont généré à partir de [k8s-template](https://github.com/ClubCedille/k8s-template)

### Production

Le repo pour le cluster production est [k8s-cedille-production-v2](https://github.com/ClubCedille/k8s-cedille-production-v2). Le cluster production est utilisé pour héberger les sites web des clubs étudiants et les déploiements singulier. Toute requête de déploiement suite à une demande d'un club étudiant est alors déployer sur ce cluster. (exemples de déploiement; site web cedille, wiki de capra, application backend pour un club...)

### Shared

Le repo pour le cluster shared est [k8s-shared](https://github.com/ClubCedille/k8s-shared). Le cluster shared est utilisé pour tout déploiement qui est utilisé par plusieurs club et souvent présenté comme un service à la communauté étudiante. (exemples de déploiement; nextcloud, authentik, vaultwarden...)

### Management

Le repo pour le cluster shared est [k8s-management-v2](https://github.com/ClubCedille/k8s-management-v2). Le cluster management est utilisé pour tout déploiement qui est utilisé comme outils interne. (exemples de déploiement; argocd, vault ...)

## Le réportoire base

Nous utilisons le répertoire Github [k8s-base](https://github.com/ClubCedille/k8s-base) pour avoir les même déploiements de base dans nos 3 clusters. (exemples de déploiement; cert-manager, contour, velero ...)

## L'organisation des répertoires

Les déploiements sur production et shared sont dans leurs propres sous-dossiers du dossier apps.
Les déploiements sur management sont aussi en sous-dossiers mais dans le dossier system.

Tout les répertoires ont un fichier argoapps.yaml à la racine et puis un argoapp.yaml dans chaque fichier qui contient un déploiement.
