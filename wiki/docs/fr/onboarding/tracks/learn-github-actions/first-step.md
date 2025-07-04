# Premiers Pas avec GitHub Actions

GitHub Actions est une plateforme intégrée qui permet de créer, exécuter et
automatiser des workflows directement dans GitHub. Dans cette section, nous
allons explorer comment configurer un workflow de base, comprendre la syntaxe
YAML utilisée pour définir ces workflows, et découvrir les différents
déclencheurs d'événements disponibles.

---

## 1. Configuration de base : `.github/workflows`

Pour commencer à utiliser GitHub Actions, vous devez créer un répertoire
spécifique dans votre dépôt GitHub pour y stocker vos fichiers de workflow. Ce
répertoire doit être nommé **`.github/workflows`**.

### Étapes pour créer votre premier workflow :
1. **Créer le répertoire** : Dans la racine de votre projet, créez le répertoire
   `.github/workflows`.
2. **Ajouter un fichier de workflow** : Les workflows sont définis dans des
   fichiers au format YAML (avec l'extension `.yml`). Par exemple, vous pouvez
   créer un fichier nommé `ci.yml` pour un workflow CI.

### Exemple de structure de dépôt avec un workflow :

```text
my-project/
├── .github/
│   └── workflows/
│       └── ci.yml
├── src/
├── README.md
└── package.json
```

Le fichier de workflow contient toutes les étapes que GitHub Actions doit
exécuter lorsqu'un événement est déclenché, comme un `push` ou une `pull
request`. Ce fichier YAML spécifie les jobs, les actions, et d'autres paramètres
qui forment la base de votre pipeline CI/CD.

---

## 2. Exemple simple d’un workflow CI

Voici un exemple de workflow CI simple qui s'exécute à chaque fois qu'une
modification est poussée vers la branche `main`. Ce workflow installe les
dépendances, exécute des tests et compile le projet.

```yaml
name: CI Pipeline  # Nom du workflow

# Ce workflow est déclenché lors d'un push ou d'une pull request sur la branche 'main'
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:  # Nom du job
    runs-on: ubuntu-latest  # Environnement dans lequel le job s'exécute

    steps:
      # Étape 1 : Vérifier le code source
      - name: Checkout repository
        uses: actions/checkout@v2

      # Étape 2 : Configurer Node.js
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      # Étape 3 : Installer les dépendances
      - name: Install dependencies
        run: npm install

      # Étape 4 : Exécuter les tests
      - name: Run tests
        run: npm test

      # Étape 5 : Compiler le projet
      - name: Build project
        run: npm run build
```

### Explication :
- **`name:`** : Donne un nom au workflow. Ce nom est visible dans l’interface
  GitHub Actions.
- **`on:`** : Spécifie les événements qui déclenchent le workflow. Dans cet
  exemple, le workflow s'exécute lorsqu'il y a un `push` ou une `pull request`
  sur la branche `main`.
- **`jobs:`** : Définit les différents jobs dans le workflow. Chaque job peut
  contenir plusieurs étapes (steps).
- **`runs-on:`** : Indique l'environnement où le job sera exécuté (ici, une
  machine Ubuntu hébergée par GitHub).
- **`steps:`** : Les étapes à exécuter dans le job, qui peuvent inclure des
  actions pré-construites (comme `actions/checkout@v2`) ou des commandes à
  exécuter.

---

## 3. Syntaxe des fichiers YAML pour définir les workflows

Les workflows GitHub Actions sont écrits en YAML. Ce format est simple à lire et
à écrire, et permet de structurer les workflows avec des jobs, des étapes, des
actions, et des variables. Voici une explication détaillée de la syntaxe de base
des fichiers YAML pour GitHub Actions.

### Structure générale d’un fichier YAML GitHub Actions :
```yaml
name: Nom du workflow

on:  # Déclencheur(s) d'événement(s)
  push:
    branches:
      - main

jobs:  # Les jobs à exécuter
  job_name:  # Nom du job
    runs-on: environnement  # Environnement d'exécution (ex: ubuntu-latest, windows-latest, macos-latest)

    steps:  # Les étapes à exécuter dans ce job
      - name: Nom de l'étape
        uses: action@version  # Utilisation d'une action prédéfinie
        with:  # Arguments passés à l'action
          param: valeur

      - name: Nom de l'étape
        run: commande_shell  # Commande shell à exécuter
```

### Les éléments YAML les plus courants :
- **`name:`** : Nom du workflow.
- **`on:`** : Les événements qui déclenchent le workflow. Il peut s'agir de
  `push`, `pull_request`, `schedule`, ou autres.
- **`jobs:`** : Définit les jobs, qui contiennent des étapes à exécuter.
- **`runs-on:`** : Spécifie l'environnement d'exécution du job
  (ex. `ubuntu-latest`, `windows-latest`, `macos-latest`).
- **`steps:`** : Les étapes dans un job, qui peuvent inclure des actions
  prédéfinies ou des commandes personnalisées à exécuter.

### Exemples d'étapes :
1. **Utilisation d’une action prédéfinie** :
   ```yaml
   - name: Checkout code uses: actions/checkout@v2 ``` Ici, nous utilisons
     l'action `actions/checkout@v2` pour récupérer le code source du dépôt.

2. **Exécution d’une commande personnalisée** :
   ```yaml
   - name: Run tests run: npm test ``` Cette étape exécute la commande `npm
     test` pour lancer les tests du projet.

---

## 4. Déclencheurs (events) : `push`, `pull_request`, `schedule`, etc.

Les workflows GitHub Actions peuvent être déclenchés par une variété d'événements. Voici les déclencheurs les plus courants :

### 4.1. `push`

Le déclencheur `push` est utilisé pour exécuter un workflow chaque fois qu'un `push` est effectué dans le dépôt. Vous pouvez également spécifier des branches ou des chemins spécifiques pour lesquels le workflow doit s'exécuter.

#### Exemple :
```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'src/**'
```
- **`branches:`** : Le workflow se déclenchera uniquement lorsque des
  modifications sont poussées sur la branche `main`.
- **`paths:`** : Le workflow s'exécutera uniquement si les fichiers modifiés se
  trouvent dans le répertoire `src`.

### 4.2. `pull_request`

Le déclencheur `pull_request` permet d'exécuter un workflow lorsqu'une nouvelle
pull request est créée, ou lorsque celle-ci est mise à jour.

#### Exemple :
```yaml
on:
  pull_request:
    branches:
      - main ``` Dans cet exemple, le workflow se déclenchera pour toutes les
pull requests ouvertes sur la branche `main`.

### 4.3. `schedule`

Le déclencheur `schedule` vous permet de définir des workflows qui s'exécutent à des moments spécifiques, similaires à une tâche cron.

#### Exemple :
```yaml
on:
  schedule:
    - cron: "0 0 * * 1" ``` Cet exemple déclenche le workflow chaque lundi à
minuit (heure UTC). Le format `cron` est le même que celui utilisé dans les
tâches cron de Linux.

### 4.4. Autres déclencheurs

- **`workflow_dispatch`** : Permet d’exécuter manuellement un workflow via l'interface utilisateur de GitHub.
- **`workflow_call`** : Permet d'invoquer un workflow à partir d'un autre workflow. Cela est utile pour réutiliser des workflows dans plusieurs projets ou dépôts.
- **`release`** : Déclenche le workflow lorsqu'une nouvelle version est publiée.
- **`issue_comment`** : Exécute le workflow lorsqu'un commentaire est ajouté à une issue.
- **`push_tag`** : Déclenche le workflow lorsqu'un tag est poussé.

#### Exemple de `workflow_dispatch` :
```yaml
on:
  workflow_dispatch:
```

Ce workflow peut être déclenché manuellement depuis l'interface GitHub
Actions. Par exemple, voici [un cas d'utilisation
réel](https://github.com/ClubCedille/Plateforme-Cedille/blob/master/.github/workflows/add-new-member.yml)
de `workflow_dispatch` pour la Plateforme CEDILLE, permettant d'ajouter un
nouveau membre à l'organisation via l'interface utilisateur de GitHub Actions :

```yaml
name: Ajouter un nouveau membre à l'organisation
on:
  workflow_dispatch:
    inputs:
      github_username:
        description: 'GitHub username'
        required: true
        type: string
      github_email:
        description: 'GitHub Email'
        required: true
        type: string
      team_sre:
        description: 'Add to SRE team?'
        required: false
        type: boolean
      cluster_role:
        description: 'Cluster Role'
        required: true
        type: choice
        options:
          - None
          - Reader
          - Operator
          - Admin
```

Dans cet exemple, le workflow permet à l'administrateur d'ajouter un nouveau
membre à l'organisation, de modifier les fichiers Terraform, et de créer une
Pull Request pour appliquer ces changements.

#### Exemple de `workflow_call` :
```yaml
on:
  workflow_call:
```

Le déclencheur `workflow_call` permet à un workflow d'être appelé depuis un
autre workflow. C'est une manière efficace de partager et de réutiliser des
workflows dans plusieurs projets ou équipes. Par exemple, dans le dépôt
[cedille-workflows](https://github.com/ClubCedille/cedille-workflows), nous
utilisons ce type de déclencheur pour centraliser et réutiliser des workflows
standardisés dans différents projets.

Voici un exemple d'utilisation de `workflow_call` :

```yaml
name: Réutilisation d'un workflow

on:
  workflow_call:
    inputs:
      environment:
        description: 'Environnement cible (dev, staging, prod)'
        required: true
        type: string

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run build run: echo "Building for ${{ inputs.environment }}" ```
        Dans cet exemple, le workflow peut être invoqué par d'autres workflows
        pour effectuer une tâche spécifique, comme la construction ou le
        déploiement pour un environnement particulier.


---

## Conclusion

Avec GitHub Actions, la configuration de base pour l'automatisation des
workflows CI/CD est simple et puissante. En créant des workflows dans le
répertoire `.github/workflows`, vous pouvez automatiser des tâches en réponse à
divers événements tels que des `push`, `pull_request`, ou des horaires planifiés
via `schedule`. La syntaxe YAML permet de définir facilement les jobs et les
étapes, et la flexibilité des déclencheurs rend GitHub Actions adaptable à
différents scénarios de développement et de déploiement.

GitHub Actions est conçu pour être intuitif et peut être étendu en utilisant des
actions prédéfinies ou personnalisées, ce qui en fait un outil essentiel pour
tout pipeline CI/CD moderne.
