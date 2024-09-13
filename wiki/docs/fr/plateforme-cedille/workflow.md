# Flux de travail

Ce document décrit les pipelines de développement et de déploiement disponibles
et utilisés pour la plateforme CEDILLE.

## Terraform Cloud

La plateforme CEDILLE utilise Terraform Cloud pour la gestion de
l'infrastructure et le déploiement des ressources. Les fichiers de configuration
Terraform sont stockés dans le dépôt GitHub `Plateforme-Cedille` sous le dossier
`terraform`. Les fichiers de configuration Terraform sont organisés en modules
pour gérer différents aspects de l'infrastructure, tels que les repertoires
github, les utilisateurs github, les ressources pour notre instance de hashicorp
Vault, etc. Les modules Terraform sont déployés à l'aide de Terraform Cloud, qui
est configuré pour déclencher des déploiements automatiques lorsqu'un commit est
effectué sur la branche `master` du dépôt `Plateforme-Cedille`.

## ArgoCD

La plateforme CEDILLE utilise ArgoCD pour le déploiement continu des
applications Kubernetes. Les fichiers de configuration ArgoCD sont stockés dans
le dépôt GitHub `Plateforme-Cedille` sous le dossier `apps` et system. Les
fichiers de configuration ArgoCD sont organisés en applications pour gérer
différents aspects des applications Kubernetes, tels que les applications de
haut-niveau (apps) et les applications système (system). Une synchronisation
automatique est configurée pour les applications ArgoCD avec le dépôt
`Plateforme-Cedille`.

## Ajouter un nouveau membre à l'organisation

Pour ajouter un nouveau membre à l'organisation GitHub du club CEDILLE, le
workflow `add-new-member` est disponible. Ce workflow crée une Pull Request pour
ajouter un nouveau membre à l'organisation GitHub du club CEDILLE. Pour exécuter
le workflow, simplement cliquer sur le lien suivant: [Ajouter un nouveau
membre](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/add-new-member.yml).

## Demander un sandbox Kubernetes

Un workflow de déploiement automatisé d'environnement sandbox pour les membres
du club CEDILLE est disponible et accessible en exécutant le workflow GitHub
[demander un sandbox
Kubernetes](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-sandbox.yml).
Le workflow crée une pull request pour déployer un environnement sandbox avec
vcluster pour l'utilisateur qui a déclenché le workflow. Des détails
supplémentaires sur l'utilisation de l'environnement sandbox sont disponibles
dans la Pull Request générée.

## Apply omni config files

Le workflow `apply-omni` est utilisé pour appliquer les fichiers de
configuration omni dans le cluster Kubernetes de la plateforme CEDILLE. Le
workflow s'exécute automatiquement lorsqu'un commit est effectué sur la branche
`master` du dépôt `Plateforme-Cedille`.

## Demander un site web GRAV

Un workflow de déploiement automatisé de site web GRAV pour les clubs étudiants
est disponible et accessible en exécutant le workflow GitHub [demander un site
web
GRAV](https://github.com/ClubCedille/Plateforme-Cedille/actions/workflows/request-grav.yml).
Le workflow crée une pull request pour déployer un site web GRAV pour le club
étudiant pour qui le workflow a été déclenché. Des détails supplémentaires sur
l'utilisation du site web GRAV sont disponibles dans la pull request générée.
