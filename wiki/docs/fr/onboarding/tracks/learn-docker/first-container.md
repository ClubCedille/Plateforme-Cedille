### Installation de Docker

Avant de commencer, assurez-vous d'avoir installé Git et Docker sur votre
système. Vous pouvez télécharger Docker depuis le [site officiel de
Docker](https://www.docker.com/products/docker-desktop/).

## Exécuter Votre Premier Conteneur Docker

**1. Cloner le Dépôt :**

Ouvrez votre terminal ou votre invite de commande après avoir installé Git et
clonez le dépôt 'welcome-to-docker' depuis GitHub en utilisant la commande
suivante :

```
git clone https://github.com/docker/welcome-to-docker
```

**2. Naviguer vers le Dépôt :**

Changez votre répertoire courant vers le dépôt cloné :

```
cd welcome-to-docker
```

**3. Lancer le Conteneur Docker :**

Utilisez la commande `docker run` pour démarrer le conteneur. Dans ce cas, nous
allons exécuter le conteneur 'welcome-to-docker' et mapper le port 8088 de votre
hôte au port 80 à l'intérieur du conteneur :

```
docker run -d -p 8088:80 docker/getting-started
```

- `-d` : Lance le conteneur en mode détaché, ce qui signifie qu'il s'exécute en
  arrière-plan.
- `-p 8088:80` : Mappe le port 8088 de votre machine locale au port 80 à
  l'intérieur du conteneur. Cela vous permet d'accéder au service web du
  conteneur depuis votre navigateur à l'adresse
  [`http://localhost:8088`](http://localhost:8088).

**4. Accéder au Conteneur :**

Ouvrez votre navigateur web et accédez à
[`http://localhost:8088`](http://localhost:8088). Vous devriez voir la page web
'welcome-to-docker', ce qui indique que le conteneur fonctionne correctement.

## Rechercher, Télécharger et Exécuter des Conteneurs depuis Docker Hub

**1. Rechercher des Conteneurs sur Docker Hub :**

Vous pouvez rechercher des conteneurs sur Docker Hub en utilisant la commande
`docker search`. Par exemple, pour rechercher des conteneurs liés à **nginx**,
utilisez :

```
docker search nginx
```

**2. Télécharger un Conteneur depuis Docker Hub :**

Utilisez la commande `docker pull` pour télécharger une image de conteneur
depuis Docker Hub. Par exemple, pour télécharger l'image de conteneur officielle
de **nginx**, utilisez :

```
docker pull nginx
```

**3. Exécuter un Conteneur depuis l'Image Téléchargée :**

Une fois que vous avez téléchargé une image, vous pouvez exécuter un conteneur à
partir de celle-ci en utilisant `docker run`. Par exemple, pour exécuter un
conteneur **nginx** et mapper le port 8080 de votre hôte au port 80 à
l'intérieur du conteneur, utilisez :

```
docker run -d -p 8080:80 nginx
```

- `-d` : Exécute le conteneur en mode détaché.
- `-p 8080:80` : Mappe le port 8080 de votre machine locale au port 80 à
  l'intérieur du conteneur.

## Arrêter le Conteneur Docker

**1. Trouver l'ID ou le Nom du Conteneur :**

Ouvrez une nouvelle fenêtre de terminal et listez tous les conteneurs Docker en
cours d'exécution :

```
docker ps
```

- Notez l'ID ou le Nom du Conteneur en cours d'exécution.

![docker-ps](img/docker-ps.png)

**2. Arrêter le Conteneur :**

Arrêtez le conteneur en utilisant la commande `docker stop` suivie de l'ID ou du
Nom du Conteneur :

```
docker stop <id_ou_nom_du_conteneur>
```

- Remplacez `<id_ou_nom_du_conteneur>` par l'ID ou le Nom réel de votre
  conteneur.

**3. Vérifier l'Arrêt du Conteneur :**

Pour vérifier que le conteneur a bien été arrêté, vous pouvez lister tous les
conteneurs (y compris ceux arrêtés) avec :

```
docker ps -a
```

Le conteneur arrêté ne devrait plus apparaître comme étant en cours d'exécution.

## Résumé

Félicitations ! Vous avez réussi à exécuter et arrêter des conteneurs Docker,
ainsi qu'à télécharger et exécuter des conteneurs depuis Docker Hub. Docker
offre une manière puissante de gérer et déployer des applications de manière
cohérente et efficace, rendant les flux de travail de développement et de
déploiement plus fluides et fiables.
