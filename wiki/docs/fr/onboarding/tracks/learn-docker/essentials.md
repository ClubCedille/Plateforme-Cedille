# Qu'est-ce que Docker ?

Docker est une [plateforme open-source](https://www.docker.com) qui vous permet
de packager votre application avec toutes ses dépendances dans une unité
standardisée appelée conteneur. Ces conteneurs sont légers et portables, ce qui
signifie que vous pouvez les déplacer facilement entre différents
environnements. Chaque conteneur est isolé de l'infrastructure sous-jacente et
des autres conteneurs, assurant ainsi la cohérence et la sécurité. Une fois que
vous avez créé une image Docker, vous pouvez l'exécuter en tant que conteneur
Docker sur n'importe quelle machine avec Docker installé, quel que soit le
système d'exploitation. Cela élimine le besoin de se soucier des problèmes de
compatibilité, car le conteneur encapsule tout ce dont l'application a besoin
pour fonctionner.

![docker](img/docker.jpg)

## Pourquoi choisir Docker ?

Docker est devenu populaire en raison de son impact significatif sur le
développement et le déploiement de logiciels. Voici quelques raisons principales
de son adoption généralisée :

1. **Portabilité** : Docker permet aux développeurs de packager leurs
   applications avec toutes les dépendances dans des conteneurs légers. Cela
   assure des performances cohérentes à travers divers environnements
   informatiques, du développement à la production.

2. **Reproductibilité** : En encapsulant les applications et leurs dépendances
   dans des conteneurs, Docker assure que les configurations logicielles restent
   cohérentes à travers les environnements de développement, de test et de
   production. Cela réduit le problème du "ça fonctionne sur ma machine".

3. **Efficacité** : L'architecture basée sur des conteneurs de Docker optimise
   l'utilisation des ressources. Elle permet à plusieurs applications isolées de
   fonctionner sur un seul système hôte, utilisant mieux les ressources
   disponibles et améliorant l'efficacité globale.

4. **Scalabilité** : Docker facilite la gestion des charges de travail accrues
   pour les développeurs. Ses fonctionnalités de scalabilité permettent aux
   applications de monter ou descendre en charge sans problème, assurant
   qu'elles peuvent gérer des niveaux de demande variables sans soucis.

## Composants importants de Docker

Voici quelques-uns des composants clés de Docker, expliqués en détail :

1. **Docker Daemon (Docker Engine)** : Il s'agit de la partie centrale de Docker
   qui gère la création, l'exécution et la gestion des conteneurs. Il se compose
   d'un serveur (un processus daemon de longue durée), d'une [API
   REST](https://docs.docker.com/engine/api/v1.41/) et d'une interface en ligne
   de commande (CLI).

2. **Image Docker** : Une [image
   Docker](https://docs.docker.com/engine/reference/glossary/#image) est un
   modèle en lecture seule qui inclut le code de votre application, les
   bibliothèques et les dépendances. Elle est utilisée pour créer des
   conteneurs. Une fois qu'une image est construite, elle peut être utilisée
   pour exécuter des conteneurs de manière répétée, assurant la cohérence à
   travers différents environnements.

3. **Docker Hub** : [Docker Hub](https://hub.docker.com) est un référentiel basé
   sur le cloud où vous pouvez trouver, partager et gérer des images Docker. Il
   vous permet de télécharger vos propres images et de télécharger des images
   créées par d'autres, facilitant ainsi le partage et la collaboration.

4. **Dockerfile** : Un
   [Dockerfile](https://docs.docker.com/engine/reference/builder/) est un script
   qui contient une série d'instructions sur la façon de construire une image
   Docker. Il inclut des commandes pour spécifier l'image de base, installer des
   packages logiciels, copier des fichiers et définir des variables
   d'environnement. En exécutant un Dockerfile, vous pouvez créer une image
   Docker.

5. **Registre Docker** : Un [registre Docker](https://docs.docker.com/registry/)
   est un système de stockage et de distribution pour les images Docker. Vous
   pouvez stocker des images en mode public et privé. Les registres publics,
   comme Docker Hub, permettent à quiconque d'accéder aux images, tandis que les
   registres privés restreignent l'accès à des utilisateurs ou organisations
   spécifiques. Cela permet un stockage et une distribution sécurisés des images
   au sein d'une équipe ou d'une entreprise.

![components](img/components.png)

## Qu'est-ce qu'un Dockerfile ?

Un [Dockerfile](https://docs.docker.com/engine/reference/builder/) utilise un
langage spécifique au domaine (DSL) et contient des instructions pour générer
une image Docker. Le Dockerfile définit les processus pour produire rapidement
une image. Lors de la création de votre application, vous devez créer un
Dockerfile dans un ordre spécifique, car le daemon Docker exécute toutes les
instructions de haut en bas.

- Un Dockerfile est un document texte contenant les commandes nécessaires qui,
  lorsqu'elles sont exécutées, aident à assembler une image Docker.
- Les images Docker sont créées en utilisant des Dockerfiles.

## Qu'est-ce qu'une image Docker ?

Une [image Docker](https://docs.docker.com/engine/reference/glossary/#image) est
un fichier composé de plusieurs couches, utilisé pour exécuter du code dans un
conteneur Docker. C'est essentiellement un ensemble d'instructions pour créer
des conteneurs Docker.

- **Package exécutable** : Une image Docker est un package exécutable de
  logiciel qui inclut tout ce qui est nécessaire pour exécuter une application,
  comme le code, le runtime, les bibliothèques, les variables d'environnement et
  les fichiers de configuration.

- **Ensemble d'instructions** : L'image contient toutes les instructions sur la
  façon de créer et d'exécuter un conteneur, déterminant quels composants
  logiciels vont fonctionner et comment ils doivent être configurés.

- **Création de conteneur** : Lorsqu'une image Docker est exécutée, elle crée un
  conteneur Docker. Le conteneur est un environnement virtuel qui encapsule le
  code de l'application avec toutes ses dépendances, garantissant que
  l'application fonctionne rapidement et de manière fiable à travers différents
  environnements informatiques.

## Qu'est-ce qu'un conteneur Docker ?

Un [conteneur
Docker](https://docs.docker.com/engine/reference/glossary/#container) est une
instance en cours d'exécution d'une image Docker. Il permet aux développeurs de
packager des applications avec toutes les dépendances nécessaires, telles que
les bibliothèques et les configurations, en une seule unité.

- **Instance en cours d'exécution** : Un conteneur est essentiellement une
  instance active d'une image qui s'exécute comme un processus sur la machine
  hôte. Il encapsule le code de l'application et son environnement d'exécution,
  garantissant que l'application peut fonctionner de manière isolée et cohérente
  à travers différents environnements.

- **Exécution isolée** : Les conteneurs fournissent une isolation pour les
  applications, ce qui signifie qu'elles fonctionnent indépendamment de l'hôte
  et des autres conteneurs. Cette isolation garantit que les modifications ou
  les dépendances au sein d'un conteneur n'affectent pas les autres, améliorant
  ainsi la sécurité et la fiabilité.

- **Exemple** : Par exemple, si vous avez une image Docker contenant un système
  d'exploitation Ubuntu avec un serveur Nginx configuré, exécuter cette image
  avec la commande `docker run` créera un conteneur. Ce conteneur exécutera
  alors le serveur Nginx dans l'environnement Ubuntu, isolé des autres
  conteneurs et du système hôte.

## Qu'est-ce qu'un registre de conteneurs ?

Un [registre de conteneurs](https://docs.docker.com/registry/) est un service où
les développeurs et les équipes DevOps peuvent stocker, gérer et partager des
images de conteneurs. Il sert de ressource centralisée pour les images de
conteneurs, permettant aux utilisateurs de pousser leurs propres images pour un
usage privé ou public et de tirer des images créées par d'autres. Les registres
de conteneurs peuvent être basés sur le cloud ou sur site, et ils prennent en
charge une variété de cas d'utilisation et de workflows dans le développement et
le déploiement d'applications conteneurisées.

### Caractéristiques clés d'un registre de conteneurs

- **Service de dépôt** : Un registre de conteneurs agit comme un dépôt où les
  images de conteneurs sont stockées et organisées. Les utilisateurs peuvent
  télécharger leurs images de conteneurs vers le registre pour le stockage et la
  distribution.

- **Options basées sur le cloud et sur site** : Les registres de conteneurs
  peuvent fonctionner sur le cloud ou être hébergés sur site. Les registres
  basés sur le cloud offrent l'avantage d'une accessibilité depuis n'importe où
  via Internet, tandis que les registres sur site offrent un meilleur contrôle
  sur l'infrastructure et les données.

- **Registres publics et privés** : Les registres de conteneurs prennent en
  charge à la fois les dépôts publics et privés. Les dépôts publics permettent
  de partager des images ouvertement avec la communauté, tandis que les dépôts
  privés restreignent l'accès aux utilisateurs ou équipes autorisés.

- **Utilisation en DevOps** : Les registres de conteneurs sont largement
  utilisés par les équipes DevOps pour gérer les applications
  conteneurisées. Ils facilitent la collaboration en permettant aux équipes de
  partager et de déployer des images standardisées de manière fiable.

- **Disponibilité et exigences** : Les registres de conteneurs sont disponibles
  pour tous les systèmes d'exploitation et sont des outils essentiels pour
  quiconque travaille avec des conteneurs. Les utilisateurs accédant à un
  registre de conteneurs doivent avoir une connaissance de base des commandes de
  conteneur pour pousser et

tirer des images efficacement.

### Registres de conteneurs populaires

- **Docker Hub** : Un [registre basé sur le cloud](https://hub.docker.com)
  largement utilisé fourni par Docker. Il permet aux utilisateurs de stocker et
  de partager des images de conteneurs publiquement ou en privé.

- **Amazon Elastic Container Registry (ECR)** : Un service de registre de
  conteneurs géré par [AWS](https://aws.amazon.com/ecr/) qui s'intègre à
  d'autres services AWS et prend en charge les dépôts publics et privés.

- **Google Container Registry (GCR)** : Un registre de conteneurs privé fourni
  par [Google Cloud Platform](https://cloud.google.com/container-registry),
  offrant une haute disponibilité et une intégration avec les services Google
  Cloud.

- **Azure Container Registry (ACR)** : Un service de registre de conteneurs géré
  par [Microsoft
  Azure](https://azure.microsoft.com/en-us/services/container-registry/) qui
  prend en charge les images Docker et Open Container Initiative (OCI).

- **GitHub Container Registry** : Un service fourni par
  [GitHub](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
  pour stocker et gérer des images de conteneurs aux côtés des dépôts de code
  source.
