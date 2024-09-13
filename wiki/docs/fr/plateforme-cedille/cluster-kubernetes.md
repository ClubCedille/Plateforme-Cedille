# Cluster Kubernetes

Le cluster Kubernetes de la Plateforme CEDILLE héberge les sites web de tous les
clubs étudiants de l'école, ainsi que les projets du club CEDILLE.

## Cluster hôte

Le cluster hôte héberge les services de système et infrastructures de base. Le
cluster hôte est déployé sur les serveurs du club CEDILLE. Le système
d'exploitation utilisé est Talos Linux.

## V-Clusters pour chaque environment

Les environnements sont hébergés chacuns sur un v-cluster hébergé par le cluster
hôte, mais utilisent [vcluster](https://www.vcluster.com/) pour isoler les
environnements dans des clusters virtuels séparés.

## Environnements

Les environnements sont les suivants:

- **Production**: Environnement de production pour les sites web des clubs
  étudiants et les projets du club CEDILLE.
- **Staging**: Environnement de staging pour les sites web des clubs étudiants
    et les projets du club CEDILLE.
- **Sandbox**: Environnement de développement pour les projets du club cédille.

### Production

L'environnement de production est utilisé pour héberger les sites web des clubs
étudiants et les projets du club CEDILLE. Il est accessible au public et utilise
des certificats SSL pour sécuriser les connexions.

### Staging

L'environnement de staging est utilisé pour tester les mises à jour et les
nouveaux déploiements avant de les déployer en production. Il est accessible aux
membres du club CEDILLE et aux clubs étudiants pour vérifier les changements et
les problèmes potentiels.

### Sandbox

L'environnement de sandbox est utilisé pour le développement et les tests des
projets du club CEDILLE. Il est isolé des autres environnements pour éviter les
interférences et les conflits.

Un workflow de déploiement automatisé d'environnement sandbox pour les membres
du club CEDILLE est disponible et accessible en exécutant le workflow GitHub
[demander un sandbox
Kubernetes](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-sandbox.yml).
Le workflow crée une Pull Request pour déployer un environnement sandbox pour
l'utilisateur qui a déclenché le workflow. Des détails supplémentaires sur
l'utilisation de l'environnement sandbox sont disponibles dans la Pull Request
générée.
