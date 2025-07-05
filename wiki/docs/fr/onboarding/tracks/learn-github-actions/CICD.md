# Optimisation des Workflows CI/CD avec GitHub Actions

L'optimisation des workflows CI/CD est essentielle pour améliorer l'efficacité,
réduire les temps d'exécution et garantir la stabilité des pipelines de
développement. Ce guide détaillé explore différentes techniques pour accélérer
vos workflows, optimiser les pipelines CI/CD, gérer les versions des
dépendances, et résoudre les problèmes à l'aide des outils de débogage intégrés
de GitHub Actions.

---

## 1. Accélérer les Workflows : Mise en Cache des Dépendances et Réutilisation des Workflows

### 1.1. Mise en Cache des Dépendances

La mise en cache des dépendances est une méthode efficace pour réduire le temps
d'installation des bibliothèques et des modules dans vos workflows CI/CD. GitHub
Actions propose une action intégrée appelée **`cache`** qui permet de stocker
des fichiers comme des dépendances de build ou des résultats intermédiaires pour
les réutiliser lors des exécutions suivantes.

#### Exemple : Mise en Cache des Dépendances Node.js

```yaml
name: CI with Cache

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Étape 1 : Checkout du code source
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Mise en cache des dépendances npm
      - name: Cache Node.js modules
        uses: actions/cache@v2
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      # Étape 3 : Installer les dépendances
      - name: Install dependencies
        run: npm install

      # Étape 4 : Construire le projet
      - name: Build project
        run: npm run build
```

#### Explication des Étapes

- **`actions/cache@v2`** : Cette action met en cache les modules Node.js situés
  dans le répertoire `node_modules`. Le cache est basé sur la somme de contrôle
  (hash) du fichier `package-lock.json`. Si aucune modification n'est détectée
  dans ce fichier, le cache est restauré, réduisant ainsi le temps
  d'installation des dépendances.
- **`restore-keys`** : Cette option permet de restaurer le cache partiellement
  si la clé exacte n'est pas trouvée.

### 1.2. Réutilisation des Workflows

La réutilisation des workflows permet de centraliser des parties communes de
pipelines dans un fichier réutilisable, ce qui simplifie la gestion des
workflows complexes. Vous pouvez appeler un workflow à partir d'un autre
workflow pour éviter la duplication de code.

Dans nos projets, nous utilisons un dépôt dédié aux workflows réutilisables.
Vous pouvez consulter
[**cedille-workflows**](https://github.com/ClubCedille/cedille-workflows), qui
contient des exemples de workflows prêts à être réutilisés dans différents
projets. Ce dépôt permet de centraliser les définitions de workflows communs,
tels que la construction d'images Docker, les déploiements, et la gestion des
dépendances.

Voici la section mise à jour avec un exemple illustrant l'utilisation des
variables dans un workflow réutilisable :

`````markdown
#### Exemple : Appeler un Workflow Réutilisable

Dans ce cas, nous avons un workflow qui effectue des tests, et un autre qui gère
les déploiements. Ces workflows sont réutilisés à partir d'un fichier central.

`````yaml
# .github/workflows/reusable-tests.yml
name: Reusable Test Workflow

on: workflow_call

jobs:
  tests:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Run tests run: npm test ``` ````

```yaml
# .github/workflows/deploy.yml
name: Deployment Pipeline

on:
  push:
    branches:
      - main

jobs:
  call-tests:
    uses: ./.github/workflows/reusable-tests.yml

  deploy:
    needs: call-tests
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Deploy to production
        run: ./deploy.sh
`````

#### Exemple : Workflow Réutilisable avec des Variables

Vous pouvez également définir des **variables d'entrée** dans un workflow
réutilisable pour plus de flexibilité. Voici un exemple qui construit et pousse
une image Docker vers le GitHub Container Registry (GHCR) en utilisant des
variables d'entrée :

```yaml
# .github/workflows/build-push-ghcr.yml
name:
  Reusable workflow to build and push docker container to GitHub Container
  Registry

on:
  workflow_call:
    inputs:
      container-name:
        required: true
        type: string
      context:
        required: false
        type: string
        default: '.'
      file:
        required: false
        type: string
        default: 'Dockerfile'

env:
  REGISTRY: ghcr.io/clubcedille

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - name: Check Out Repo
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to the Container Registry
        uses: docker/login-action@v1
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: ${{ inputs.context }}
          file: ${{ inputs.file }}
          push: true
          tags: ${{ env.REGISTRY }}/${{ inputs.container-name }}:latest
```

#### Exemple d'Utilisation du Workflow Réutilisable

Ce workflow peut maintenant être appelé à partir d'un autre workflow, tout en
passant des variables personnalisées pour adapter le comportement :

```yaml
# .github/workflows/deploy-with-docker.yml
name: Deployment with Docker

on:
  push:
    branches:
      - main

jobs:
  deploy:
    uses: ./.github/workflows/build-push-ghcr.yml
    with:
      container-name: my-app
      context: ./my-app-directory
```

#### Explication

- **`workflow_call`** : Permet de réutiliser le workflow en appelant des
  workflows définis ailleurs. Les variables d'entrée permettent de personnaliser
  le comportement du workflow réutilisable.
- **Variables d'entrée (`inputs`)** : Les variables comme `container-name`,
  `context`, et `file` définissent des valeurs spécifiques pour chaque appel du
  workflow. Cela permet de construire et pousser différentes images Docker sans
  modifier le workflow de base.
- **Réduction de la duplication** : L'utilisation des variables dans les
  workflows réutilisables permet de centraliser des tâches communes tout en
  adaptant leur exécution à des besoins spécifiques, simplifiant ainsi la
  maintenance des pipelines CI/CD.

---

## 2. Stratégies d’Optimisation des Pipelines (Job Matrix, Jobs Dépendantiels)

### 2.1. Job Matrix

La **job matrix** est une fonctionnalité puissante de GitHub Actions qui permet
d'exécuter plusieurs combinaisons de configurations en parallèle. Cela est
particulièrement utile pour tester votre application sur plusieurs versions de
langage, environnements, ou systèmes d'exploitation.

#### Exemple : Job Matrix avec Node.js

```yaml
name: Node.js CI

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12, 14, 16]
        os: [ubuntu-latest, windows-latest, macos-latest]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v2
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

#### Explication

- **`matrix.node-version`** et **`matrix.os`** : Ces deux matrices permettent de
  tester sur différentes versions de Node.js (`12`, `14`, `16`) et sur
  différents systèmes d'exploitation (`ubuntu`, `windows`, `macos`).
- **Exécution parallèle** : GitHub Actions exécute toutes les combinaisons de la
  matrice en parallèle, ce qui réduit considérablement le temps d’exécution
  total pour les tests multi-environnement.

### 2.2. Jobs Dépendantiels

Les jobs dépendantiels permettent de définir des relations de dépendance entre
les jobs, c'est-à-dire qu'un job peut attendre qu'un autre soit terminé avec
succès avant de commencer.

#### Exemple : Dépendance entre Jobs

```yaml
name: Build and Deploy

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build application
        run: npm run build

  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Run tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

#### Explication

- **`needs`** : L’instruction `needs` permet de définir une dépendance entre
  jobs. Dans cet exemple, le job `test` ne démarre que lorsque le job `build` a
  réussi. De même, le job `deploy` attend que `test` se termine.

---

## 3. Gérer les Versions des Dépendances et des Actions

Une bonne gestion des versions des dépendances et des actions dans vos workflows
permet d'assurer la stabilité et de prévenir les erreurs dues aux changements
inattendus des bibliothèques ou des actions utilisées.

### 3.1. Gérer les Versions des Actions

Lorsque vous utilisez une action dans un workflow GitHub Actions, il est
important de spécifier une version spécifique pour garantir que votre workflow
reste stable même si l'action est mise à jour dans le futur.

#### Exemple : Utilisation d'une Version Spécifique d'une Action

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2.3.4 # Utilisation d'une version spécifique
```

### 3.2. Gérer les Versions des Dépendances

Il est également recommandé de verrouiller les versions des dépendances
utilisées dans votre projet (par exemple dans `package-lock.json` ou
`requirements.txt`). Cela garantit que chaque exécution du workflow utilise les
mêmes versions de bibliothèques, minimisant les erreurs dues à des mises à jour
non testées.

#### Exemple : Dépendances Verrouillées dans `package-lock.json`

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm ci # Installe les dépendances avec les versions verrouillées dans package-lock.json
```

---

## 4. Debugging des Workflows GitHub Actions

Lorsqu'un workflow échoue ou se comporte de manière inattendue, il est important
d’avoir les bons outils pour diagnostiquer et résoudre le problème rapidement.

### 4.1. Activer les Logs Détaillés

GitHub Actions permet d'activer des logs détaillés pour aider à diagnostiquer
les erreurs. Cela peut être utile si un job échoue sans fournir suffisamment
d'informations dans les logs standards.

#### Activer les Logs Détaillés

1. Accédez à la page de l'exécution du workflow.
2. Cliquez sur le job échoué pour afficher les logs.
3. Utilisez l'option **Rerun jobs with debug logging** pour relancer le job avec
   des logs plus détaillés.

### 4.2. Utilisation de `ACTIONS_STEP_DEBUG`

Vous pouvez également activer le mode debug en configurant une variable
d'environnement spéciale `ACTIONS_STEP_DEBUG`.

#### Exemple : Activer le Mode Debug dans le Workflow

```yaml
jobs:
  debug-job:
    runs-on: ubuntu-latest

    steps:
      - name: Enable step debug logging
        run: echo "ACTIONS_STEP_DEBUG=true" >> $GITHUB_ENV

      - name: Checkout repository
        uses: actions/checkout@v2
```

### 4.3. Ajouter des Messages de Debugging Personnalisés

Dans certaines situations, vous pouvez avoir besoin d'ajouter des messages de
débogage dans vos workflows pour inspecter des valeurs ou vérifier des points de
passage. Vous pouvez utiliser `core.debug` pour cela.

#### Exemple : Ajouter des Messages de Debugging

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Debug message
        run: |
          echo "DEBUG: Current directory is $(pwd)"
          echo "DEBUG: Branch is ${{ github.ref }}"
```

---

## Conclusion

Optimiser vos workflows CI/CD dans GitHub Actions est crucial pour garantir des
exécutions rapides, stables et efficaces. La mise en cache des dépendances, la
réutilisation des workflows, l'utilisation de matrices de jobs et la gestion des
dépendances sont toutes des stratégies essentielles pour améliorer les
performances. De plus, en utilisant les outils de débogage intégrés, vous pouvez
identifier rapidement les problèmes dans vos workflows et les corriger
efficacement. Ces bonnes pratiques vous permettent de maintenir des pipelines
robustes et performants tout en minimisant les erreurs et les interruptions.
`````
