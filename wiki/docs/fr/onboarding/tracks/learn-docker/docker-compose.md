### Qu'est-ce que Docker Compose ?

Docker Compose est un outil qui vous permet de définir et de gérer des
applications Docker à plusieurs conteneurs. Avec Docker Compose, vous pouvez
décrire la configuration des services de votre application dans un fichier YAML,
facilitant ainsi le démarrage, l'arrêt et la gestion de l'ensemble de
l'application avec une seule commande.

## Exemple d'Application avec Docker Compose

Dans cet exemple, nous allons exécuter une application todo simple construite
avec ExpressJS et Node.js, avec les todos sauvegardées dans une base de données
MongoDB.

**1. Cloner le Dépôt :**

Ouvrez votre terminal ou votre invite de commandes et clonez le dépôt contenant
l'application exemple :

```sh
git clone https://github.com/docker/multi-container-app
```

**Explication :** Cette commande télécharge une copie du dépôt sur votre machine
locale.

**2. Naviguer vers le Dépôt :**

Changez votre répertoire actuel vers le dépôt cloné :

```sh
cd multi-container-app
```

**Explication :** Cette commande change le répertoire de travail actuel vers le
dossier `multi-container-app` où se trouve le code de l'application.

**3. Explorer le fichier `compose.yaml` :**

Le fichier `compose.yaml` définit les services (conteneurs) nécessaires pour
exécuter l'application. Ouvrez ce fichier dans un éditeur de texte pour voir la
configuration :

```yaml
version: '3'
services:
  web:
    image: node:14
    working_dir: /app
    volumes:
      - .:/app
    ports:
      - '3000:3000'
    command: 'npm start'
  database:
    image: mongo:4.2
    ports:
      - '27017:27017'
```

**Explication :** Ce fichier YAML définit deux services : `web` et `database`.
Le service `web` utilise une image Node.js et exécute l'application, tandis que
le service `database` utilise une image MongoDB. Les ports sont mappés pour
permettre l'accès depuis votre machine hôte.

**4. Exécuter l'Application :**

Utilisez la commande `docker compose up` pour construire et exécuter
l'application :

```sh
docker compose up -d
```

**Explication :**

- `docker compose up` : Construit, recrée, démarre et attache aux conteneurs
  pour un service.
- `-d` : Exécute les conteneurs en mode détaché, ce qui signifie qu'ils
  s'exécutent en arrière-plan.

**5. Accéder à l'Application :**

Ouvrez votre navigateur web et accédez à `http://localhost:3000`. Vous devriez
voir l'application todo en cours d'exécution.

**Explication :** Le service `web` mappe le port 3000 dans le conteneur sur le
port 3000 de votre machine hôte, rendant l'application accessible via
`http://localhost:3000`.

**6. Interagir avec l'Application :**

Ajoutez des tâches dans l'interface frontend. Les tâches sont enregistrées dans
la base de données MongoDB.

**Explication :** Le service `database` utilise MongoDB, qui stocke les tâches
que vous ajoutez via l'interface frontend.

**7. Arrêter l'Application :**

Pour arrêter les conteneurs en cours d'exécution, utilisez la commande
`docker compose down` :

```sh
docker compose down
```

**Explication :** Cette commande arrête et supprime les conteneurs, réseaux,
volumes et images créés par `docker compose up`.

## Détails du fichier `compose.yaml`

- **version :** Spécifie la version de la syntaxe Docker Compose utilisée.
- **services :** Définit les différents services (conteneurs) qui composent
  votre application.
  - **web :**
    - **image :** Spécifie l'image Docker à utiliser pour ce service
      (`node:14`).
    - **working_dir :** Définit le répertoire de travail à l'intérieur du
      conteneur sur `/app`.
    - **volumes :** Mappe le répertoire courant sur l'hôte vers `/app` dans le
      conteneur, permettant aux modifications de code d'être reflétées sans
      reconstruire l'image.
    - **ports :** Mappe le port 3000 sur l'hôte vers le port 3000 dans le
      conteneur.
    - **command :** Exécute la commande `npm start` pour démarrer l'application.
  - **database :**
    - **image :** Spécifie l'image Docker à utiliser pour ce service
      (`mongo:4.2`).
    - **ports :** Mappe le port 27017 sur l'hôte vers le port 27017 dans le
      conteneur.

## Fonctionnalités Additionnelles de Docker Compose

#### Mises à Jour en Temps Réel avec `docker compose watch`

Lors du développement avec Docker, vous pourriez avoir besoin de mettre à jour
automatiquement et de prévisualiser vos services en cours d'exécution lorsque
vous modifiez et sauvegardez votre code. La commande `docker compose watch` vous
aide dans cette tâche.

**1. Exécuter l'Application en Mode Watch :**

```sh
docker compose watch
```

**Explication :** Cette commande surveille les changements dans votre code
source et redémarre automatiquement les services affectés.

**2. Effectuer des Changements en Temps Réel :**

Modifiez le texte à la ligne 18 de `app/views/todos.ejs` pour voir vos
changements en temps réel.

**Explication :** Modifier le code dans votre répertoire de projet déclenchera
un redémarrage du service pertinent, reflétant les modifications immédiatement.

**3. Arrêter le Mode Watch :**

Utilisez `Ctrl + C` pour arrêter le mode watch.

**Explication :** Ce raccourci clavier interrompt la commande watch, l'empêchant
de continuer à s'exécuter.

## Gestion de Votre Ensemble d'Applications

Avoir votre configuration stockée dans un fichier Compose facilite la gestion de
votre ensemble d'applications.

**2. Supprimer et Redémarrer l'Application :**

Sélectionnez simplement l'ensemble d'applications dans Docker Desktop, puis
sélectionnez Supprimer. Pour redémarrer, exécutez à nouveau `docker compose up`
dans le dossier du projet. Notez que lorsque le conteneur db est supprimé,
toutes les todos créées sont également perdues.

**Explication :** Docker Desktop offre une interface graphique pour gérer vos
conteneurs. Supprimer et redémarrer l'ensemble à l'aide des commandes Docker
Compose assure un état propre.

## Exemple : Configuration d'une Application Web Simple avec Docker Compose

Créons un exemple de base en utilisant Docker Compose pour exécuter une
application web avec un service frontend et backend.

**1. Installer Docker Compose :**

Docker Compose est généralement inclus avec Docker Desktop pour Windows et
macOS. Pour les utilisateurs Linux, vous pouvez suivre les instructions
d'installation de la
[documentation officielle Docker](https://docs.docker.com/compose/install/).

**2. Créer un Fichier YAML Docker Compose :**

Créez un fichier nommé `docker-compose.yml` dans votre répertoire de projet. Ce
fichier définira les services, réseaux et volumes pour votre application.

```yaml
version: '3.8' # Utilisez la dernière version de la syntaxe Compose

services:
  frontend:
    image: nginx:latest
    ports:
      - '8080:80'
    volumes:
      - ./frontend:/usr/share/nginx/html
    networks:
      - app-network

  backend:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: myapp
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - app-network

networks:
  app-network:

volumes:
  db-data:
```

**Explication :**

- `version` : Spécifie le format du fichier Docker Compose.
- `services` : Définit les conteneurs qui composent votre application
  (`frontend` et `backend` dans cet exemple).
- `frontend` :
  - `image` : Spécifie l'image Docker à utiliser (nginx dans ce cas).
  - `ports` : Mappe le port 8080 sur l'hôte vers le port 80 à l'intérieur du
    conteneur.
  - `volumes` : Monte le répertoire `./frontend` sur l'hôte vers
    `/usr/share/nginx/html` dans le conteneur.
  - `networks` : Attache le conteneur au réseau `app-network`.
- `backend` : -

`image` : Spécifie l'image Docker pour le service backend (mysql:5.7). -
`environment` : Définit les variables d'environnement requises par MySQL. -
`volumes` : Montre un volume nommé `db-data` pour stocker de manière persistante
les données MySQL. - `networks` : Attache le conteneur au réseau `app-network`.

- `networks` : Définit un réseau nommé `app-network` pour la communication entre
  les services.
- `volumes` : Définit un volume nommé `db-data` pour le stockage persistant des
  données MySQL.

**3. Exécuter Votre Application Docker Compose :**

Ouvrez un terminal ou une invite de commandes dans votre répertoire de projet où
se trouve `docker-compose.yml`, et exécutez la commande suivante :

```sh
docker-compose up -d
```

**Explication :**

- `docker-compose up` : Construit, (re)crée, démarre et attache aux conteneurs
  pour un service.
- `-d` : Exécute les conteneurs en mode détaché (en arrière-plan).

**4. Accéder à Votre Application :**

Le service frontend (nginx) sera accessible à `http://localhost:8080` dans votre
navigateur web.

**Explication :** Le service `frontend` mappe le port 80 dans le conteneur sur
le port 8080 de votre machine hôte, rendant l'application accessible via
`http://localhost:8080`.

**5. Arrêter et Supprimer les Conteneurs :**

Pour arrêter et supprimer les conteneurs créés par `docker-compose up`, utilisez
la commande suivante :

```sh
docker-compose down
```

**Explication :** Cette commande arrête et supprime les conteneurs, réseaux,
volumes et images créés par `docker-compose up`.

## Résumé

Docker Compose simplifie le processus de gestion des applications Docker à
plusieurs conteneurs en vous permettant de les définir et de les exécuter.

Si cela vous intéresse, vous pouvez également consulter l'un des
[fichiers de configuration des workflows GitHub Actions du Club Cédille](https://github.com/ClubCedille/point-virgule/blob/master/.github/workflows/main.yml).
GitHub Actions est un service CI/CD fourni par GitHub, qui vous permet
d'automatiser la construction, le test et le déploiement de votre code.
