# Bonnes Pratiques et Patterns DevOps avec GitHub

L'adoption des bonnes pratiques et des patterns DevOps est essentielle pour
garantir des pipelines CI/CD robustes, évolutifs et efficaces dans les projets
complexes. GitHub Actions, avec ses fonctionnalités d’automatisation, permet de
structurer les workflows, de gérer plusieurs environnements, et de faciliter la
collaboration d’équipe. Ce guide propose des stratégies et des pratiques
exemplaires pour structurer les workflows, centraliser les configurations, gérer
les environnements de développement, et collaborer efficacement via GitHub
Actions.

---

## 1. Structurer les Workflows pour des Projets Complexes

Dans les projets complexes, il est essentiel de structurer vos workflows pour
garantir un cycle de vie CI/CD fluide et facile à maintenir. Cela inclut la
division des workflows en étapes spécifiques, la réutilisation des workflows et
la gestion des dépendances entre les jobs.

### 1.1. Diviser les Workflows en Étapes Claires

Il est recommandé de diviser un workflow en plusieurs **jobs** et **steps**, en
attribuant des responsabilités spécifiques à chaque job, telles que les tests,
le build, ou le déploiement. Chaque job peut être exécuté de manière parallèle
ou dépendante, ce qui permet de gagner en flexibilité.

#### Exemple de Workflow Structuré

```yaml
name: Complex Workflow

on:
  push:
    branches:
      - main

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run linter
        run: npm run lint

  test:
    runs-on: ubuntu-latest
    needs: lint  # Le job 'test' dépend de 'lint'
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run unit tests
        run: npm test

  build:
    runs-on: ubuntu-latest
    needs: test  # Le job 'build' dépend de 'test'
    steps:
      - name: Build application
        run: npm run build

  deploy:
    runs-on: ubuntu-latest
    needs: build  # Le job 'deploy' dépend de 'build'
    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

#### Explication
- **Jobs dépendants** : Les jobs `test`, `build`, et `deploy` sont dépendants
  des jobs précédents. Cela assure qu’aucune étape de déploiement ne se fait
  avant la validation des tests ou du build.
- **Modularité** : Chaque job a un rôle précis, ce qui rend le workflow plus
  lisible et plus facile à maintenir.

### 1.2. Modularisation des Workflows

GitHub Actions permet d’appeler un workflow depuis un autre via
`workflow_call`. Modulariser les workflows permet de réutiliser certaines
parties du pipeline (tests, builds, etc.) dans différents projets, assurant
ainsi une consistance dans la gestion des pipelines CI/CD à l'échelle de
l'organisation.

#### Exemple de Workflow Réutilisable

```yaml
# .github/workflows/tests.yml
name: Reusable Tests Workflow

on: workflow_call

jobs:
  run-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

```yaml
# .github/workflows/main.yml
name: Main Workflow

on:
  push:
    branches:
      - main

jobs:
  tests:
    uses: ./.github/workflows/tests.yml  # Réutiliser le workflow de tests
```

### 1.3. Utiliser les Matrices pour Optimiser les Exécutions

L'utilisation de **matrices** permet de tester différentes combinaisons
d'environnements (OS, versions de langage, etc.) en parallèle, réduisant ainsi
le temps total d'exécution du pipeline.

#### Exemple d’Utilisation de Matrice

```yaml
name: Matrix Build

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
        node-version: [12, 14, 16]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

---

## 2. Utiliser des Fichiers de Configuration Centralisés

Pour les projets complexes, il est souvent utile de centraliser la configuration
des workflows afin d’assurer la cohérence entre différents pipelines et éviter
la duplication.

### 2.1. Centraliser les Secrets et Variables

GitHub offre la possibilité de gérer les **secrets** et les **variables
d’environnement** au niveau de l’organisation ou du dépôt. Cela permet de
stocker des informations sensibles comme des clés API ou des identifiants dans
un emplacement centralisé et sécurisé.

#### Exemple : Utilisation de Secrets dans un Workflow

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Deploy to AWS
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        run: ./deploy.sh
```

### 2.2. Fichiers de Configuration Partagés

GitHub Actions permet de créer des fichiers YAML de configuration partagée, ce
qui permet de standardiser les processus CI/CD dans plusieurs projets. Ces
fichiers peuvent inclure des scripts communs ou des workflows réutilisables pour
différentes équipes ou dépôts.

#### Exemple : Utilisation d'un Fichier Central de Configuration

```yaml
# .github/workflows/shared-config.yml
name: Shared Config

on:
  workflow_call

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Install dependencies
        run: npm install
```

---

## 3. Développement de Logiciels en Équipe avec GitHub Actions (PR Gating, Checks)

GitHub Actions facilite la collaboration au sein des équipes de développement en
automatisant les vérifications et en intégrant des contrôles sur les pull
requests.

### 3.1. Mise en Place de PR Gating

Le **PR gating** consiste à empêcher la fusion de code dans une branche sans que
certains tests ou checks aient été exécutés avec succès. Vous pouvez configurer
des **checks obligatoires** qui doivent être validés avant de fusionner une pull
request.

#### Exemple : Workflow pour Valider une PR

```yaml
name: PR Validation

on:
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install



      - name: Run tests
        run: npm test
```

### 3.2. Checks Automatiques sur les Pull Requests

GitHub permet de configurer des **checks** automatiques sur les pull requests,
comme l'exécution de tests ou des vérifications de style de code.

### 3.3. Politique de Branches Protégées

Il est recommandé de protéger les branches critiques (comme `main` ou
`production`) en configurant des **branches protégées**, qui empêchent les
commits directs ou exigent l'exécution de workflows spécifiques avant la fusion.

#### Exemple : Protéger la Branche `main`

1. Accédez aux **Settings** du dépôt.
2. Allez dans **Branches**.
3. Ajoutez une règle de branche pour `main`.
4. Cochez l’option **Require status checks to pass before merging**.

---

## Conclusion

L'application de bonnes pratiques et de patterns DevOps avec GitHub Actions
permet de structurer efficacement vos workflows CI/CD, centraliser les
configurations et secrets, gérer plusieurs environnements, et collaborer de
manière fluide au sein d'une équipe. L'utilisation d'outils comme les
environnements, les workflows réutilisables, les branches protégées, et les
checks de pull requests permet de construire des pipelines robustes et évolutifs
pour des projets complexes tout en assurant la qualité et la sécurité du code.
