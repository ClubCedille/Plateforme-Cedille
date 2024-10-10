# Cas Pratiques : DevOps avec GitHub Actions

GitHub Actions est un outil puissant pour implémenter des pipelines CI/CD dans un environnement DevOps. Il permet d'automatiser l'intégralité du cycle de vie du développement, incluant le build, les tests, le déploiement, et l'intégration avec des services de cloud et des conteneurs Docker. Ce guide présente des cas pratiques détaillés pour mettre en œuvre des pipelines CI/CD robustes en utilisant GitHub Actions, Docker, et AWS.

---

## 1. Déploiement d’une Application Node.js avec Docker et GitHub Actions

Dans ce cas pratique, nous allons voir comment automatiser le déploiement d'une application Node.js conteneurisée à l'aide de Docker et GitHub Actions.

### 1.1. Préparer le Dockerfile

Commencez par créer un fichier `Dockerfile` pour conteneuriser l'application Node.js.

#### Exemple de Dockerfile :

```dockerfile
# Utiliser une image Node.js de base
FROM node:14

# Créer un répertoire de travail dans le conteneur
WORKDIR /app

# Copier package.json et installer les dépendances
COPY package*.json ./
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Exposer le port de l'application
EXPOSE 3000

# Démarrer l'application
CMD ["npm", "start"]
```

### 1.2. Créer un Workflow GitHub Actions pour Build et Déploiement

Ensuite, configurez GitHub Actions pour automatiser la création et le déploiement de cette application sur un serveur ou un service Docker. Le workflow suivant va construire l'image Docker et la pousser dans le **GitHub Container Registry** (GHCR).

#### Exemple de Workflow : Build et Push Docker Image

```yaml
name: Build and Deploy Node.js Docker App

on:
  push:
    branches:
      - main  # Déclenche le workflow uniquement sur les pushes vers la branche 'main'

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Authentification à GitHub Container Registry (GHCR)
      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      # Étape 3 : Construire l'image Docker
      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/node-app:latest .

      # Étape 4 : Pousser l'image vers GHCR
      - name: Push Docker image to GitHub Container Registry
        run: docker push ghcr.io/${{ github.repository }}/node-app:latest
```

### 1.3. Déploiement de l'Application

Vous pouvez maintenant déployer l'image Docker sur un serveur de production ou un service comme **Docker Swarm**, **Kubernetes**, ou **AWS ECS**.

---

## 2. CI/CD pour une Application Python Hébergée sur AWS avec Intégration Docker

Dans ce cas, nous allons mettre en place un pipeline CI/CD pour une application Python conteneurisée, hébergée sur **AWS Elastic Beanstalk**, en intégrant Docker dans le processus.

### 2.1. Préparer le Dockerfile pour l'Application Python

Créez un fichier `Dockerfile` pour conteneuriser l'application Python. Cet exemple montre un Dockerfile pour une application Flask.

#### Exemple de Dockerfile :

```dockerfile
# Utiliser une image Python de base
FROM python:3.9

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier requirements.txt et installer les dépendances
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copier le reste du code source
COPY . .

# Exposer le port de l'application
EXPOSE 5000

# Démarrer l'application Flask
CMD ["python", "app.py"]
```

### 2.2. Configurer un Workflow GitHub Actions pour AWS Elastic Beanstalk

Le workflow suivant est conçu pour construire l'image Docker et la déployer automatiquement sur AWS Elastic Beanstalk.

#### Exemple de Workflow : Build et Déploiement sur AWS Elastic Beanstalk

```yaml
name: Build and Deploy to AWS Elastic Beanstalk

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Authentification AWS
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      # Étape 3 : Construire l'image Docker
      - name: Build Docker image
        run: docker build -t my-python-app:latest .

      # Étape 4 : Déployer l'application sur Elastic Beanstalk
      - name: Deploy to Elastic Beanstalk
        run: |
          zip -r app.zip .
          aws elasticbeanstalk create-application-version --application-name MyPythonApp --version-label latest --source-bundle S3Bucket=my-app-bucket,S3Key=app.zip
          aws elasticbeanstalk update-environment --environment-name MyPythonApp-env --version-label latest
```

---

## 3. Automatisation d’une Chaîne DevOps Complète : Tests, Build, Déploiement

Ce cas pratique montre comment configurer une chaîne DevOps complète, incluant les tests, la construction, et le déploiement automatisés d'une application.

### 3.1. Workflow Complet avec Tests Unitaires, Build et Déploiement

Le workflow suivant automatise l'intégralité du processus de tests, de build, et de déploiement pour une application Node.js hébergée sur **Heroku**.

#### Exemple de Workflow Complet :

```yaml
name: CI/CD Pipeline for Node.js App

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Installer les dépendances
      - name: Install dependencies
        run: npm install

      # Étape 3 : Exécuter les tests unitaires
      - name: Run unit tests
        run: npm test

  build:
    runs-on: ubuntu-latest
    needs: test  # Exécute ce job après le job 'test'

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Construire l'application
      - name: Build application
        run: npm run build

  deploy:
    runs-on: ubuntu-latest
    needs: build  # Exécute ce job après le job 'build'

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Authentification Heroku
      - name: Login to Heroku
        run: echo "${{ secrets.HEROKU_API_KEY }}" | docker login --username=_ --password-stdin registry.heroku.com

      # Étape 3 : Déployer l'image sur Heroku
      - name: Deploy to Heroku
        run: |
          docker build -t registry.heroku.com/my-app/web .
          docker push registry.heroku.com/my-app/web
          heroku container:release web --app my-app
```

#### Explication :
- **Tests** : Ce workflow exécute les tests unitaires à l'aide de `npm test`.
- **Build** : Une fois les tests réussis, l'application est construite avec `npm run build`.
- **Déploiement** : Si le build réussit, l'application est déployée sur Heroku en utilisant des images Docker.

### 3.2. Notification de Succès ou Échec

Vous pouvez ajouter des notifications Slack pour alerter l’équipe en cas de succès ou d'échec du pipeline CI/CD.

#### Exemple : Notification Slack après Build

```yaml
name: CI/CD Pipeline with Slack Notifications

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Installer les dépendances
      - name: Install dependencies
        run: npm install

      # Étape 3 : Construire l'application
      - name: Build application
        run: npm run build

      # Étape 4 : Déployer l'application
      - name: Deploy application
        run: ./deploy.sh

  notify:
    runs-on: ubuntu-latest


    needs: build-and-deploy

    steps:
      - name: Send Slack notification on success
        if: success()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build succeeded for ${{ github.repository }}!"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: Send Slack notification on failure
        if: failure()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build failed for ${{ github.repository }}!"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}
```

---

## 4. Exemple de Collaboration avec des Équipes : Organisations et Équipes GitHub

Dans un environnement DevOps, il est crucial de collaborer efficacement au sein des équipes et des organisations sur GitHub.

### 4.1. Gestion des Équipes GitHub

GitHub permet de gérer des équipes au sein d'une organisation. Cela permet de :
- **Définir des permissions** : Vous pouvez attribuer des rôles d'accès spécifiques (lecture, écriture, admin) à différents membres ou équipes.
- **Partager des secrets** : Les secrets à l’échelle de l’organisation peuvent être utilisés dans plusieurs dépôts, facilitant la gestion de l'authentification partagée pour des services externes (comme AWS, Docker, etc.).

### 4.2. Exemple de Workflow Partagé entre Plusieurs Dépôts

Vous pouvez créer des workflows réutilisables au niveau de l’organisation pour les partager entre plusieurs dépôts.

#### Exemple : Workflow Réutilisable pour le Build

```yaml
name: Reusable Build Workflow

on: workflow_call

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Build application
        run: npm run build
```

Dans chaque dépôt, vous pouvez ensuite appeler ce workflow réutilisable pour standardiser le processus de build dans toute l’organisation.

---

## Conclusion

Ces cas pratiques montrent comment GitHub Actions peut être utilisé pour automatiser le cycle de vie DevOps complet. Que vous travailliez avec des applications Node.js, Python, Docker, ou AWS, GitHub Actions vous permet de construire des pipelines CI/CD robustes, automatisés et scalables. En intégrant les tests, les builds, les notifications, et la gestion collaborative via les équipes GitHub, vous pouvez facilement gérer et optimiser vos processus DevOps, tout en assurant une collaboration fluide au sein de votre organisation.
