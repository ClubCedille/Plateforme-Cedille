# Déploiement Continu avec GitHub Actions

Le déploiement continu (CD) consiste à automatiser le déploiement des nouvelles
versions d'une application directement dans des environnements de production
après avoir passé les étapes de tests et de validation. GitHub Actions permet de
configurer des pipelines de déploiement continu (CD) pour des plateformes de
cloud telles qu'AWS, Azure, ou Google Cloud Platform (GCP).

---

## 1. Déployer une Application sur des Plateformes de Cloud (AWS, Azure, GCP)

GitHub Actions peut être utilisé pour automatiser le déploiement d'une
application sur des services cloud populaires tels que **AWS**, **Microsoft
Azure**, ou **Google Cloud Platform (GCP)**. Chaque fournisseur cloud a ses
propres outils et services pour gérer le déploiement des applications.

### 1.1 Déploiement sur AWS

AWS propose plusieurs services pour héberger des applications, notamment
**Elastic Beanstalk**, **ECS (Elastic Container Service)**, et **S3**. Avec
GitHub Actions, vous pouvez configurer des workflows pour déployer
automatiquement vos applications sur ces services.

#### Exemple de Workflow pour Déployer sur AWS Elastic Beanstalk

Elastic Beanstalk simplifie le déploiement et la gestion des applications sur
AWS. Voici un exemple de workflow pour déployer une application Node.js sur
Elastic Beanstalk.

```yaml
name: Deploy to AWS Elastic Beanstalk

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Configure AWS credentials
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      # Étape 3 : Déployer sur Elastic Beanstalk
      - name: Deploy to Elastic Beanstalk
        run: |
          zip -r app.zip .  # Zipper l'application
          aws elasticbeanstalk create-application-version --application-name MyApp --version-label latest --source-bundle S3Bucket=my-app-bucket,S3Key=app.zip
          aws elasticbeanstalk update-environment --environment-name MyApp-env --version-label latest
```

### 1.2 Déploiement sur Microsoft Azure

Azure propose plusieurs services pour héberger des applications, comme **Azure
App Service** et **Azure Kubernetes Service (AKS)**. Avec GitHub Actions, vous
pouvez automatiser le déploiement sur ces services en utilisant des actions
spécifiques à Azure.

#### Exemple de Workflow pour Déployer sur Azure App Service

Azure App Service est une plateforme qui permet de déployer des applications web
sur un environnement managé. Voici un exemple de workflow pour déployer une
application web sur Azure App Service.

```yaml
name: Deploy to Azure App Service

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Configurer les identifiants Azure
      - name: Log in to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      # Étape 3 : Déployer sur Azure App Service
      - name: Deploy to Azure App Service
        uses: azure/webapps-deploy@v2
        with:
          app-name: "my-app-service"
          package: .
```

### 1.3 Déploiement sur Google Cloud Platform (GCP)

Google Cloud Platform propose des services comme **Google App Engine**, **Google
Cloud Run**, et **Google Kubernetes Engine (GKE)**. GitHub Actions peut être
utilisé pour automatiser les déploiements sur GCP.

#### Exemple de Workflow pour Déployer sur Google Cloud Run

Google Cloud Run permet de déployer des applications conteneurisées directement
depuis un dépôt GitHub. Voici un exemple de workflow pour déployer une
application sur Google Cloud Run.

```yaml
name: Deploy to Google Cloud Run

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Configurer les identifiants Google Cloud
      - name: Authenticate to Google Cloud
        uses: google-github-actions/auth@v0
        with:
          credentials_json: ${{ secrets.GCP_SA_KEY }}

      # Étape 3 : Configurer Google Cloud SDK
      - name: Set up Cloud SDK
        uses: google-github-actions/setup-gcloud@v1
        with:
          project_id: ${{ secrets.GCP_PROJECT_ID }}
          service_account_key: ${{ secrets.GCP_SA_KEY }}

      # Étape 4 : Construire et déployer l'image Docker sur Cloud Run
      - name: Build and Deploy to Cloud Run
        run: |
          gcloud builds submit --tag gcr.io/${{ secrets.GCP_PROJECT_ID }}/my-app
          gcloud run deploy my-app --image gcr.io/${{ secrets.GCP_PROJECT_ID }}/my-app --region us-central1
```

---

## 2. Exemples Pratiques de Pipelines de Déploiement Continu

Les pipelines CI/CD consistent en des étapes automatisées qui prennent en charge
le build, les tests, et le déploiement d'une application. Voici quelques
exemples pratiques de pipelines de déploiement continu avec GitHub Actions.

### Pipeline de Base pour une Application Node.js Déployée sur AWS S3

```yaml
name: CI/CD Pipeline for Node.js

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

      # Étape 2 : Installer Node.js et les dépendances
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: "14"

      - name: Install dependencies
        run: npm install

      # Étape 3 : Exécuter les tests
      - name: Run tests
        run: npm test

      # Étape 4 : Construire l'application
      - name: Build application
        run: npm run build

      # Étape 5 : Se connecter à AWS
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-west-1

      # Étape 6 : Déployer l'application sur un bucket S3
      - name: Deploy to S3
        run: aws s3 sync ./build s3://my-app-bucket --delete
```

---

## 3. Stratégies de Déploiement : Blue/Green, Canary

GitHub Actions peut être utilisé pour implémenter différentes **stratégies de
déploiement**, telles que le déploiement **Blue/Green** et le déploiement
**Canary**, pour minimiser les risques lors des déploiements en production.

### 3.1 Déploiement Blue/Green

Le déploiement **Blue/Green** consiste à exécuter deux environnements
distincts : l'environnement **Blue** (ancien) et l'environnement **Green**
(nouveau). Une fois que le déploiement est prêt sur l'environnement Green, le
trafic est basculé vers cet environnement.

#### Exemple de Workflow pour un Déploiement Blue/Green

```yaml
name: Blue/Green Deployment

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 1 : Déployer sur l'environnement Green
      - name: Deploy to Green environment
        run: |
          aws deploy create-deployment \
            --application-name my-app \
            --deployment-group-name GreenEnvironment \
            --s3-location bucket=my-app-bucket,bundleType=zip,key=my-app.zip

      # Étape 2 : Basculer le trafic vers l'environnement Green
      - name: Switch traffic to Green
        run: |
          aws deploy update-deployment-group \
            --application-name my-app \
            --current-deployment-group-name BlueEnvironment \
            --new-deployment-group-name GreenEnvironment
```

### 3.2 Déploiement Canary

Le déploiement **Canary** consiste à déployer une nouvelle version à un petit
pourcentage des utilisateurs pour tester son impact. Si la version Canary est
stable, le déploiement est progressivement étendu à tous les utilisateurs.

#### Exemple de Workflow pour un Déploiement Canary

```yaml
name: Canary Deployment

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on

: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 1 : Déployer en Canary (petit pourcentage d'utilisateurs)
      - name: Deploy Canary release
        run: |
          aws deploy create-deployment \
            --application-name my-app \
            --deployment-group-name CanaryEnvironment \
            --s3-location bucket=my-app-bucket,bundleType=zip,key=my-app.zip \
            --deployment-config-name CodeDeployDefault.OneAtATime

      # Étape 2 : Augmenter progressivement le déploiement
      - name: Gradually increase deployment
        run: |
          aws deploy create-deployment \
            --application-name my-app \
            --deployment-group-name ProductionEnvironment \
            --s3-location bucket=my-app-bucket,bundleType=zip,key=my-app.zip
```

---

## 4. Notifications sur le Statut du Déploiement (Slack, Email)

GitHub Actions permet d'envoyer des notifications sur le statut d'un déploiement
réussi ou échoué via **Slack**, **Email**, ou d'autres outils de collaboration.

### 4.1 Notifications Slack

Vous pouvez configurer GitHub Actions pour envoyer des notifications via Slack
lorsque des événements spécifiques se produisent, comme l'achèvement d'un
déploiement.

#### Exemple de Workflow avec Notification Slack

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
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build application
        run: npm run build

      - name: Deploy to production
        run: ./deploy.sh

  notify:
    runs-on: ubuntu-latest
    needs: build-and-deploy
    steps:
      - name: Send Slack Notification
        uses: rtCamp/action-slack-notify@v2
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
          SLACK_MESSAGE: "The deployment to production was successful!"
```

### 4.2 Notifications par Email

Vous pouvez également configurer des notifications par email en utilisant des
actions GitHub ou des services tiers pour envoyer des emails après le
déploiement.

#### Exemple de Workflow avec Notification par Email

```yaml
name: CI/CD Pipeline with Email Notifications

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build application
        run: npm run build

      - name: Deploy to production
        run: ./deploy.sh

  notify:
    runs-on: ubuntu-latest
    needs: build-and-deploy
    steps:
      - name: Send Email Notification
        uses: dawidd6/action-send-mail@v2
        with:
          server_address: smtp.gmail.com
          server_port: 465
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: "Deployment Status"
          body: "The deployment was successful."
          to: "recipient@example.com"
```

---

## Conclusion

Le déploiement continu avec GitHub Actions permet de simplifier et d'automatiser
le processus de mise en production de vos applications. Grâce à l'intégration
avec des plateformes cloud comme AWS, Azure, et GCP, ainsi qu'à l'utilisation de
stratégies de déploiement telles que Blue/Green ou Canary, vous pouvez réduire
les risques de déploiement et assurer une livraison continue. De plus, la
possibilité d'envoyer des notifications via Slack ou Email améliore la
visibilité sur l'état des déploiements et permet aux équipes de réagir
rapidement en cas de problèmes.

GitHub Actions offre une grande flexibilité pour automatiser l'ensemble de votre
pipeline de déploiement, et vous permet d'optimiser la manière dont vous gérez
la livraison de vos applications.
