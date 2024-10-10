# Gestion de la Sécurité et des Permissions dans GitHub Actions

La sécurité est une composante essentielle de tout pipeline CI/CD. GitHub Actions offre des fonctionnalités intégrées pour gérer les informations sensibles, contrôler les accès aux workflows, et garantir la sécurité de vos dépendances logicielles. Dans ce document, nous allons explorer comment utiliser GitHub Secrets pour gérer les informations sensibles, définir des permissions sur les workflows et analyser les dépendances avec Dependabot.

---

## 1. Utilisation de GitHub Secrets pour Gérer les Informations Sensibles

Les secrets dans GitHub sont utilisés pour stocker des informations sensibles telles que des clés API, des mots de passe, ou des jetons d'accès, qui sont nécessaires pour vos workflows mais qui ne doivent pas être exposées dans le code source.

### 1.1. Qu'est-ce que GitHub Secrets ?

Les **GitHub Secrets** sont des variables sécurisées qui sont chiffrées et stockées par GitHub. Elles peuvent être utilisées dans vos workflows pour passer des informations sensibles sans les exposer dans les logs ou dans les fichiers de configuration. Par exemple, les secrets sont couramment utilisés pour se connecter à des services tiers comme AWS, Docker, ou Slack.

### 1.2. Créer un Secret dans GitHub

1. **Accédez aux Settings** du dépôt ou de l’organisation.
2. Sous **Secrets and variables**, cliquez sur **Actions**.
3. Sélectionnez **New repository secret** (pour un dépôt) ou **New organization secret** (pour un secret partagé entre plusieurs dépôts).
4. Entrez un nom pour le secret (par exemple, `AWS_ACCESS_KEY_ID`).
5. Entrez la valeur du secret, puis cliquez sur **Add secret**.

### 1.3. Utiliser les Secrets dans un Workflow GitHub Actions

Une fois les secrets créés, ils peuvent être utilisés dans vos workflows en les appelant avec la syntaxe `${{ secrets.NOM_DU_SECRET }}`.

#### Exemple : Utilisation de Secrets pour l'Authentification AWS

```yaml
name: Deploy to AWS

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Checkout du code source
      - name: Checkout repository
        uses: actions/checkout@v2

      # Configuration des identifiants AWS en utilisant les secrets
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      # Déploiement sur AWS
      - name: Deploy to S3
        run: aws s3 sync ./build s3://my-app-bucket
```

### 1.4. Meilleures Pratiques pour Utiliser des Secrets

- **Limiter l'accès aux secrets** : Seuls les utilisateurs ayant besoin de voir ou de gérer les secrets doivent y avoir accès.
- **Utiliser des secrets au niveau de l'organisation** : Si vous travaillez avec plusieurs dépôts, vous pouvez définir des secrets au niveau de l'organisation et les partager entre plusieurs dépôts.
- **Chiffrer les secrets** : Ne jamais inclure des informations sensibles directement dans votre code ou vos workflows. Utilisez toujours des secrets chiffrés.
- **Rotation des secrets** : Modifiez régulièrement vos secrets pour renforcer la sécurité.

---

## 2. Permissions des Workflows et Gestion des Droits d'Accès

La sécurité des workflows dans GitHub Actions repose également sur la gestion des **permissions d'accès** et des **droits d'exécution** des workflows. GitHub permet de contrôler les actions qu’un workflow peut effectuer et de limiter l'accès à certains événements et utilisateurs.

### 2.1. Permissions des Workflows

GitHub permet de configurer les **permissions par défaut** qu’un workflow peut utiliser. Vous pouvez définir des permissions pour chaque workflow ou globalement pour tout le dépôt.

#### Configurer les Permissions des Workflows

Les permissions peuvent être définies à deux niveaux :
1. **Globale (pour tout le dépôt)**.
2. **Spécifique à un workflow**.

#### 2.1.1. Permissions Globales pour un Dépôt

Vous pouvez configurer les permissions par défaut d’un dépôt sous **Settings > Actions > Workflow permissions**. Deux options principales sont disponibles :
- **Read repository content** : Limite les actions aux lectures de dépôt (option la plus sécurisée).
- **Read and write permissions** : Donne aux actions la permission de lire et de modifier le dépôt.

#### 2.1.2. Permissions dans un Workflow Spécifique

Dans un workflow spécifique, vous pouvez restreindre les permissions au niveau des **jobs** ou des **étapes** (steps).

##### Exemple : Définir les Permissions dans un Workflow

```yaml
name: Build and Deploy

on:
  push:
    branches:
      - main

permissions:
  contents: read  # Limite l'accès au dépôt en lecture seule
  packages: write  # Autorise l'écriture dans GitHub Packages

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
```

Dans cet exemple :
- Le workflow a la permission de **lire** le contenu du dépôt.
- Le workflow peut **écrire** dans GitHub Packages pour publier des artefacts ou des images Docker.

### 2.2. Contrôle des Droits d'Accès aux Workflows

Les permissions des workflows peuvent également être contrôlées par l'organisation ou les propriétaires du dépôt. Voici quelques bonnes pratiques pour sécuriser les workflows :

- **Exiger des approbations pour certains workflows** : Pour certains événements critiques (comme un déploiement en production), configurez des workflows de manière à exiger une approbation manuelle avant leur exécution.
  
#### Exemple : Exiger une Approbation Manuelle pour Déployer

```yaml
name: Production Deployment

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Await approval
        uses: actions/manual-approval@v2
        with:
          approver: "team-lead"
      - name: Deploy application
        run: ./deploy.sh
```

- **Limiter l’accès aux secrets** : N’accordez des permissions d'accès aux secrets qu’aux workflows et jobs qui en ont réellement besoin.
- **Utiliser des branches protégées** : Restreindre les exécutions automatiques de workflows sur les branches de production pour éviter des modifications non autorisées.

---

## 3. Scan de Sécurité des Dépendances avec Dependabot

Dependabot est un service intégré à GitHub qui analyse les dépendances de vos projets et identifie les vulnérabilités de sécurité. Il propose des mises à jour automatiques pour corriger ces vulnérabilités, améliorant ainsi la sécurité globale de vos applications.

### 3.1. Qu'est-ce que Dependabot ?

**Dependabot** scanne régulièrement les dépendances de vos projets et détecte les vulnérabilités connues dans les bibliothèques que vous utilisez. Lorsqu'une vulnérabilité est détectée, Dependabot crée automatiquement une **pull request** proposant une mise à jour vers une version plus sécurisée.

### 3.2. Activer Dependabot pour le Scan de Sécurité

1. Accédez aux **Settings** de votre dépôt GitHub.
2. Sous **Security & Analysis**, activez **Dependabot alerts** et **Dependabot security updates**.

GitHub scanne ensuite automatiquement les dépendances de votre projet et vous avertit en cas de vulnérabilités.

### 3.3. Mises à Jour Automatiques avec Dependabot

Dependabot peut générer automatiquement des pull requests pour mettre à jour vos dépendances lorsque des mises à jour de sécurité sont disponibles. Ces pull requests peuvent ensuite être révisées et fusionnées pour garantir que votre projet reste sécurisé.

#### Exemple : Fichier de Configuration Dependabot

Dependabot peut être configuré via un fichier `.github/dependabot.yml` qui définit les dépendances à surveiller et la fréquence de mise à jour.

```yaml
version: 2
updates:
  - package-ecosystem: "npm"  # Gérer les dépendances npm
    directory: "/"  # Répertoire contenant le fichier package.json
    schedule:
      interval: "daily"  # Vérification des mises à jour chaque jour
  - package-ecosystem: "docker"  # Gérer les images Docker
    directory: "/"  # Répertoire contenant le fichier Dockerfile
    schedule:
      interval: "weekly"  # Vérification des mises à jour chaque semaine
```

### 3.4. Analyse des Vulnérabilités dans le Code et les Dépendances

Dependabot se connecte à une base de données de vulnérabilités connues pour vérifier les packages utilisés dans vos projets. Lorsqu’une vulnérabilité est trouvée :
- Vous recevez une alerte **Dependabot alert** dans l’onglet **Security** de votre dépôt.
- Dependabot peut automatiquement créer une **pull request** pour vous proposer une mise à jour vers une version non vulnérable.

### 3.5. Suivi des Mises à Jour de Sécurité

Dependabot vous permet de :

- Suivre l’historique des vulnérabilités et des correctifs. 
- Mettre en œuvre des mises à jour automatiques pour que votre projet utilise toujours des versions sécurisées des dépendances.

---

## Conclusion

La gestion de la sécurité et des permissions dans GitHub Actions est essentielle pour garantir la confidentialité, l'intégrité et la sécurité de vos pipelines CI/CD. En utilisant GitHub Secrets, vous pouvez protéger les informations sensibles telles que les clés API et les identifiants. En configurant correctement les permissions des workflows et des accès aux secrets, vous pouvez limiter les risques de compromission. De plus, avec Dependabot, vous avez un outil puissant pour surveiller et corriger automatiquement les vulnérabilités dans vos dépendances, contribuant ainsi à renforcer la sécurité globale de vos projets.

Ces outils et pratiques vous permettent de construire des workflows robustes et sécurisés, tout en respectant les meilleures pratiques en matière de gestion de la sécurité et des permissions.
