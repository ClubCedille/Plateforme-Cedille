

!!! warning "Travail en cours"

    
    
    **Nos Pégases sont fatigués... Revenez plus tard !**


## 🏗️👷‍♂️🚧🟧🚧🟧🚧🟧🚧🟧🚧🟧🚧🟧🚧👷‍♂️🏗️

<details>

# 🏛️ Labo : Entrer dans le Hall of GitFame

## **Bienvenue, digne élu·e.**

Voici **OlympGit**, le lieu de repos éternel des Immortels de Git.  
Si tu maîtrises l’art de créer des branches, fusionner et résoudre les conflits, ton nom sera gravé tout en haut — pour toujours.

Ta tâche est d’ajouter ton nom au Hall of GitFame — **en haut de la liste** — comme toutes les légendes avant toi.

Mais prends garde : **Seuls les plus forts survivent à la fusion**.
Et **seuls les sages** 🧙‍♂️ le font via une **Pull Request**.

---

## 📦 Structure du projet

Le dépôt en question contient :

- `main` — branche de base neutre (ne pas modifier)
- `olympus` — la branche sacrée où sont inscrits les Immortels
- `HALL_OF_GITFAME.md` — le fichier où ton nom vivra ou mourra

---

## 🧭 Ta quête

### 1. Cloner le dépôt

Comme d’habitude, commence par cloner le dépôt.

??? hint "Astuce"

    ``` bash
    git clone git@github.com:
    cd hall-of-gitfame
    ```

---

### 2. Passer sur la branche OlympGit

Bascule de la branche `main` à la branche `olympgit`.

??? hint "Astuce"

    ``` bash
    git checkout olympgit
    git pull origin olympgit
    ```

---

### 3. Créer ta branche personnelle depuis `olympgit`

Crée ta branche sous le nom add-your-name. Ex : add-linus-torvalds.

??? hint "Astuce"

    ``` bash
    git checkout -b add-<your-name>
    ```

---

### 4. T’inscrire au Hall

Modifie `HALL_OF_GITFAME.md` et insère ton nom en haut de la liste :

!!! warning  "Attention"

    Ajoute ton nom EN HAUT de la liste des Immortels !

``` diff

## 🧙 Immortals of Git

+- 🛡️ Your legendary name
 - 🧝‍♀️ Ada Lovelace
 - 🧙‍♂️ Linus Torvalds

```

!!! warning "Attention"

    Ajoute toujours ton nom en haut de la liste. Sinon, un challenger pourrait venir tenter de te voler ta place !

---

### 5. Valider tes changements

Maintenant que tu as ajouté ton nom, validons le changement sur ta branche.

??? hint "Astuce"

    ``` bash
    git add HALL_OF_GITFAME.md
    git commit -m "feat: add Your Name to Hall of GitFame"
    ```

---

### 6. Pousser ta branche vers GitHub

Maintenant que tes changements sont faits en local, il faut les envoyer sur la branche distante.

??? hint "Astuce"

    ``` bash
    git push origin add-your-name
    ```

---

### 7. Créer une Pull Request (l’Épreuve finale)


C’est le moment de créer une PR (pull request) sur GitHub.

??? hint "Astuce"

    - Va sur GitHub :

    - Tu verras un message : ➕ « Compare & Pull Request » → Clique dessus.

    - Mets la base branch sur olympgit

    - La compare branch doit être ta branche add-your-name

    - Ajoute un message comme :

            ```
            🏛️ Feat: Add [Your Name] to the Hall of GitFame

            Adding my humble name to the top of the Immortals list.
            Ready to resolve conflicts and claim my place.
            ```

    - Soumets la Pull Request


---

### 8. Résoudre le conflit de fusion (⚔️ Le duel Git)

Si ta Pull Request ne peut pas être fusionnée automatiquement :

1. Clique sur **Resolve conflicts** sur GitHub.
2. Tu verras quelque chose comme :

``` diff
+<<<<<< HEAD
- 🛡️ Hercules
=======
- 🛡️ Your Legendary Name
+>>>>>> add-your-name
```

3. *Modifie manuellement le conflit* pour garder tous les noms :

```
- 🛡️ Your Legendary Name
- 🛡️ Hercules
```

4. Clique sur Mark as resolved

5. Commit la fusion

---

### 9. Revue d’équipe et approbation (Le Conseil de Sagesse)

Avant que ta PR puisse être fusionnée dans olympgit, ton chef d’équipe, mentor ou pair doit :

- 👁️ Revoir tes changements

- 💬 Laisser des commentaires si quelque chose doit être amélioré

- ✅ Approuver ta Pull Request

> ❗ Ne fusionne pas ta propre PR sauf autorisation explicite de ton formateur ou chef d’équipe.

Si des changements sont demandés :

- Fais les modifications requises dans ta branche

- Pousse‑les à nouveau (git push origin add-your-name)

- Ta PR se mettra à jour automatiquement

---

### 10. Fusionner la Pull Request (après approbation)

Une fois que ta PR est :

- ✅ Approuvée par ton ou tes réviseur(s)

- ✅ Sans conflits

Alors, et seulement alors :

- Clique sur Squash and Merge

- Confirme le message de commit final (ou personnalise‑le)

---

## Conclusion

🎉 Ton nom est maintenant inscrit parmi les Immortels !

### 🧠 Ce que tu as appris

- Partir d’une branche d’équipe partagée

- Faire des changements isolés dans une branche personnelle

- Committer et pousser vers le dépôt distant

- Ouvrir et décrire une Pull Request

- Résoudre des conflits de fusion sur GitHub

- Fusionner des changements dans une branche d’équipe partagée

🎉 Tu sais maintenant utiliser les branches et les Pull Requests pour collaborer comme un pro !

Avant de conclure notre parcours Git, jetons un œil à [l’extension Git dans Visual Studio Code](./git_as_extension.md).

!!! note "Note pour les devs"

    Utiliser une branche factice pour les apprenants solo

    * Pré-créer une branche appelée, par exemple, add-training-dummy à partir de olympgit.

    * Dans cette branche, modifiez HALL_OF_GITFAME.md et ajoutez :

        ```
        - 🛡️ Training Dummy
        ```

    * Poussez cette branche vers GitHub, mais ne la fusionnez PAS.

    Dans les instructions, demandez à l’apprenant :

    * De partir de olympgit

    * D’ajouter son propre nom en haut

    * D’ouvrir une Pull Request pour fusionner dans olympgit

    * Ensuite, en tant qu’instructeur, fusionnez la PR factice avant lui.

        * Lorsqu’il tentera de fusionner sa propre PR, GitHub indiquera :
            ⚠️ « This branch has conflicts that must be resolved »

    🎯 C’est le moment pédagogique : l’apprenant doit corriger le conflit dans l’éditeur web ou en local.


</details>