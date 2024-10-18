# Utiliser GitHub Container Registry (GHCR)

GitHub Container Registry (GHCR) est une fonctionnalité de GitHub Packages qui permet de stocker et gérer des images de conteneurs Docker aux côtés de vos projets GitHub. Le GHCR s’intègre parfaitement aux workflows CI/CD avec GitHub Actions, facilitant ainsi la création, le stockage, et le déploiement d’images Docker dans vos projets.

---

## 1. Introduction à GitHub Container Registry

GitHub Container Registry (GHCR) est un service de registre de conteneurs intégré à GitHub. Il permet aux développeurs de gérer des images de conteneurs Docker directement dans leurs dépôts GitHub. GHCR est conçu pour offrir plus de flexibilité dans la gestion des permissions, la visibilité des images et l'intégration avec les workflows GitHub Actions.

### Exemple : Registre de Conteneurs de Cédille

Pour un exemple concret de l'utilisation de GHCR, vous pouvez consulter le [registre de conteneurs du Club Cédille](https://github.com/orgs/ClubCedille/packages). Ce registre contient des images de conteneurs que le club utilise pour ses projets, intégrées aux workflows CI/CD et gérées directement via GitHub Actions.

### Caractéristiques Principales de GHCR

- **Stockage centralisé** : Le GHCR permet de stocker des images Docker aux côtés du code source de votre projet, simplifiant ainsi la gestion des versions et des déploiements.
- **Permissions flexibles** : Les images peuvent être privées, publiques ou contrôlées par des permissions personnalisées pour les utilisateurs et les équipes.
- **Intégration avec GitHub Actions** : Le GHCR s'intègre directement avec les workflows CI/CD de GitHub Actions, ce qui permet d'automatiser la création et le déploiement des images Docker.
- **Support de Docker et OCI** : GHCR prend en charge les images conformes aux normes Docker et Open Container Initiative (OCI).

---

Voici comment vous pouvez intégrer cet exemple utilisé dans vos projets dockerisés dans la section sur **Pousser et Tirer des Images de Conteneurs dans GitHub Container Registry** :

## 2. Pousser et Tirer des Images de Conteneurs dans GitHub Container Registry

Le GitHub Container Registry permet aux utilisateurs de **pousser** (uploader) et **tirer** (download) des images Docker à partir de leurs projets GitHub, de manière similaire à d'autres registres Docker tels que Docker Hub.

### Exemple : Workflow de Build et Push d'une Image Docker vers GHCR

Dans les projets du Club Cédille, nous utilisons des workflows pour automatiser la construction et la publication d'images Docker dans le GitHub Container Registry. Voici un exemple concret du fichier [build-push-ghcr.yaml](https://github.com/ClubCedille/cedille-workflows/blob/master/.github/workflows/build-push-ghcr.yaml) utilisé pour construire et pousser des conteneurs Docker.


### Explication du Workflow [build-push-ghcr.yaml](https://github.com/ClubCedille/cedille-workflows/blob/master/.github/workflows/build-push-ghcr.yaml) :
- **workflow_call** : Ce workflow est conçu pour être réutilisé par d'autres workflows, permettant de spécifier le nom du conteneur, le contexte Docker, et le fichier Dockerfile.
- **Docker Buildx** : Utilisé pour construire des images multi-plateformes (par exemple, amd64, arm64).
- **Cache des couches Docker** : Les couches Docker sont mises en cache pour accélérer les builds.
- **Pousser les images Docker** : Les images sont poussées vers le registre GitHub (GHCR) avec des tags basés sur le commit ou la branche PR, et un tag `latest` est ajouté si le push se fait sur la branche `main` ou `master`.

Cet exemple montre comment le Club Cédille utilise GHCR pour gérer les images Docker de manière automatisée, avec des workflows CI/CD robustes.

### 2.1. Authentification à GitHub Container Registry

Pour interagir avec GHCR, vous devez vous authentifier auprès de GitHub en utilisant un jeton d'accès personnel (PAT). Ce jeton doit avoir les permissions suivantes :
- `read:packages`
- `write:packages`
- `delete:packages` (si vous souhaitez supprimer des images)
- `repo` (si vous poussez des images vers des dépôts privés)

#### Création d’un Jeton d’Accès Personnel (PAT)

1. Allez dans vos **Settings** GitHub.
2. Sous **Developer settings**, cliquez sur **Personal access tokens**.
3. Créez un nouveau jeton avec les permissions mentionnées ci-dessus.

### 2.2. Pousser une Image Docker vers GitHub Container Registry

Pour pousser une image Docker dans le GHCR, vous devez suivre les étapes suivantes :

#### 1. Connexion à GitHub Container Registry

Utilisez la commande Docker suivante pour vous authentifier auprès de GHCR à l’aide de votre jeton d’accès personnel (PAT) :

```bash
echo $GHCR_PAT | docker login ghcr.io -u <github-username> --password-stdin
```

- **`$GHCR_PAT`** est votre jeton d’accès personnel (PAT).
- **`<github-username>`** est votre nom d'utilisateur GitHub.

#### 2. Construire une Image Docker

Créez une image Docker à partir de votre projet. Par exemple, si vous avez un `Dockerfile` dans le répertoire racine de votre projet :

```bash
docker build -t ghcr.io/<github-username>/<image-name>:<tag> .
```

- **`<github-username>`** : Votre nom d’utilisateur GitHub.
- **`<image-name>`** : Le nom de l’image Docker.
- **`<tag>`** : Un tag pour identifier la version de l’image (ex : `v1.0`, `latest`).

#### 3. Pousser l'Image Docker vers GHCR

Une fois l’image construite, utilisez la commande suivante pour la pousser vers GHCR :

```bash
docker push ghcr.io/<github-username>/<image-name>:<tag>
```

### 2.3. Tirer une Image Docker depuis GitHub Container Registry

Pour tirer une image Docker stockée dans GHCR, vous devez d’abord vous authentifier, puis exécuter la commande de tirage (pull).

#### 1. Authentification

Si vous n'êtes pas encore connecté à GHCR, vous pouvez vous authentifier comme suit :

```bash
echo $GHCR_PAT | docker login ghcr.io -u <github-username> --password-stdin
```

#### 2. Tirer l'Image Docker

Utilisez la commande `docker pull` pour télécharger une image depuis GHCR :

```bash
docker pull ghcr.io/<github-username>/<image-name>:<tag>
```

---

## 3. Intégration des Images avec les Workflows GitHub Actions

GitHub Actions s'intègre parfaitement avec GitHub Container Registry, vous permettant de créer des workflows CI/CD qui incluent la construction, le test, et le déploiement automatisé d'images Docker.

### Exemple de Workflow pour Construire et Pousser une Image Docker vers GHCR

Voici un exemple de workflow GitHub Actions qui construit une image Docker à partir d’un dépôt, puis la pousse automatiquement dans le GHCR.

```yaml
name: Build and Push Docker Image to GHCR

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Authentification à GHCR
      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      # Étape 3 : Construire l'image Docker
      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/my-app:latest .

      # Étape 4 : Pousser l'image vers GHCR
      - name: Push Docker image to GHCR
        run: docker push ghcr.io/${{ github.repository }}/my-app:latest
```

### Explication des Étapes :

1. **Checkout repository** : Cette étape récupère le code source du dépôt.
2. **Log in to GitHub Container Registry** : Se connecte à GHCR en utilisant le jeton d'accès GitHub (`GITHUB_TOKEN`).
3. **Build Docker image** : Construit une image Docker à partir du Dockerfile dans le répertoire racine du projet.
4. **Push Docker image to GHCR** : Pousse l'image Docker construite vers GHCR, en utilisant le chemin `ghcr.io/<organization-or-username>/<image-name>`.

### Exemple de Workflow pour Tirer une Image et Déployer avec Docker

Voici un exemple de workflow GitHub Actions qui tire une image Docker depuis GHCR et la déploie sur une machine cible (par exemple, un serveur de production).

```yaml
name: Pull and Deploy Docker Image from GHCR

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Authentification à GHCR
      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      # Tirer l'image Docker
      - name: Pull Docker image from GHCR
        run: docker pull ghcr.io/${{ github.repository }}/my-app:latest

      # Démarrer le conteneur Docker
      - name: Run Docker container
        run: docker run -d -p 8080:80 ghcr.io/${{ github.repository }}/my-app:latest
```

---

## 4. Contrôle d’Accès et Permissions sur les Registres

L'un des avantages majeurs de GitHub Container Registry est la gestion fine des **permissions d'accès**. Vous pouvez contrôler qui a accès à vos images de conteneurs, et définir des autorisations spécifiques pour chaque image ou dépôt.

### 4.1 Permissions sur les Dépôts

Les permissions pour accéder aux images hébergées dans GHCR dépendent des permissions d'accès au dépôt associé :
- **Dépôts Publics** : Les images dans les dépôts publics peuvent être consultées et tirées par tout utilisateur GitHub.
- **Dépôts Privés** : Les images dans les dépôts privés sont accessibles uniquement aux personnes ou équipes ayant les permissions appropriées sur le dépôt.

### 4.2 Permissions pour les Images Publiques et Privées

Vous pouvez définir des permissions spécifiques pour les images GHCR, indépendamment du dépôt dans lequel elles sont hébergées. Les images peuvent être :
- **Privées** : Seuls les utilisateurs ou équipes ayant reçu des accès peuvent tirer ou pousser des images.
- **Publiques** : N’importe qui peut tirer l’image.

#### Rendre une Image Publique ou Privée

1. Allez sur la page **Packages** du dépôt GitHub.
2. Sélectionnez l’image Docker que vous souhaitez modifier.
3. Cliquez sur **Package settings**.
4. Modifiez la visibilité de l'image à **Public** ou **Private**.

### 4.3 Gérer les Permissions pour les Utilisateurs et Équipes

Vous pouvez attribuer des permissions de lecture ou d'écriture sur vos images à des utilisateurs spécifiques ou à des équipes au sein de votre organisation GitHub. Cela permet de restreindre l'accès aux images sensibles, tout en facilitant la collaboration au sein de l'équipe.

#### Accorder l'Accès à un Utilisateur ou une Équipe

1. Allez dans les **Settings** du dépôt GitHub contenant l'image.
2. Sous **Manage access**, ajoutez les utilisateurs ou les équipes auxquels vous souhaitez donner accès.
3. Attribuez des rôles spécifiques (lecture, écriture, ou admin) selon le niveau d'accès souhaité.

---

## Conclusion

GitHub Container Registry (GHCR) est une solution puissante et flexible pour gérer vos images Docker directement au sein de GitHub. En vous permettant de pousser, tirer et déployer des images de conteneurs dans vos workflows CI/CD via GitHub Actions, GHCR s’intègre parfaitement dans les pipelines de développement modernes. De plus, avec ses options de contrôle d'accès avancées, vous pouvez gérer les permissions de manière granulaire, assurant ainsi la sécurité de vos images.

Avec ces outils, vous êtes désormais prêt à utiliser GHCR pour optimiser vos workflows CI/CD, améliorer la collaboration, et simplifier la gestion des images Docker.
