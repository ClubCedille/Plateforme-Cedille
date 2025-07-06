# Installation

Docker Inc. distribue plusieurs versions de Docker adaptées à différents
environnements :

- **Docker Desktop** : Disponible pour macOS et Windows, Docker Desktop fournit
  un environnement intégré pour créer, tester et déployer des applications
  conteneurisées.
- **Docker Community Edition (CE)** : Conçue pour les environnements Linux,
  Docker CE est une version gratuite de Docker adaptée à un usage personnel et à
  des déploiements à petite échelle.
- **Docker Enterprise** : Destiné aux déploiements à l'échelle de l'entreprise,
  Docker Enterprise offre des fonctionnalités supplémentaires telles que des
  capacités de gestion avancées et une sécurité de niveau entreprise.

## Installer Docker

### Docker Desktop

Pour **Windows** et **macOS**, Docker Desktop est le choix recommandé. Il
installe Docker Engine, le client Docker CLI, Docker Compose, Docker Machine et
les outils Kubernetes, fournissant un environnement Docker complet.

- Guide d'installation pour Windows :
  [Docker Desktop pour Windows](https://docs.docker.com/desktop/setup/install/windows-install/)
- Guide d'installation pour macOS :
  [Docker Desktop pour macOS](https://docs.docker.com/desktop/setup/install/mac-install/)

![docker desktop](img/docker-desktop.svg)

### Docker Community Edition (CE)

Si vous utilisez **Linux**, Docker CE convient aussi bien à un usage personnel
qu'aux déploiements sur serveur. Les instructions d'installation se trouvent
généralement sur le
[site web de Docker](https://docs.docker.com/engine/install/ubuntu/) ou dans le
gestionnaire de paquets de votre distribution Linux.

### Docker Enterprise

Pour les organisations ayant des déploiements Docker complexes, Docker
Enterprise fournit une plateforme robuste avec un support de niveau entreprise
et des outils de gestion supplémentaires.

- Plus d'informations :
  [Docker Enterprise](https://www.docker.com/products/business/)

## Docker Hub

**Docker Hub** sert de ressource centralisée pour la découverte, la distribution
et la collaboration autour des images de conteneurs. À l'instar de GitHub,
Docker Hub permet aux utilisateurs de stocker et partager des images Docker.

Pour commencer avec Docker et accéder à Docker Hub, vous devez créer un compte
Docker Hub :

- Inscrivez-vous sur [Docker Hub](https://hub.docker.com/).

![dockerhub](img/dockerhub.PNG)

## Installer Git (optionnel)

- **Windows :**

  Téléchargez Git depuis [git-scm.com](https://git-scm.com/download/win) et
  exécutez l'installateur. Suivez les instructions et choisissez les options par
  défaut.

- **macOS :**

  Git devrait déjà être disponible sur macOS. Vous pouvez vérifier en ouvrant
  Terminal et en tapant :

  ```bash
  git --version
  ```

  Si Git n'est pas installé, vous serez invité à l'installer.

- **Linux (Ubuntu/Debian) :**

  Ouvrez un terminal et installez Git en utilisant apt-get :

  ```bash
  sudo apt-get update
  sudo apt-get install git
  ```

- **Linux (Fedora) :**

  Ouvrez un terminal et installez Git en utilisant dnf :

  ```bash
  sudo dnf install git
  ```

- **Autres distributions Linux :**

  Utilisez le gestionnaire de paquets spécifique à votre distribution pour
  installer Git.
