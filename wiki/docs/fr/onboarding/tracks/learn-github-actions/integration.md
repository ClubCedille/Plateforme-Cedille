# Intégration avec Docker et Kubernetes dans GitHub Actions

GitHub Actions peut être utilisé pour automatiser des tâches liées à Docker et
Kubernetes, notamment la construction et la publication d'images Docker ainsi
que le déploiement de ces images dans des clusters Kubernetes. Dans cette
documentation, nous allons explorer comment utiliser GitHub Actions pour
intégrer Docker et Kubernetes dans vos pipelines CI/CD.

---

## 1. Construire et Pousser des Images Docker avec GitHub Actions

Docker est un outil de virtualisation légère qui vous permet de créer des
conteneurs pour exécuter des applications dans des environnements isolés. Avec
GitHub Actions, vous pouvez automatiser la construction de ces conteneurs, puis
les pousser vers un registre Docker (comme Docker Hub ou GitHub Container
Registry).

### Étapes pour Construire et Pousser des Images Docker

    1. **Écrire un Dockerfile**
    Le Dockerfile contient les instructions pour créer une image Docker à partir de votre projet. Voici un exemple simple de Dockerfile pour une application Node.js :

    ```dockerfile
    # Utiliser une image de base officielle Node.js
    FROM node:14

    # Définir le répertoire de travail
    WORKDIR /app

    # Copier le fichier package.json
    COPY package*.json ./

    # Installer les dépendances
    RUN npm install

    # Copier le reste des fichiers du projet
    COPY . .

    # Exposer le port de l'application
    EXPOSE 3000

    # Démarrer l'application
    CMD ["npm", "start"]
    ```

    2. **Configurer GitHub Actions pour construire et pousser l'image**

    Une fois le Dockerfile créé, vous pouvez configurer un workflow GitHub Actions pour construire l'image Docker, puis la pousser vers un registre Docker.

### Exemple de Workflow : Construction et Push d'une Image Docker

Le workflow suivant s'exécute lorsqu'une modification est poussée sur la branche
`main`. Il construit une image Docker à partir du Dockerfile et la pousse sur
Docker Hub.

```yaml
name: Build and Push Docker Image

# Déclenchement du workflow sur un push vers la branche 'main'
on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest  # Utilisation d'un environnement Ubuntu

    steps:
      # Étape 1 : Récupérer le code source du dépôt
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Connexion à Docker Hub
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}  # Stocker le nom d'utilisateur comme secret
          password: ${{ secrets.DOCKER_PASSWORD }}  # Stocker le mot de passe comme secret

      # Étape 3 : Construire l'image Docker
      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_USERNAME }}/my-app:latest .

      # Étape 4 : Pousser l'image Docker sur Docker Hub
      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_USERNAME }}/my-app:latest
```

### Explication du Workflow
- **`docker/login-action@v2`** : Cette action permet de se connecter à Docker
  Hub en utilisant un nom d'utilisateur et un mot de passe sécurisés stockés
  dans les secrets du dépôt.
- **`docker build`** : La commande construit une image Docker à partir du
  Dockerfile dans le répertoire racine du projet.
- **`docker push`** : Cette commande pousse l'image Docker vers Docker Hub.

### Utiliser GitHub Container Registry

GitHub Container Registry (GHCR) est une alternative à Docker Hub pour héberger
vos images Docker. Il est intégré à GitHub et permet de stocker et gérer vos
images conteneurisées à côté de votre code source.

#### Exemple de Workflow pour Pousser vers GitHub Container Registry (GHCR)

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
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/my-app:latest .

      - name: Push Docker image
        run: docker push ghcr.io/${{ github.repository }}/my-app:latest
```

Dans cet exemple, l'image est poussée vers le GitHub Container Registry au lieu
de Docker Hub.

---

## 2. Automatiser les Déploiements Kubernetes avec GitHub Actions

Kubernetes est un orchestrateur de conteneurs populaire utilisé pour déployer,
gérer et mettre à l'échelle des applications conteneurisées. GitHub Actions peut
être utilisé pour automatiser le déploiement d'images Docker dans un cluster
Kubernetes.

### Étapes pour Déployer sur Kubernetes avec GitHub Actions

1. **Configurer `kubectl` pour interagir avec votre cluster Kubernetes** Vous
   devez d'abord configurer GitHub Actions pour utiliser `kubectl`, l'outil de
   ligne de commande de Kubernetes, pour interagir avec votre cluster
   Kubernetes.

2. **Utiliser les Secrets pour Stocker les Informations Sensibles** Vous devrez
   stocker des informations comme les identifiants du cluster Kubernetes et les
   certificats dans les secrets GitHub pour les utiliser de manière sécurisée.

### Exemple de Workflow : Déploiement Automatisé sur Kubernetes

Le workflow suivant utilise `kubectl` pour déployer l'image Docker sur un
cluster Kubernetes après avoir été poussée vers Docker Hub.

```yaml
name: Deploy to Kubernetes

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Récupérer le code source du dépôt
      - name: Checkout code
        uses: actions/checkout@v2

      # Étape 2 : Installer kubectl
      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'latest'

      # Étape 3 : Configurer l'accès au cluster Kubernetes
      - name: Set up kubeconfig
        run: |
          mkdir -p ~/.kube
          echo "${{ secrets.KUBECONFIG }}" > ~/.kube/config

      # Étape 4 : Mettre à jour le déploiement Kubernetes
      - name: Deploy to Kubernetes
        run: |
          kubectl set image deployment/my-app my-app-container=${{ secrets.DOCKER_USERNAME }}/my-app:latest
```

### Explication du Workflow

- **`azure/setup-kubectl@v3`** : Cette action installe `kubectl` dans
  l'environnement de workflow.
- **`kubeconfig`** : Le fichier `kubeconfig` contient les informations
  d'authentification pour interagir avec le cluster Kubernetes. Il est stocké
  dans les secrets GitHub.
- **`kubectl set image`** : Cette commande met à jour l'image conteneurisée du
  déploiement Kubernetes.

Au sein de CEDILLE, nous utilisons des outils GitOps comme **ArgoCD** pour gérer
automatiquement nos déploiements et synchroniser nos applications avec les
clusters Kubernetes. ArgoCD simplifie l'automatisation en surveillant les dépôts
Git pour détecter les changements et les appliquer automatiquement aux clusters,
ce qui élimine le besoin de manuellement gérer ces aspects via GitHub Actions.

---

## 3. Exemples d’Utilisation de `docker`, `kubectl`, et `helm` dans des Workflows CI/CD

En combinant Docker, `kubectl`, et Helm, vous pouvez créer des workflows CI/CD
puissants pour automatiser la gestion des conteneurs et les déploiements
Kubernetes. Voici un exemple d'utilisation dans un workflow GitHub Actions qui
couvre à la fois `kubectl` et **Helm**.

### Exemple : Utilisation de Docker avec `kubectl` et Helm

Dans cet exemple, nous allons construire une image Docker, la pousser vers
Docker Hub, puis mettre à jour un déploiement Kubernetes avec cette nouvelle
image. Nous présentons aussi comment utiliser **Helm** pour gérer les
déploiements plus complexes.

#### Workflow CI/CD pour Docker et Kubernetes

```yaml
name: CI/CD for Docker and Kubernetes

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Log in to Docker Hub
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      # Étape 3 : Build Docker image
      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_USERNAME }}/my-app:latest .

      # Étape 4 : Push Docker image
      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_USERNAME }}/my-app:latest

      # Étape 5 : Set up kubectl
      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'latest'

      # Étape 6 : Deploy to Kubernetes with kubectl
      - name: Update Kubernetes Deployment with kubectl
        run: |
          kubectl set image deployment/my-app my-app-container=${{ secrets.DOCKER_USERNAME }}/my-app:latest

      # Étape 7 (optionnel) : Deploy application with Helm
      - name: Install Helm
        run: |
          curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

      - name: Deploy application with Helm
        run: helm upgrade --install my-app ./helm-chart --set image.tag=latest
```

### Explication du Workflow

1. **kubectl** : L'étape 6 met à jour l'image conteneurisée du déploiement
   Kubernetes en utilisant `kubectl`.
2. **Helm** : Les étapes 7 et suivantes montrent comment installer **Helm** et
   l'utiliser pour déployer ou mettre à jour une application Kubernetes à partir
   d'un chart Helm. Helm est particulièrement utile pour gérer des déploiements
   plus complexes en Kubernetes.
3. **Secrets** : Le fichier de configuration Kubernetes (`kubeconfig`) est
   stocké dans les secrets GitHub pour assurer la sécurité des informations
   d'authentification.

Dans ce workflow, vous pouvez choisir d'utiliser soit **kubectl** pour les
déploiements simples, soit **Helm** pour les déploiements plus
complexes. L'intégration des deux outils dans le même workflow permet de gérer
des cas d'utilisation variés selon la complexité de vos déploiements Kubernetes.

---

## Conclusion

L'intégration de Docker et Kubernetes dans vos workflows CI/CD avec GitHub
Actions simplifie la construction, le test, et le déploiement d'applications
conteneurisées. Que vous utilisiez Docker pour créer des images et Kubernetes
pour orchestrer ces conteneurs, GitHub Actions fournit les outils nécessaires
pour automatiser entièrement ces processus. Vous pouvez ainsi construire,
tester, et déployer des applications de manière fluide et sécurisée tout en
réduisant les erreurs manuelles.

En utilisant `docker`, `kubectl`, et Helm dans vos workflows, vous pouvez créer
des pipelines robustes et flexibles, adaptés à la production, aux tests, ou à
tout autre environnement Kubernetes.
