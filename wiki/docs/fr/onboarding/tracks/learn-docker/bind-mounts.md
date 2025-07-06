# Comprendre les montages bind dans Docker

Docker isole tout le contenu, le code et les données d'un conteneur de votre
système de fichiers local. Parfois, cependant, vous souhaiterez peut-être que le
conteneur accède à un répertoire de votre système. C'est là que les bind mounts
sont utiles.

## Utilisation des Bind Mounts pour Accéder aux Dossiers Locaux

Si vous souhaitez accéder aux données de votre système, vous pouvez utiliser un
bind mount. Un bind mount vous permet de partager un répertoire du système de
fichiers de votre hôte dans le conteneur, permettant ainsi au conteneur
d'accéder et de modifier des fichiers dans ce répertoire.

### Exemple : Ajout d'un Bind Mount à un Projet Docker Compose

Nous utiliserons le dépôt à l'adresse
[https://github.com/docker/bindmount-apps](https://github.com/docker/bindmount-apps)
pour démontrer comment ajouter un bind mount à un projet Docker Compose.

**1. Cloner le Dépôt :**

```bash
git clone https://github.com/docker/bindmount-apps
cd bindmount-apps
```

**2. Modifier le Fichier `compose.yaml` :**

Pour ajouter un bind mount à ce projet, ouvrez le fichier `compose.yaml` et
décommentez les lignes suivantes :

```yaml
services:
  todo-app:
    # ...
    volumes:
      - ./app:/usr/src/app
      - /usr/src/app/node_modules
```

**Explication :**

- L'élément `volumes` indique à Compose de monter le dossier local `./app` vers
  `/usr/src/app` dans le conteneur du service `todo-app`. Ce bind mount
  particulier remplace le contenu statique du répertoire `/usr/src/app` dans le
  conteneur et crée ce qu'on appelle un conteneur de développement.
- La deuxième instruction, `/usr/src/app/node_modules`, empêche le bind mount de
  remplacer le répertoire `node_modules` du conteneur pour préserver les paquets
  installés dans le conteneur.

**3. Lancer l'Application Docker Compose :**

Ouvrez un terminal dans votre répertoire de projet et exécutez la commande
suivante :

```bash
docker-compose up -d
```

**Explication :** Cette commande démarrera l'application avec le bind mount
configuré. Docker montera le répertoire `./app` depuis votre hôte vers
`/usr/src/app` dans le conteneur.

**4. Développer avec les Bind Mounts :**

Maintenant, vous pouvez profiter de l'environnement du conteneur tout en
développant l'application sur votre système local. Toutes les modifications
apportées au répertoire `app` sur votre système local se reflètent dans le
conteneur.

Par exemple, dans votre répertoire local, ouvrez `app/views/todos.ejs` dans un
IDE ou un éditeur de texte, mettez à jour la chaîne `Enter your task` et
enregistrez le fichier. Visitez ou actualisez `http://localhost:3001` pour voir
les changements.

## Résumé

Les bind mounts sont utiles pour les environnements de développement où vous
devez interagir avec le conteneur et votre système de fichiers local
simultanément. Ils vous permettent de modifier des fichiers sur votre système
hôte et de voir ces modifications reflétées à l'intérieur du conteneur en temps
réel. Cela facilite le développement et les tests de votre application sans
avoir besoin de reconstruire l'image Docker après chaque modification.
