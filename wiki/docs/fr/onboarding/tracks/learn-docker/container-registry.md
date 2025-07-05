## Travailler avec Docker Hub

[Docker Hub](https://hub.docker.com/) est un service de dépôt basé sur le cloud
où les utilisateurs de Docker et les partenaires peuvent créer, tester, stocker
et distribuer des images de conteneurs. C'est la plus grande bibliothèque et
communauté mondiale d'images de conteneurs. Dans ce guide, nous vous montrerons
comment interagir avec Docker Hub, notamment comment tirer et pousser des
images, et mettrons en lumière certaines des fonctionnalités utiles disponibles
sur Docker Hub.

### Configuration de Docker Hub

**1. Créer un Compte Docker Hub :**

Avant de pouvoir utiliser Docker Hub, vous devez créer un compte. Visitez le
[site web de Docker Hub](https://hub.docker.com/) et inscrivez-vous pour un
compte gratuit.

**2. Se Connecter à Docker Hub :**

Ouvrez votre terminal et connectez-vous à Docker Hub en utilisant vos
identifiants de compte :

```
docker login
```

Vous serez invité à saisir votre nom d'utilisateur et votre mot de passe Docker
Hub. Une fois authentifié, vous pourrez commencer à interagir avec Docker Hub.

### Tirer des Images depuis Docker Hub

Docker Hub héberge un grand nombre d'images de conteneurs pré-construites que
vous pouvez utiliser dans vos projets. Pour tirer une image depuis Docker Hub,
utilisez la commande `docker pull`.

**1. Rechercher une Image :**

Pour trouver une image, vous pouvez rechercher sur Docker Hub en utilisant la
commande suivante :

```
docker search <nom-de-l-image>
```

Par exemple, pour rechercher une image Node.js, vous utiliseriez :

```
docker search node
```

Cette commande liste les images disponibles avec le nom "node" sur Docker Hub.

**2. Tirer une Image :**

Une fois que vous avez trouvé l'image dont vous avez besoin, vous pouvez la
tirer sur votre machine locale :

```
docker pull <nom-de-l-image>
```

Par exemple, pour tirer l'image officielle Node.js, vous utiliseriez :

```
docker pull node
```

Cette commande télécharge l'image depuis Docker Hub vers votre système local.

**3. Exécuter l'Image Tirée :**

Après avoir tiré l'image, vous pouvez l'exécuter en utilisant la commande
`docker run` :

```
docker run -d -p 3000:3000 node
```

Cette commande démarre un conteneur à partir de l'image Node.js et mappe le port
3000 de votre machine locale sur le port 3000 dans le conteneur.

### Pousser des Images vers Docker Hub

Si vous avez créé une image Docker personnalisée que vous souhaitez partager
avec d'autres, vous pouvez la pousser vers Docker Hub.

**1. Taguer Votre Image :**

Avant de pouvoir pousser votre image, vous devez la taguer avec votre nom
d'utilisateur Docker Hub et le nom du dépôt :

```
docker tag <image-locale> <nom-utilisateur-dockerhub>/<nom-du-depot>:<tag>
```

Par exemple, si votre nom d'utilisateur Docker Hub est "monnomutilisateur" et le
nom de votre dépôt est "monappli", vous utiliseriez :

```
docker tag monappli monnomutilisateur/monappli:latest
```

**2. Pousser l'Image :**

Une fois que votre image est taguée, vous pouvez la pousser vers Docker Hub :

```
docker push <nom-utilisateur-dockerhub>/<nom-du-depot>:<tag>
```

En utilisant l'exemple précédent, vous utiliseriez :

```
docker push monnomutilisateur/monappli:latest
```

Cette commande télécharge votre image vers Docker Hub, la rendant disponible
pour que d'autres puissent la tirer et l'utiliser.

### Fonctionnalités Utiles de Docker Hub

**1. Builds Automatisés :**

Docker Hub peut automatiquement construire des images à partir d'un dépôt GitHub
ou Bitbucket. Cela est utile pour les workflows d'intégration continue et de
déploiement continu (CI/CD). Vous pouvez configurer des builds automatisés dans
les paramètres du dépôt Docker Hub.

**2. Webhooks :**

Les webhooks vous permettent de déclencher des actions après un push ou un pull
réussi d'une image. Vous pouvez utiliser les webhooks pour intégrer Docker Hub
avec d'autres services, comme déclencher un processus de déploiement après avoir
poussé une image.

**3. Organisations et Équipes :**

Docker Hub prend en charge les organisations et les équipes, facilitant la
gestion des permissions et la collaboration sur les projets. Vous pouvez créer
une organisation, ajouter des membres d'équipe et attribuer des rôles pour
contrôler qui peut accéder et modifier vos images.

**4. Images Officielles :**

Docker Hub héberge une variété d'images officielles maintenues par Docker et
d'autres entités de confiance. Ces images sont généralement bien documentées,
régulièrement mises à jour et constituent un bon point de départ pour de
nombreuses applications.

**5. Dépôts :**

Vous pouvez créer plusieurs dépôts sous votre compte Docker Hub pour organiser
vos images. Chaque dépôt peut contenir plusieurs versions d'une image, taguées
avec différents tags (par exemple, `latest`, `v1.0`, `v2.0`).

**6. Insights sur les Images :**

Docker Hub fournit des insights sur vos images, tels que le nombre de pulls, les
étoiles et l'heure de la dernière mise à jour. Ces informations peuvent vous
aider à suivre la popularité et l'utilisation de vos images.

### Registre de Conteneurs GitHub

[Le Registre de Conteneurs
GitHub](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
est une autre option populaire pour stocker et gérer des images de conteneurs
que Club CEDILLE utilise souvent. Il est étroitement intégré à GitHub, ce qui en
fait un choix pratique pour les développeurs qui utilisent déjà GitHub pour la
gestion de leur code source. Voici quelques fonctionnalités clés :

**1. Intégration avec les Repositories GitHub :**

- Le Registre de Conteneurs GitHub vous permet de stocker des images de
  conteneurs aux côtés de vos dépôts de code. Cette intégration simplifie votre
  workflow en conservant votre code et vos images de conteneurs au même endroit.

**2. Contrôle d'Accès et Permissions :**

- Vous pouvez contrôler qui a accès à vos images de conteneurs en utilisant le
  modèle de permissions existant de GitHub. Cela facilite la gestion de l'accès
  pour les membres de votre équipe.

**3. Support pour les Images Publiques et Privées :**

- Tout comme Docker Hub, le Registre de Conteneurs GitHub prend en charge les
  images publiques et privées. Vous pouvez choisir de partager vos images avec
  la communauté ou de restreindre l'accès à des utilisateurs ou des équipes
  spécifiques.

**4. Intégration avec GitHub Actions :**

- Vous pouvez utiliser GitHub Actions pour automatiser vos workflows, y compris
  la construction et le push d'images vers le Registre de Conteneurs
  GitHub. Cela est utile pour les pipelines CI/CD, garantissant que vos images
  sont toujours à jour.

**5. Gratuit pour les Dépôts Publics :**

- Le Registre de Conteneurs GitHub offre une utilisation gratuite pour les
  dépôts publics, en en faisant une option attrayante pour les projets
  open-source.

### Résumé

Docker Hub est une plateforme puissante pour le partage et la distribution
d'images Docker. En exploitant Docker Hub, vous pouvez rationaliser vos
workflows de développement et de déploiement, collaborer avec d'autres et
accéder à une vaste bibliothèque d'images de conteneurs. Que vous tiriez des
images officielles pour vos projets ou partagiez vos images personnalisées avec
la communauté, Docker Hub est un outil essentiel dans l'écosystème Docker.

Si vous êtes intéressé, vous pouvez également consulter l'un des [packages de
pipeline GitHub du Club
Cédille](https://github.com/orgs/ClubCedille/packages). Les packages de pipeline
GitHub sont un ensemble d'outils et de configurations qui aident à automatiser
divers aspects du cycle de vie du développement logiciel, tels que la
construction, les tests et le déploiement des applications. En utilisant ces
packages, les développeurs peuvent garantir des processus cohérents et
reproductibles, améliorer l'efficacité et réduire les risques d'erreurs lors du
déploiement.
