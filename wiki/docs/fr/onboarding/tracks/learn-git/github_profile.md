# 💻 Lab : README.md du profil GitHub

Bienvenue dans votre premier labo de README de profil GitHub ! Dans ce court tutoriel, vous allez créer un **README de profil GitHub personnalisé et animé** avec de jolis visuels et des statistiques en direct. Votre README de profil est ce que les visiteurs voient lorsqu’ils consultent votre page GitHub — faisons-le ressortir !

---

## Ce qu’est un README de profil GitHub

Lorsque vous créez un dépôt portant **exactement le même nom que votre nom d’utilisateur GitHub**, GitHub considère son `README.md` comme la présentation principale de votre profil.

> Exemple : si votre nom d’utilisateur GitHub est `jonsnow`, créez un dépôt nommé `jonsnow`.

---

## Étape 1 : Créer le dépôt

1. Allez sur [GitHub](https://github.com/)
2. Cliquez sur l’icône ➕ en haut à droite > `New repository`
3. Nom du dépôt : `YourUserName`
4. Cochez `Add a README file`
5. Cliquez sur `Create repository`

---

## Étape 2 : Cloner votre dépôt

### 2.1 Allez dans votre répertoire de travail local

??? tip "Astuce"

    ``` bash

    cd /YourWorkingDirectory  (ex: /home/username/gitrepos/)

    ```

### 2.2. Clonez votre dépôt dans ce répertoire local

??? tip "Astuce"

    ``` bash
    git clone git@github.com/YourUserName/YourUserName
    ```

### 2.3. Ouvrez votre fichier README.md dans votre éditeur de code/texte (ex : VSCode)

## Étape 3 : Copier notre modèle :)

Nous vous laisserons explorer différents designs à l’**Étape 5**, mais pour l’instant commençons avec quelque chose de sympa. Ensuite, vous pourrez ajouter/supprimer des éléments à votre guise.

Copiez le bloc de texte Markdown suivant dans votre fichier README.md dans votre éditeur.

``` markdown

# 👋 Hello, I'm YOUR NAME

![Typing SVG](https://readme-typing-svg.demolab.com/?lines=Passionate+Engineer;Lifelong+Learner;Open+Source+Lover&center=true&width=500&height=50)

---

## 🔧 Technologies & Tools
![Python](https://img.shields.io/badge/-Python-333333?style=flat&logo=python)
![JavaScript](https://img.shields.io/badge/-JavaScript-333333?style=flat&logo=javascript)
![Linux](https://img.shields.io/badge/-Linux-333333?style=flat&logo=linux)

---

## 📈 GitHub Stats
<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=your-username&show_icons=true&theme=radical" alt="GitHub Stats" />
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=your-username&theme=radical" alt="GitHub Streak" />
</p>

---

## 📌 À propos de moi
- 🔭 J’étudie actuellement [DOMAINE D'ETUDES] à l’ÉTS Montréal.
- 🌱 J’apprends actuellement [CHAMPS D’INTÉRÊT]

---

## 🎯 Fun fact
💡 [Fait amusant à propos de vous]

```

## Étape 4 : Modifier votre README.md

Vous pouvez maintenant modifier les informations pour vous correspondre. Voici les principaux changements à faire :

1. Dans le titre, changez « YOUR NAME » pour votre vrai nom.
2. Vous pouvez modifier le texte affiché en cliquant sur le lien et en collant le code Markdown. Cherchez la balise [Typing SVG] dans le fichier Markdown.
3. Pour « Technologies & tools », consultez la liste de badges [ici](https://github.com/inttter/md-badges) et copiez-collez ceux qui correspondent à vos compétences.
4. Dans la section GitHub Stats, assurez-vous de changer « username=… » et « user=… » pour votre vrai nom d’utilisateur GitHub.
5. Dans la section « À propos de moi », ajoutez votre domaine d’étude et vos champs d’intérêt.
6. Section Fun Fact : optionnelle, vous pouvez la retirer si vous voulez.


## Étape 5 : Explorer le dépôt d’inspiration

Visitez [awesome-github-profile-readme](https://github.com/abhisheknaiidu/awesome-github-profile-readme) pour explorer :

- 🪄 **General Profile Sections** (headers, bios, skills, etc.)
- 📊 **Stats & Contributions**
- 🎞️ **GIFs and Animations**
- 💼 **Work and Project Showcases**
- 🧠 **Learning & Tech Stack**
- 🎯 **Goals and Fun Facts**

Vous pouvez choisir quelques sections qui vous plaisent, mais on verra cela plus tard. Il est temps de mettre à jour notre README.md sur GitHub !

---

## Étape 6 : Mettre à jour vos modifications

Il est maintenant temps de mettre à jour nos modifications.

Rappelez-vous, pour mettre à jour vos changements, vous devez :

1. Stage your changes.
2. Commit your changes.
3. Push your changes.

C’est assez intuitif dans l’extension VSCode. Cependant, nous voulons que vous le fassiez avec la CLI :

??? tip "Hint"

    ``` bash

    git add .
    git commit -m "Changes Title"
    git push origin main

    ```

## Étape 7 : Vérifier le résultat

Allez sur votre page de profil GitHub : <https://github.com/YourUserName>

Profitez du résultat !

## Prochain chapitre - Gestion Git multiutilisateurs (Gestion d’équipe)

Félicitations pour votre premier workflow git **_réel_**.

Maintenant, il est temps d’exploiter la vraie puissance de Git : le développement en équipe.

On se retrouve dans la [prochaine section](team_collaboration.md) !


??? danger "NE CLIQUEZ PAS ICI !"

    Je me demande ce que c’est…

    #!FLAG-git-good-at-profiles

    Peut-être qu’on trouvera tout le sens à la toute fin de ce parcours… Continuons !
