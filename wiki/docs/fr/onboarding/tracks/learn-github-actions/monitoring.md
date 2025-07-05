# Monitoring et Reporting avec GitHub Actions

Le monitoring et le reporting dans GitHub Actions sont essentiels pour s'assurer
que les workflows CI/CD fonctionnent correctement, et pour identifier rapidement
les problèmes. Ce guide explique comment surveiller l'état des workflows, gérer
les logs et diagnostics, générer des rapports de tests automatisés, visualiser
les workflows dans l'interface GitHub, et notifier les équipes en cas d'échec ou
de succès de builds.

---

## 1. Monitoring des Workflows : État des Builds, Logs, et Diagnostics

### 1.1. Surveillance de l'État des Builds

GitHub Actions offre une interface utilisateur intuitive qui permet de
surveiller l'état des builds en temps réel. Vous pouvez accéder à cette
interface via l'onglet **Actions** dans votre dépôt GitHub. Chaque workflow
déclenché génère un build dont l'état est visible (succès, échec, en cours).

#### Statuts des Builds

- **Vert (Succès)** : Tous les jobs dans le workflow ont été exécutés avec
  succès.
- **Rouge (Échec)** : Un ou plusieurs jobs ont échoué.
- **Jaune (En cours)** : Le workflow est en cours d'exécution.

### 1.2. Accès aux Logs des Workflows

Pour diagnostiquer des problèmes, GitHub Actions fournit des logs détaillés pour
chaque étape d’un workflow. Ces logs incluent les sorties de commandes et les
éventuelles erreurs rencontrées.

#### Consulter les Logs

1. Accédez à l'onglet **Actions** de votre dépôt.
2. Sélectionnez un workflow spécifique.
3. Cliquez sur un job pour afficher ses étapes.
4. Vous pouvez voir les logs pour chaque étape en cliquant sur le bouton
   d'expansion à côté du nom de l'étape.

Les logs fournissent des informations précieuses telles que les messages de
succès, d'erreurs, ou de débogage. Si un job échoue, les logs seront l'endroit
où rechercher les erreurs.

#### Exemple : Affichage des Logs après Échec d’un Workflow

Lorsque qu’un workflow échoue, GitHub met en évidence les étapes
problématiques. Vous pouvez afficher les détails des logs pour comprendre la
cause de l'échec :

```bash
Run npm install
npm ERR! code ENOENT
npm ERR! syscall open
npm ERR! path /build/package.json
npm ERR! errno -2
```

### 1.3. Diagnostic des Problèmes

GitHub Actions permet également de relancer un workflow avec des logs plus
détaillés pour diagnostiquer les problèmes. Vous pouvez activer l'option de
**debugging avancé** pour obtenir plus d'informations.

#### Activer les Logs de Debugging

1. Accédez à la page des logs du workflow.
2. Cliquez sur **Rerun jobs with debug logging** pour relancer le workflow en
   mode debug.
3. Les logs détaillés vous permettront de comprendre pourquoi le job a échoué.

---

## 2. Générer des Rapports de Test Automatisé

Les tests automatisés sont essentiels pour garantir la qualité du code. En
combinant GitHub Actions avec des outils de tests comme JUnit, Mocha, ou Jest,
vous pouvez générer et publier des rapports de tests dans vos workflows CI/CD.

### 2.1. Exemple de Workflow avec Rapport de Tests JUnit

JUnit est l'un des frameworks de test les plus courants pour les applications
Java. Voici un exemple de workflow GitHub Actions qui exécute des tests JUnit et
génère des rapports de test.

```yaml
name: Run JUnit Tests

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up JDK
        uses: actions/setup-java@v2
        with:
          java-version: "11"

      - name: Run tests with JUnit
        run: ./gradlew test

      - name: Archive test results
        uses: actions/upload-artifact@v2
        with:
          name: junit-results
          path: build/test-results/test/*.xml
```

#### Explication

- **JUnit Tests** : Les tests JUnit sont exécutés avec la commande `./gradlew
test`.
- **Archive test results** : Les résultats des tests JUnit au format XML sont
  sauvegardés en tant qu’artefacts, que vous pouvez consulter dans l'interface
  GitHub.

### 2.2. Visualisation des Rapports de Test

GitHub Actions ne fournit pas de visualisation native des rapports de tests,
mais vous pouvez générer et visualiser les résultats des tests via des services
tiers, ou exporter les résultats sous forme d'artefacts à télécharger.

### 2.3. Générer des Rapports de Couverture de Code

Vous pouvez intégrer des outils comme **Codecov** ou **Coveralls** dans vos
workflows GitHub Actions pour générer des rapports de couverture de code.

#### Exemple : Workflow avec Codecov

```yaml
name: Codecov Test and Coverage

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Run tests
        run: npm test -- --coverage

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v2
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
```

---

## 3. Visualisation des Workflows sur l'Interface GitHub

GitHub offre une visualisation graphique des workflows CI/CD pour chaque
dépôt. Cette vue permet aux développeurs de suivre le processus d'exécution,
d'identifier les erreurs, et de comprendre les dépendances entre jobs.

### 3.1. Interface de Visualisation des Workflows

1. Accédez à l’onglet **Actions** dans votre dépôt.
2. Vous verrez une liste de workflows déclenchés récemment.
3. En cliquant sur un workflow spécifique, vous accédez à une vue graphique des
   jobs et de leur état (succès, échec, ou en attente).

Chaque job est représenté dans un diagramme de flux, ce qui permet de visualiser
facilement les étapes du pipeline et d'identifier rapidement les points de
défaillance.

### 3.2. Suivi des Artefacts

Les artefacts générés par un workflow (fichiers de build, résultats de tests,
logs) sont accessibles via l'interface des Actions. Vous pouvez les télécharger
pour analyse ou les archiver pour référence future.

---

## 4. Notifier les Équipes en Cas d'Échec ou de Succès de Build

Les notifications automatiques sont essentielles pour alerter les équipes des
succès ou des échecs dans les workflows CI/CD. GitHub Actions s'intègre à des
outils de communication comme **Slack**, **Microsoft Teams**, ou des services
d'email pour envoyer des alertes en fonction de l'état des builds.

### 4.1. Notifier via Slack

GitHub Actions permet d'envoyer des notifications Slack lorsqu'un workflow
échoue ou réussit. Pour ce faire, vous pouvez utiliser une **Webhook Slack**.

#### Exemple : Notification Slack pour un Workflow CI/CD

1. Créez une **Webhook Slack** dans votre espace de travail.
2. Ajoutez le webhook à GitHub Actions en tant que secret (`SLACK_WEBHOOK_URL`).

```yaml
name: Notify Slack on Build

on:
  push:
    branches:
      - main

jobs:
  notify:
    runs-on: ubuntu-latest

    steps:
      - name: Send Slack notification on success
        if: success()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build succeeded for ${{ github.repository }}"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: Send Slack notification on failure
        if: failure()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build failed for ${{ github.repository }}"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}
```

#### Explication

- **`if: success()`** et **`if: failure()`** : Ces conditions permettent
  d'envoyer une notification différente selon que le build a réussi ou échoué.
- **`curl`** : Utilisé pour envoyer une requête POST à Slack avec le message
  approprié.

### 4.2. Notifications par Email

GitHub Actions peut également envoyer des notifications par email en utilisant
un service SMTP ou des outils tiers comme **SendGrid** ou **Mailgun**.

#### Exemple : Workflow de Notification par Email

```yaml
name: Notify on Build Status

on:
  push:
    branches:
      - main

jobs:
  notify:
    runs-on: ubuntu-latest

    steps:
      - name: Send email on success
        if: success()
        uses: dawidd6/action-send-mail@v2
        with:
          server_address: smtp.gmail.com
          server_port: 465
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: "Build Success"
          body: "The build for ${{ github.repository }} succeeded!"
          to: "team@example.com"

      - name: Send email on failure
        if: failure()
        uses: dawidd6/action-send-mail@v2
        with:
          server_address: smtp.gmail.com
          server_port

: 465
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: "Build Failure"
          body: "The build for ${{ github.repository }} failed!"
          to: "team@example.com"
```

---

## Conclusion

Le monitoring et le reporting sont des aspects cruciaux de la gestion des
workflows CI/CD avec GitHub Actions. En utilisant les logs détaillés, les
rapports de tests, et les outils de notification, vous pouvez surveiller de
manière proactive l'état des builds et diagnostiquer rapidement les
problèmes. L'intégration avec des outils comme Slack ou les services d'email
permet de garder les équipes informées en temps réel, garantissant une
résolution rapide des échecs de builds et une meilleure collaboration au sein
des équipes de développement.
