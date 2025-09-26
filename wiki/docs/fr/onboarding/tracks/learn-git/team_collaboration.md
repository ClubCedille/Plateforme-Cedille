
# 🌿 Tutoriel Git : créer une branche depuis une branche et fusionner via Pull Request

Ce tutoriel vous apprend à :

1. ✅ Partir d’une branche de fonctionnalité existante  
2. ✏️ Travailler sur une sous‑fonctionnalité  
3. 🔄 Ouvrir une Pull Request (PR) pour la fusionner dans la branche de
   fonctionnalité d’origine

C’est conçu pour les **débutants** utilisant la CLI Git et GitHub.

---

## 🧠 Qu’est‑ce que le branchement (branching) ?

Le **branchement** dans Git, c’est comme créer un univers parallèle de votre
code, où vous pouvez travailler librement sans affecter le projet original.

Cela vous permet de :

🌿 Créer un espace séparé pour développer de nouvelles fonctionnalités  
🧪 Expérimenter ou corriger des bogues sans rien casser  
👨‍👩‍👧‍👦 Collaborer avec d’autres sur des tâches différentes  
🔁 Revenir fusionner votre travail dans la branche principale quand il est prêt

Chaque branche part d’un point précis (souvent `main` ou une autre
fonctionnalité) et évolue indépendamment.  
Ainsi, les équipes peuvent travailler **simultanément et en toute sécurité** sur
plusieurs parties d’un projet.

> 🔐 Le branchement est la base du développement collaboratif. Sans lui, tout le
> monde travaillerait sur les mêmes fichiers en même temps — menant au chaos et
> à la perte de travail.

---

## 🧠 Qu’est‑ce qu’une Pull Request ?

Une **Pull Request (PR)** est une demande de fusion de votre branche dans une
autre branche (comme `main`, `develop` ou une autre fonctionnalité). Elle permet
aux autres de :

- 👀 Réviser votre code
- 🧪 Lancer des tests automatisés
- 💬 Laisser des commentaires ou suggestions
- ✅ Approuver les changements

> 🔐 Les PR sont essentielles pour la **qualité du code**, la **communication
> d’équipe** et **éviter de casser la prod**.

---

## 🌐 Pourquoi les branches et les PR sont essentielles

![Schéma de branches Git](./img/team_collab.png)

Ce schéma montre une situation typique dans un projet d’équipe :

- 🟢 `master` (ou `main`) est le **code stable prêt pour la production**.
- 🔵 **Votre travail** se fait sur une branche de fonctionnalité séparée.
- 🟠 **Le travail de quelqu’un d’autre** se fait indépendamment, aussi sur une
  branche séparée.

Sans branches ni Pull Requests, tout le travail serait fait **sur la même ligne
temporelle, dans les mêmes fichiers**, ce qui mènerait à :

- 🔥 Des conflits
- 🐛 Des bogues fusionnés par erreur
- ❌ La perte de stabilité du code

---

### ✅ En quoi les branches aident

- Vous isolez vos changements de ceux des autres.
- Vous pouvez travailler librement sans affecter le code de `main`.
- Vous réduisez le risque de casser des choses pour l’équipe.
- Vous pouvez tester et expérimenter en toute sécurité dans votre branche.

---

### ✅ En quoi les Pull Requests aident

- Votre code est **relus** avant la fusion.
- GitHub affiche **automatiquement les conflits**, afin de les corriger à temps.
- Vous avez un **espace de discussion** autour de votre code.
- Vous gardez `main` propre et stable en tout temps.

> 💡 Pensez aux branches comme votre « établi » et aux PR comme la « porte de
> qualité » avant d’intégrer votre travail au produit final de l’équipe.

---

### 🔁 Ce que représente ce schéma

- **Vous** et **quelqu’un d’autre** avez créé une branche à partir de `master`
  en même temps.
- Vous avez travaillé indépendamment sur vos fonctionnalités.
- Vous avez fusionné votre travail via des PR (idéalement).
- `master` reste propre et à jour, avec un minimum de conflits.

---

## Flux de travail typique

Voici comment procéder pour travailler en parallèle sur une fonctionnalité :

1. Partez de votre branche de fonctionnalité principale

2. Créez une sous‑branche de fonctionnalité

3. Faites vos changements

4. Poussez vers GitHub git push origin feature/header-component

5. Allez sur GitHub et créez une Pull Request visant `feature/main-layout`

6. Après approbation, fusionnez via l’interface GitHub

7. Nettoyez

Voici un tutoriel détaillé, étape par étape, pour le faire.

---

!!! warning "À LIRE SEULEMENT"

      **TOUS LES POINTS CI‑DESSOUS SONT À LIRE, PAS À EXÉCUTER. VOUS LES PRATIQUEREZ DANS LE LAB.**

---

## Scénario

Vous travaillez sur une fonctionnalité plus large : `feature/main-layout`  
Vous voulez créer une sous‑fonctionnalité : `feature/layout-component`  
Vous la fusionnerez via une Pull Request — pas localement.

---

## Étape 1 : Aller dans le dossier du projet

    cd path/to/your/project

Si vous n’avez pas encore cloné le projet :

    git clone git@github.com:your-team/project-name.git
    cd project-name

---

## Étape 2 : Basculer sur la branche de base

C’est la fonctionnalité sur laquelle vous vous basez.

    git checkout feature/main-layout
    git pull origin feature/main-layout

---

## Étape 3 : Créer une nouvelle branche depuis celle‑ci

    git checkout -b feature/layout-component

📌 Vous travaillez maintenant **sur une nouvelle branche basée sur
`feature/main-layout`**.

---

## Étape 4 : Modifier le code

Utilisez votre éditeur préféré (VSCode, etc.) pour :

- Ajouter votre nouvelle fonctionnalité ou correction
- Enregistrer vos fichiers

---

## Étape 5 : Ajouter et valider vos changements

    git add .
    git commit -m "feat: add new layout component"

> Les messages de commit doivent être parlants. Utilisez des formats comme
> `feat:`, `fix:`, `docs:`, etc.

---

## Étape 6 : Pousser votre branche vers GitHub

    git push origin feature/layout-component

Votre branche est maintenant publiée en ligne et prête pour une revue.

---

## Étape 7 : Ouvrir une Pull Request

1. Allez sur votre dépôt sur [GitHub](https://github.com)
2. Vous verrez une invite : ➕ **Compare & pull request** → Cliquez
3. Définissez la **base branch** sur `feature/main-layout`
4. Définissez la **compare branch** sur `feature/layout-component`
5. Ajoutez un **titre et une description clairs**
6. Cliquez sur **Create pull request**

> N’oubliez pas d’expliquer ce que fait votre code et pourquoi vous avez fait
> ces changements.

---

## Étape 8 : Faire relire votre PR

Vos coéquipiers peuvent maintenant :

- Relire votre code
- Commenter ou suggérer des améliorations
- Approuver ou demander des changements

Si quelqu’un demande des changements :

    # Make the edits
    git add .
    git commit -m "fix: adjust component"
    git push origin feature/layout-component

La PR se mettra à jour automatiquement.

---

## Étape 9 : Fusionner la Pull Request

Une fois approuvée et prête :

1. Allez sur la PR sur GitHub
2. Cliquez **Squash and merge** ou **Rebase and merge**
3. Confirmez la fusion

✅ Votre code est maintenant fusionné dans `feature/main-layout`.

---

## Étape 10 : Nettoyer les anciennes branches

Après la fusion :

    git branch -d feature/layout-component           # delete local
    git push origin --delete feature/layout-component  # delete remote

---

## 📘 Récapitulatif complet : flux de fonctionnalité basé sur PR

    # Partez de votre branche de fonctionnalité principale
    git checkout feature/main-layout
    git pull origin feature/main-layout

    # Créez une sous‑branche de fonctionnalité
    git checkout -b feature/layout-component

    # Faites vos changements
    git add .
    git commit -m "feat: add component"

    # Poussez vers GitHub
    git push origin feature/layout-component

    # → Allez sur GitHub et créez une Pull Request visant feature/main-layout

    # Après approbation → fusionnez via l’interface GitHub

    # Nettoyez
    git branch -d feature/layout-component
    git push origin --delete feature/layout-component

---

## Section suivante — Lab : Hall of GitFame

Maintenant que vous avez un guide sur la collaboration en équipe avec Git,
mettons cela en pratique avec **[OLYMPGIT](./merge_conflicts.md)**.
