# Introduction à GitHub Actions

## Qu'est-ce que GitHub Actions ?

GitHub Actions est une plateforme d'automatisation intégrée à GitHub, qui permet
de créer, gérer et exécuter des workflows automatisés directement à partir de
vos dépôts GitHub. Avec GitHub Actions, vous pouvez définir des processus
d'intégration continue (CI) et de déploiement continu (CD), automatiser les
tests, les builds, les déploiements, et bien plus encore.

La grande force de GitHub Actions est son intégration native avec GitHub, vous
permettant de déclencher des workflows en fonction d’événements de dépôt comme
les `push`, `pull requests`, ou même des déclencheurs personnalisés comme un
`cron` planifié.

### Caractéristiques principales de GitHub Actions

- **Intégration complète avec GitHub** : Les workflows peuvent être déclenchés
  par les événements GitHub tels que les `push`, les `pull request`, les
  `issues`, et bien d'autres.
- **Flexibilité** : GitHub Actions est hautement personnalisable avec des
  centaines d'actions disponibles dans le [GitHub
  Marketplace](https://github.com/marketplace?type=actions).
- **Runners hébergés et auto-hébergés** : GitHub propose des environnements de
  build préconfigurés, ou vous pouvez utiliser vos propres machines pour
  exécuter des workflows.

---

## Utilisation principale dans l'intégration continue (CI) et le déploiement continu (CD)

GitHub Actions est particulièrement utile pour implémenter des pipelines
d'intégration continue (CI) et de déploiement continu (CD). Voici un aperçu de
chaque concept :

### Intégration Continue (CI)

L'intégration continue est un processus dans lequel les développeurs fusionnent
régulièrement leurs modifications de code dans la branche principale du
dépôt. Les tests automatisés sont exécutés pour vérifier que le code
nouvellement intégré ne casse rien dans le projet. GitHub Actions permet
d’automatiser ce processus en créant des workflows qui s'exécutent
automatiquement lorsqu'un `push` ou une `pull request` est fait sur un dépôt.

- **Exemple d’utilisation CI :**
  - Exécution automatique des tests unitaires après chaque `commit` ou `pull
request`.
  - Compilation automatique du code pour vérifier qu’il n’y a pas d’erreurs de
    syntaxe ou de compilation.

```yaml
name: CI Pipeline

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: "14"

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

### Déploiement Continu (CD)

Le déploiement continu consiste à automatiser le déploiement de votre
application dans différents environnements (développement, staging,
production). GitHub Actions peut être utilisé pour déclencher des déploiements
après le succès des tests. Par exemple, vous pouvez configurer un workflow pour
déployer une application sur un service cloud comme AWS, Azure ou GCP après
chaque `merge` sur la branche principale.

- **Exemple d’utilisation CD :**
  - Déploiement d’une application sur AWS après un `merge` réussi sur la branche
    `main`.
  - Automatisation des versions avec des workflows qui génèrent automatiquement
    des versions de l’application et les publient.

```yaml
name: CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deploy to AWS
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-west-2

      - name: Deploy application
        run: |
          aws s3 sync ./build s3://my-app-bucket
```

---

## Concepts clés de GitHub Actions

GitHub Actions repose sur plusieurs concepts clés qui permettent de structurer
et organiser les workflows d’automatisation. Voici une explication détaillée des
termes fondamentaux :

### Workflows

Un **workflow** est une automatisation définie dans un fichier YAML dans le
répertoire `.github/workflows/`. Un workflow est composé d'une ou plusieurs
**jobs** qui s’exécutent en fonction d'événements spécifiques. Par exemple, un
workflow peut être déclenché lorsqu'un développeur pousse du code dans le dépôt.

- **Déclencheurs d’événements** : Les workflows sont déclenchés par des
  événements spécifiques, tels qu'un `push`, une `pull request`, ou des
  événements planifiés avec un `cron`.
- **Définition de jobs** : Un workflow contient un ou plusieurs jobs. Chaque job
  est une série d'étapes exécutées dans un environnement distinct.

### Jobs

Un **job** est une séquence d'**étapes** qui s’exécutent dans un environnement
isolé. Tous les jobs dans un workflow s’exécutent par défaut en parallèle, mais
ils peuvent être configurés pour s'exécuter de manière séquentielle si un job
dépend d’un autre.

- **Exécution parallèle** : Plusieurs jobs peuvent s’exécuter en parallèle pour
  réduire le temps total d’exécution.
- **Dépendances entre jobs** : Un job peut dépendre de l'achèvement d'un autre
  job.

```yaml
jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Step 1
        run: echo "Job 1 Step 1"

  job2:
    needs: job1 # Dépend de job1
    runs-on: ubuntu-latest
    steps:
      - name: Step 1
        run: echo "Job 2 Step 1"
```

### Actions

Une **action** est une tâche individuelle que vous pouvez exécuter dans un
job. GitHub Actions offre une large bibliothèque d’actions prédéfinies
disponibles dans le [GitHub
Marketplace](https://github.com/marketplace?type=actions). Vous pouvez également
créer vos propres actions pour répondre à des besoins spécifiques.

- **Actions de Marketplace** : Vous pouvez réutiliser des actions développées
  par d’autres, telles que `actions/checkout` pour vérifier le code ou
  `actions/setup-node` pour configurer Node.js.
- **Actions personnalisées** : Il est possible de créer des actions spécifiques
  à votre projet en utilisant des scripts Bash ou en créant des conteneurs
  Docker. Pour un exemple détaillé de création d'une action personnalisée,
  consultez le dépôt
  [Cedille-Actions-By-Example](https://github.com/ClubCedille/cedille-actions-by-example),
  qui illustre comment structurer et configurer une action comme
  **KubeSketcher**, une action permettant de générer des diagrammes
  d'architecture de namespaces Kubernetes.

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v2 # Action prédéfinie depuis le Marketplace

  - name: Run custom script
    run: ./my-custom-script.sh # Action personnalisée
```

### Runners

Un **runner** est la machine qui exécute le job défini dans un workflow. GitHub
offre des **runners hébergés** (machines préconfigurées par GitHub) et vous
pouvez également configurer vos propres **runners auto-hébergés** si vous avez
des besoins spécifiques en termes d'environnement d'exécution.

- **Runners hébergés** : GitHub fournit des runners hébergés sous Linux,
  Windows, et macOS avec les outils CI/CD les plus utilisés déjà installés.
- **Runners auto-hébergés** : Si vous avez des besoins spécifiques en termes de
  matériel ou de sécurité, vous pouvez configurer vos propres runners en
  utilisant vos machines.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest # Utilise un runner hébergé sous Ubuntu

  custom-build:
    runs-on: self-hosted # Utilise un runner auto-hébergé
```

---

## Différences entre GitHub Actions et d'autres outils CI/CD

GitHub Actions se distingue par son intégration native avec GitHub, son
flexibilité et la simplicité de sa configuration. Voici quelques différences
majeures entre GitHub Actions et d'autres outils CI/CD tels que Jenkins, Travis
CI ou CircleCI :

### Intégration native avec GitHub

Contrairement à d'autres outils CI/CD qui nécessitent une intégration externe à
GitHub, GitHub Actions est directement intégré dans l’interface de GitHub. Cela
signifie que vous pouvez gérer vos workflows CI/CD sans quitter GitHub, avec une
gestion facile des triggers, secrets et permissions.

### Flexibilité

GitHub Actions est extrêmement flexible, vous permettant de définir vos
workflows à l'aide d'un simple fichier YAML. Vous avez également accès à une
grande variété d’actions prédéfinies dans le Marketplace, et la possibilité de
créer vos propres actions.

### Exécution dans GitHub

L’exécution des workflows se fait directement dans GitHub à l’aide des runners
hébergés. D'autres services, comme Jenkins, nécessitent souvent de configurer
vos propres serveurs d'exécution.

### Comparaison des Fonctionnalités

| Outils CI/CD      | GitHub Actions     | Jenkins           | Travis CI          | CircleCI           |
| ----------------- | ------------------ | ----------------- | ------------------ | ------------------ |
| **Intégration**   | Native GitHub      | Externe           | Externe            | Externe            |
| **Configuration** | YAML dans le dépôt | Interface Jenkins | YAML dans le dépôt | YAML dans le dépôt |

| **Caractéristiques** | **GitHub Actions**       | **Jenkins**      | **CircleCI**        | **GitLab CI/CD**         |
| -------------------- | ------------------------ | ---------------- | ------------------- | ------------------------ |
| **Runners**          | Hébergés / Auto-hébergés | Serveurs Jenkins | Hébergés uniquement | Hébergés / Auto-hébergés |
| **Marketplace**      | Oui, avec actions        | Plugins Jenkins  | Oui                 | Oui                      |

---

## Conclusion

GitHub Actions est une plateforme puissante pour automatiser vos pipelines CI/CD
directement au sein de GitHub. Grâce à son intégration transparente, sa
flexibilité et ses nombreux outils disponibles, GitHub Actions simplifie
l’automatisation des workflows pour les développeurs tout en restant adaptable
aux besoins spécifiques de chaque projet. Que ce soit pour un petit projet ou
pour une grande infrastructure DevOps, GitHub Actions constitue une solution
robuste et évolutive.
