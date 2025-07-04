# Créer des Workflows Personnalisés avec GitHub Actions

GitHub Actions vous permet de créer des workflows personnalisés adaptés à vos
besoins spécifiques en matière d'intégration continue (CI) et de déploiement
continu (CD). Les workflows sont définis dans des fichiers YAML et peuvent être
utilisés pour automatiser un large éventail de tâches, du test de code au
déploiement en production.

---

## 1. Définir des Jobs et des Étapes (Steps)

Un workflow dans GitHub Actions est composé de plusieurs **jobs**, et chaque
**job** contient une série d'**étapes** (steps). Un job est un ensemble de
tâches qui s'exécute sur une machine donnée, tandis que chaque étape représente
une commande ou une action spécifique exécutée dans ce job.

### Structure d’un Job

Un **job** doit définir :
- L’environnement sur lequel il s’exécute (`runs-on`).
- Les **étapes** à exécuter.
- Optionnellement, des dépendances entre jobs ou des conditions d'exécution.

### Exemple de Définition de Jobs et d'Étapes

```yaml
name: Custom Workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest  # Définit l'environnement (une machine Ubuntu hébergée)

    steps:
      - name: Checkout code  # Étape 1 : Récupérer le code source du dépôt
        uses: actions/checkout@v2

      - name: Install dependencies  # Étape 2 : Installer les dépendances
        run: npm install

      - name: Run tests  # Étape 3 : Exécuter les tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy application
        run: ./deploy.sh
```

### Détails :
- **`jobs:`** : La section `jobs` contient tous les jobs du workflow. Chaque job
  est défini par un identifiant unique (ici, `build` et `deploy`).
- **`runs-on:`** : Spécifie l'environnement dans lequel le job s'exécute (par
  exemple, `ubuntu-latest`).
- **`steps:`** : Chaque job contient une ou plusieurs étapes, qui peuvent
  exécuter des commandes shell (`run`) ou utiliser des actions existantes
  (`uses`).

---

## 2. Utiliser des Actions Préconstruites depuis le GitHub Marketplace

GitHub Actions dispose d'un **Marketplace** où vous pouvez trouver et utiliser
des actions préconstruites créées par la communauté. Ces actions peuvent être
facilement intégrées dans vos workflows pour effectuer des tâches courantes
telles que vérifier le code, configurer des environnements, ou déployer des
applications.

### Comment Utiliser des Actions depuis le Marketplace

Pour utiliser une action depuis le Marketplace, vous pouvez l'intégrer dans vos étapes (`steps`) en utilisant la syntaxe suivante :
```yaml
uses: <action>@<version>
```
Voici un exemple d'utilisation de l'action `actions/checkout` pour récupérer le code source d'un dépôt.

#### Exemple :

```yaml
steps:
  - name: Checkout code
    uses: actions/checkout@v2  # Utilise l'action pour cloner le dépôt
```

L'action `actions/checkout` est couramment utilisée pour cloner le dépôt sur la
machine où les jobs s'exécutent. Vous pouvez trouver des centaines d'autres
actions sur le [GitHub
Marketplace](https://github.com/marketplace?type=actions), comme :
- **`actions/setup-node`** : Configurer un environnement Node.js.
- **`actions/upload-artifact`** : Sauvegarder des fichiers ou des résultats de
  tests.

### Exemple Complet :

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      - name: Install dependencies
        run: npm install
```

---

## 3. Créer et Utiliser Vos Propres Actions Personnalisées

En plus d'utiliser des actions préconstruites, GitHub Actions vous permet de
**créer vos propres actions personnalisées** pour répondre à des besoins
spécifiques. Ces actions peuvent être écrites en JavaScript ou définies dans des
conteneurs Docker pour des environnements plus complexes. Pour un exemple
pratique de création d'une action personnalisée, vous pouvez consulter le dépôt
[Cedille-Actions-By-Example](https://github.com/ClubCedille/cedille-actions-by-example). Ce
dépôt présente différentes actions, dont l'action **KubeSketcher**, qui génère
des diagrammes d'architecture de namespaces Kubernetes à partir de manifests, et
**WorkflowWikiExample**, une action créée spécialement pour illustrer la
création et le fonctionnement d'une action.

Voici la procédure qui a été suivie pour la création de l'action
**cedille-actions-by-example/WorkflowWikiExample** :

```markdown
### Types d'Actions Personnalisées

1. **Actions JavaScript** : Actions écrites en JavaScript qui s'exécutent directement dans l'environnement du runner.
2. **Actions Docker** : Actions encapsulées dans un conteneur Docker, permettant de définir un environnement d'exécution plus complexe.

### Créer une Action JavaScript Personnalisée

Voici comment créer une action simple en JavaScript :

1. **Créer un répertoire `WorkflowWikiExample` dans votre dépôt**.
2. **Créer un fichier `index.js`** avec le code JavaScript de votre action :

```js
// index.js
const core = require('@actions/core');
const github = require('@actions/github');

try {
  const message = core.getInput('message');
  console.log(`Message: ${message}`);
} catch (error) {
  core.setFailed(error.message);
}
```

3. **Créer un fichier `action.yml`** pour décrire l’action :

```yaml
name: 'Print Message'
description: 'Imprime un message dans la console'
inputs:
  message:
    description: 'Le message à imprimer'
    required: true
runs:
  using: 'node20'
  main: 'index.js'
```

### Utiliser l'Action Personnalisée

Une fois que vous avez créé votre action, vous pouvez l'utiliser dans vos
workflows comme n'importe quelle autre action.

```yaml
name: Custom Action Workflow

on: [push]

jobs:
  custom-action-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Run custom action
        uses: ClubCedille/Cedille-Actions-By-Example/WorkflowWikiExample@master
        with:
          message: "Bonjour depuis l'action personnalisée !"
```

### Actions Docker

Si votre action nécessite un environnement spécifique, vous pouvez créer une
action Docker. Cela vous permet d'exécuter des scripts dans un conteneur isolé.

#### Exemple d'Action Docker :
1. Créez un fichier `Dockerfile` :

```dockerfile
FROM node:14
COPY . /app
WORKDIR /app
RUN npm install
CMD ["node", "index.js"]
```

2. Créez l’action YAML pour Docker :

```yaml
name: 'Custom Docker Action'
runs:
  using: 'docker'
  image: 'Dockerfile'
```

---

## 4. Secrets et Variables d’Environnement

Les **secrets** et **variables d'environnement** permettent de sécuriser les
informations sensibles et de passer des paramètres dynamiques à vos workflows.

### Utiliser des Secrets

Les secrets sont des informations sensibles, comme des clés API ou des
identifiants de connexion, que vous ne voulez pas exposer directement dans votre
code. Vous pouvez ajouter des secrets à votre dépôt via l'interface GitHub, puis
les référencer dans vos workflows.

#### Ajouter un Secret :
1. Allez dans les **Settings** du dépôt.
2. Cliquez sur **Secrets and variables** > **Actions**.
3. Ajoutez un secret (par exemple, `API_KEY`).

#### Utiliser un Secret dans un Workflow :

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Use secret API key
        run: echo "Your API key is ${{ secrets.API_KEY }}"
```

### Utiliser des Variables d'Environnement

Vous pouvez également définir des variables d'environnement à utiliser dans les
jobs ou les étapes.

#### Exemple de Variables d'Environnement :

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    env:
      NODE_ENV: production
      API_URL: https://api.example.com

    steps:
      - name: Print environment variables
        run: echo "Environment: $NODE_ENV, API: $API_URL"
```

---

## 5. Exécution Parallèle et Conditionnelle

### Exécution Parallèle

Par défaut, les jobs dans un workflow GitHub Actions s'exécutent en
**parallèle**. Cela signifie que plusieurs jobs peuvent s'exécuter
simultanément, ce qui permet d’accélérer le temps d'exécution global.

#### Exemple d'Exécution Parallèle :

```yaml
jobs:
  build-frontend:
    runs-on: ubuntu-latest
    steps:
      - name: Build frontend
        run: npm run build-frontend

  build-backend:
    runs-on: ubuntu-latest
    steps:
      - name: Build backend run: npm run build-backend ``` Dans cet exemple, les
        jobs `build-frontend` et `build-backend` s'exécuteront en parallèle.

### Exécution Conditionnelle

Vous pouvez définir des conditions pour exécuter ou sauter des jobs ou des étapes. Cela permet, par exemple, de n’exécuter certaines actions que si un test échoue, ou si la branche correspond à une certaine condition.

#### Exécution Conditionnelle avec `if` :

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest

    if: github.ref =='refs/heads/main' #Exécuter uniquement si la branche est 'main'

    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

Voici comment vous pouvez ajouter une section sur le passage d'informations d'un
workflow à un autre, en plus de la section d'exécution conditionnelle :

```markdown
#### Exécution Conditionnelle en Fonction de l'Échec ou du Succès :

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run tests
        run: npm test

  notify:
    runs-on: ubuntu-latest
    needs: test
    if: failure()  # Ce job s'exécute uniquement si le job 'test' échoue
    steps:
      - name: Send notification
        run: echo "Tests failed!"
```

### Passage d'Informations d'un Job à un Autre

Il est possible de faire passer des informations d'un job à un autre dans un
workflow GitHub Actions en définissant des **outputs** dans un job et en
utilisant ces outputs dans un job suivant. Cela permet de réutiliser des données
calculées ou récupérées dans un job pour les utiliser dans un autre.

#### Exemple : Définir et Utiliser des Outputs dans des Jobs

Dans cet exemple, le premier job **build** génère un numéro de version et le
passe au job suivant **deploy**.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Generate version number
        id: version_step
        run: echo "::set-output name=version::1.0.$(date +%s)"

  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Deploy application
        run: echo "Deploying version ${{ needs.build.outputs.version }}"
```

#### Explication :

1. **Définir un Output** : Dans le job `build`, la commande `::set-output` est
   utilisée pour définir un output appelé `version`. Ce numéro de version est
   généré à l'aide de la commande `date` pour créer une valeur unique.

2. **Utiliser l'Output dans un Autre Job** : Dans le job `deploy`, l'output du
   job `build` est référencé via la syntaxe `${{ needs.build.outputs.version
   }}`. Cela permet d'accéder à l'information générée dans le premier job et de
   l'utiliser pour déployer une version spécifique.

#### Référence vers la Documentation

Pour plus de détails, vous pouvez consulter la documentation GitHub Actions sur
le [passage d'informations entre
jobs](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/passing-information-between-jobs#example-defining-outputs-for-a-job).

---

## Conclusion

La création de workflows personnalisés dans GitHub Actions vous permet
d'automatiser efficacement vos pipelines CI/CD. Que vous utilisiez des actions
préconstruites depuis le Marketplace, ou que vous créiez vos propres actions,
GitHub Actions offre une flexibilité inégalée. Les secrets, variables
d'environnement, et les conditions d'exécution vous donnent un contrôle total
sur vos workflows, vous permettant de créer des processus robustes et sécurisés
pour votre projet.

Avec ces outils, vous êtes maintenant prêt à créer des workflows adaptés à vos
besoins, améliorer la collaboration entre les équipes, et automatiser vos
déploiements et tests de manière fiable.
