# Qu'est-ce que Docker ?

Docker est une plateforme open-source qui vous permet de conditionner votre application ainsi que toutes ses dépendances dans une unité standardisée appelée conteneur. Ces conteneurs sont légers et portables, ce qui signifie que vous pouvez facilement les déplacer entre différents environnements. Chaque conteneur est isolé de l'infrastructure sous-jacente et des autres conteneurs, garantissant ainsi la cohérence et la sécurité. Une fois que vous avez créé une image Docker, vous pouvez l'exécuter en tant que conteneur Docker sur n'importe quelle machine avec Docker installé, indépendamment du système d'exploitation. Cela élimine le besoin de se soucier des problèmes de compatibilité, car le conteneur encapsule tout ce dont l'application a besoin pour fonctionner.

![docker](img/docker.jpg)

## Pourquoi choisir Docker ?

Docker est devenu populaire en raison de son impact significatif sur le développement et le déploiement de logiciels. Voici quelques raisons clés de son adoption généralisée :

1. **Portabilité** : Docker permet aux développeurs de conditionner leurs applications avec toutes leurs dépendances dans des conteneurs légers. Cela garantit des performances constantes dans divers environnements informatiques, du développement à la production.

2. **Reproductibilité** : En encapsulant les applications et leurs dépendances dans des conteneurs, Docker assure que les configurations logicielles restent cohérentes à travers les environnements de développement, de test et de production. Cela réduit le problème du "ça fonctionne sur ma machine".

3. **Efficacité** : L'architecture basée sur les conteneurs de Docker optimise l'utilisation des ressources. Elle permet à plusieurs applications isolées de s'exécuter sur un seul système hôte, optimisant ainsi les ressources disponibles et améliorant l'efficacité globale.

4. **Scalabilité** : Docker facilite la gestion des charges de travail croissantes pour les développeurs. Ses fonctionnalités de scalabilité permettent aux applications de s'adapter facilement aux niveaux de demande variables sans problème.

## Composants Importants de Docker

Voici quelques-uns des principaux composants de Docker, expliqués en détail :

1. **Démon Docker (Moteur Docker)** : C'est la partie centrale de Docker qui gère la création, l'exécution et la gestion des conteneurs. Il comprend un serveur (un processus démon de longue durée), une API REST et une interface en ligne de commande (CLI).

2. **Image Docker** : Une image Docker est un modèle en lecture seule qui inclut le code de votre application, les bibliothèques et les dépendances. Elle est utilisée pour créer des conteneurs. Une fois qu'une image est construite, elle peut être utilisée pour exécuter des conteneurs de manière répétée, assurant ainsi la cohérence dans différents environnements.

3. **Docker Hub** : Docker Hub est un référentiel basé sur le cloud où vous pouvez trouver, partager et gérer des images Docker. Il vous permet de télécharger vos propres images et de télécharger des images créées par d'autres, facilitant ainsi le partage et la collaboration.

4. **Dockerfile** : Un Dockerfile est un script qui contient une série d'instructions sur la manière de construire une image Docker. Il inclut des commandes pour spécifier l'image de base, installer des packages logiciels, copier des fichiers et définir des variables d'environnement. En exécutant un Dockerfile, vous pouvez créer une image Docker.

5. **Registre Docker** : Un registre Docker est un système de stockage et de distribution pour les images Docker. Vous pouvez stocker des images en mode public ou privé. Les registres publics, comme Docker Hub, permettent à tout le monde d'accéder aux images, tandis que les registres privés restreignent l'accès à des utilisateurs ou des organisations spécifiques. Cela permet un stockage et une distribution sécurisés des images au sein d'une équipe ou d'une entreprise.

![components](img/components.png)

## Qu'est-ce qu'un Dockerfile ?

Un Dockerfile utilise un langage spécifique au domaine (DSL) et contient des instructions pour générer une image Docker. Le Dockerfile définit les processus pour produire rapidement une image. Lorsque vous créez votre application, vous devez créer un Dockerfile dans un ordre spécifique, car le démon Docker exécute toutes les instructions de haut en bas.

- Un Dockerfile est un document texte contenant des commandes nécessaires qui, une fois exécutées, aident à assembler une image Docker.
- Les images Docker sont créées à l'aide de Dockerfiles.

## Qu'est-ce qu'une Image Docker ?

Une image Docker est un fichier composé de plusieurs couches, utilisé pour exécuter du code dans un conteneur Docker. C'est essentiellement un ensemble d'instructions pour créer des conteneurs Docker.

- **Paquet Exécutable** : Une image Docker est un paquet exécutable de logiciel qui inclut tout ce dont une application a besoin pour fonctionner, comme le code, l'environnement d'exécution, les bibliothèques, les variables d'environnement et les fichiers de configuration.

- **Ensemble d'Instructions** : L'image contient toutes les instructions sur la manière de créer et d'exécuter un conteneur, déterminant quels composants logiciels seront exécutés et comment ils doivent être configurés.

- **Création de Conteneur** : Lorsqu'une image Docker est exécutée, elle crée un conteneur Docker. Le conteneur est un environnement virtuel qui encapsule le code de l'application ainsi que toutes ses dépendances, garantissant que l'application s'exécute rapidement et de manière fiable dans différents environnements informatiques.

## Qu'est-ce qu'un Conteneur Docker ?

Un conteneur Docker est une instance d'exécution d'une image Docker. Il permet aux développeurs de conditionner des applications avec toutes les dépendances nécessaires, telles que les bibliothèques et les configurations, dans une unité unique.

- **Instance d'Exécution** : Un conteneur est essentiellement une instance en direct d'une image qui s'exécute en tant que processus sur la machine hôte. Il encapsule le code de l'application et son environnement d'exécution, assurant que l'application peut fonctionner de manière isolée et cohérente dans différents environnements.

- **Exécution Isolée** : Les conteneurs fournissent une isolation pour les applications, ce qui signifie qu'ils s'exécutent indépendamment de l'hôte et des autres conteneurs. Cette isolation garantit que les changements ou les dépendances dans un conteneur n'affectent pas les autres, améliorant ainsi la sécurité et la fiabilité.

- **Exemple** : Par exemple, si vous avez une image Docker contenant un système d'exploitation Ubuntu avec un serveur Nginx configuré, l'exécution de cette image avec la commande `docker run` créera un conteneur. Ce conteneur exécutera ensuite le serveur Nginx dans l'environnement Ubuntu OS, isolé des autres conteneurs et du système hôte.

## Qu'est-ce qu'un Registre de Conteneurs ?

Un registre de conteneurs est un service où les développeurs et les équipes DevOps peuvent stocker, gérer et partager des images de conteneurs. Il sert de ressource centralisée pour les images de conteneurs, permettant aux utilisateurs de télécharger leurs propres images pour une utilisation privée ou publique, et de télécharger des images créées par d'autres. Les registres de conteneurs peuvent être basés sur le cloud ou sur site, et ils prennent en charge une variété de cas d'utilisation et de workflows dans le développement et le déploiement d'applications conteneurisées.

### Caractéristiques Clés d'un Registre de Conteneurs

- **Service de Répertoire** : Un registre de conteneurs sert de répertoire où les images de conteneurs sont stockées et organisées. Les utilisateurs peuvent télécharger leurs images de conteneurs dans le registre pour le stockage et la distribution.

- **Options Cloud et Sur Site** : Les registres de conteneurs peuvent fonctionner sur le cloud ou être hébergés sur site. Les registres basés sur le cloud offrent l'avantage de l'accessibilité depuis n'importe où via Internet, tandis que les registres sur site offrent plus de contrôle sur l'infrastructure et les données.

- **Registres Publics et Privés** : Les registres de conteneurs prennent en charge à la fois les dépôts publics et privés. Les dépôts publics permettent de partager librement les images avec la communauté, tandis que les dépôts privés restreignent l'accès aux utilisateurs ou équipes autorisés.

- **Utilisation en DevOps** : Les équipes DevOps utilisent largement les registres de conteneurs pour la gestion des applications conteneurisées. Ils facilitent la collaboration en permettant aux équipes de partager et de déployer des images standardisées de manière fiable.

- **Disponibilité et Exigences** : Les registres de conteneurs sont disponibles pour tous les systèmes d'exploitation et sont des outils essentiels pour tous ceux qui travaillent avec des conteneurs. Les utilisateurs accédant à un registre de conteneurs doivent avoir des connaissances de base des commandes de conteneurs pour pousser et tirer les images efficacement.

### Registres de Conteneurs Populaires

- **Docker Hub** : Un registre largement utilisé basé sur le cloud fourni par Docker. Il permet aux utilisateurs de stocker et de partager des images de conteneurs publiquement ou en privé.

- **Amazon Elastic Container Registry (ECR)** : Un service de registre de conteneurs géré par AWS qui s'intègre avec d'autres services AWS et prend en charge les dépôts publics et privés.

- **Google Container Registry (GCR)** : Un registre de conteneurs privé fourni par Google Cloud Platform, offrant une grande disponibilité et une intégration avec les services Google Cloud.

- **Azure Container Registry (ACR)** : Un service de registre de conteneurs géré par Microsoft Azure qui prend en charge les images Docker et Open Container Initiative (OCI).

- **GitHub Container Registry** : Un service fourni par GitHub pour stocker et gérer des images de conteneurs aux côtés des référentiels de code source.