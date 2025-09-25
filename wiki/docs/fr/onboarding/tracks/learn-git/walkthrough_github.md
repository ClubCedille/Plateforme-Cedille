# Vos premiers pas avec Git/GitHub

## Utiliser Git

### 1. Télécharger la CLI Git

D’abord, vous devez [télécharger l’interface en ligne de commande
Git](https://git-scm.com/downloads).

### 2. Configurer Git

Une fois installé, configurez vos identifiants Git avec ces commandes :

```bash
git config --global user.name "Your Name"
git config --global user.email "yourEmail@example.com"
```

### 3. S’authentifier avec GitHub

Nous devons authentifier notre ordinateur local avec notre compte GitHub.
Plusieurs méthodes existent, mais nous privilégions SSH car c’est la plus
sécurisée.

Pour cette étape, rendez‑vous sur [cette
page](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
qui contient tout le nécessaire pour configurer SSH. Ignorez la section sur les
clés de sécurité matérielles.

!!! note "Note"

Gardez en tête que si vous mettez un mot de passe à votre clé SSH privée, on
vous le demandera à chaque interaction avec le dépôt distant — c’est‑à‑dire pour
fetch, push, pull et autres actions (que nous voyons ici). Ne tombez pas dans le
même piège que l’éditeur de ce tutoriel. :(

!!! warning "ATTENTION"

_Veuillez terminer la configuration SSH avant de continuer. Nous voulons que
vous appreniez à cloner et interagir avec le dépôt via SSH, et non via HTTPS_ !!

### 4. Cloner un dépôt

Il est temps de commencer à travailler sur un dépôt ! Vous pouvez cloner votre
dépôt par défaut, et nous ajouterons des éléments à votre `readme.md`.
_Assurez‑vous d’exécuter cette commande à l’endroit où vous voulez créer votre
dépôt local_.

``` bash
git clone git@github.com:YourUsename/YourUsername.git
```

### 5. Ajouter un fichier au dépôt

Dans votre dépôt local, créez un nouveau fichier :

|Linux|Windows|
|-----|-------|
|`touch test.md`|`echo test123 > test.md`|

Ajoutons maintenant votre fichier pour qu’il soit suivi par Git :

```bash
git add test.md
```

### 6. Valider les changements

Ajoutez du texte à `test.md` et validez‑le dans l’historique avec :

```bash
git commit -m "Added some text"
```

L’option `-m "Added some text"` permet d’ajouter un message à votre commit. Elle
est requise dans notre cas.

### 7. Pousser les changements

Après quelques commits, vous voudrez les partager avec tout le monde en les
poussant vers le dépôt distant.

```bash
git push origin main
```

> Les options `origin main` précisent sur quelle branche pousser.

Vous pouvez maintenant aller sur
<https://github.com/YourUsername/YourUsername.git> pour voir vos nouveaux
fichiers ajoutés au dépôt distant.

### 8. Récupérer de nouveaux changements

Sur le site GitHub, ajoutez un nouveau fichier à votre dépôt distant via le
bouton en haut à gauche. Comme vous le verrez, il ne sera pas synchronisé avec
votre dépôt local, sauf si vous utilisez :

``` bash
git fetch origin main
git pull origin main
```

> `git fetch` est optionnel et vous permet de voir les nouveaux changements
> disponibles avant d’utiliser `git pull` pour les récupérer.

---

Maintenant que vous avez appris les bases de Git via sa CLI, vous pouvez
utiliser un client visuel comme [GitHub
Desktop](https://desktop.github.com/download/) ou les extensions de votre IDE
(la plupart en ont une par défaut).

> Bien que ces outils soient utiles pour les débutants, beaucoup d’utilisateurs
> du club préfèrent encore la CLI pour ses fonctionnalités avancées. Celle
> intégrée à VSCode est un excellent départ, offrant une GUI tout en permettant
> l’usage de la CLI.

## Outils spécifiques à GitHub

### Issues

L’une des raisons pour lesquelles nous avons choisi GitHub est son suivi des
issues. C’est un moyen de suivre et gérer les bogues ou fonctionnalités à venir
dans un dépôt. On peut assigner un utilisateur, ou commenter une proposition de
correctif.

Ce wiki est hébergé sur notre dépôt **Plateforme-Cedille**. Vous pouvez voir ses
issues [ici](https://github.com/ClubCedille/Plateforme-Cedille/issues).

### Pull requests

Si tout le monde poussait directement ses changements sur le dépôt distant, ce
serait le _chaos_. Une pull request (souvent appelée PR) est un changement
proposé au code, qu’une personne autorisée (comme le capitaine de CEDILLE) peut
fusionner dans la branche principale.

En essayant de faire une PR, vous pourriez rencontrer des **conflits de
fusion**.

### Conflits de fusion

Un conflit de fusion peut survenir lorsqu’on modifie une ligne déjà modifiée par
quelqu’un d’autre. Vous aurez accès à une série d’outils permettant de choisir
quelle version conserver.

### Trucs sympas

- Dépôts modèles (Template Repositories) : créez des modèles de dépôt que
  d’autres développeurs pourront utiliser comme point de départ. Idéal pour des
  projets de base ou partager une configuration commune.

- `readme.md` : ce fichier donne un aperçu d’un projet et explique comment
  l’installer/l’utiliser.

- `.gitignore` : définit les fichiers et répertoires que Git doit ignorer,
  souvent utilisé pour les fichiers à ne pas suivre (ex. fichiers
  d’environnement, artefacts de build, logs).

- Mettre de côté des changements (stashing) : utilisez `git stash` pour
  sauvegarder temporairement vos changements sans les committer. Pratique pour
  changer de branche avec du travail en cours. Pour les récupérer : `git stash
  pop`. [Plus d’infos](https://git-scm.com/docs/git-stash)

- Récupération : si vous perdez un commit ou faites une erreur, `git reflog`
  peut aider à le récupérer en montrant l’historique de toutes vos actions.

- GitHub Actions : des workflows automatiques, souvent utilisés pour tester
  automatiquement, déployer votre code, etc. Pour en savoir plus, voir [ce
  guide](/onboarding/tracks/learn-github-actions/)

Avec vos nouvelles compétences toutes fraîches (d’expert), nous pouvons passer
au premier labo git (et non GitLab) : créez votre propre [GitHub Profile
ReadMe](github_profile.md) !

??? danger "Mais ATTENDEZ ! Qu’est‑ce que c’est ?..." !FLAG-why-are-you-git
    Hmm... Peut‑être qu’en continuant, j’aurai plus d’indices…
