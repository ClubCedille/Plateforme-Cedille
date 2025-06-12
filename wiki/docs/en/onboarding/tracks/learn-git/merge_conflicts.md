

!!! warning "Work in Progress"

    
    
    **Our Pegasuses are tired... Please come back later!**


## 🏗️👷‍♂️🚧🟧🚧🟧🚧🟧🚧🟧🚧🟧🚧🟧🚧👷‍♂️🏗️

<details>

# 🏛️ Lab: Enter the Hall of GitFame

## **Welcome, worthy one.**

This is **OlympGit**, the eternal resting place of the Git Immortals.  
If you master the path of branching, merging, and resolving conflict, your name will be carved at the top — forever.

Your task is to add your name to the Hall of GitFame — **at the top of the list** — like all legends before you.

But beware: **Only the strong survive the merge**.
And **only the wise** 🧙‍♂️ do it through a **Pull Request**.

---

## 📦 Project Structure

This repo contains:

- `main` — neutral base branch (do not modify)
- `olympus` — the sacred branch where Immortals are written
- `HALL_OF_GITFAME.md` — the file where your name will live or die

---

## 🧭 Your Quest

### 1. Clone the Repository

Like the usual, start by cloning the repository.

??? hint "Hint"

    ``` bash
    git clone <repo-url>
    cd hall-of-gitfame
    ```

---

### 2. Check Out the OlympGit Branch

Switch from the `main` branch to the `olympgit` branch.

??? hint "Hint"

    ``` bash
    git checkout olympgit
    git pull origin olympgit
    ```

---

### 3. Create Your Personal Branch from `OlympGit`:

Create your branch under the name of add-your-name. Ex: add-linus-torvalds.

??? hint "Hint"

    ``` bash
    git checkout -b add-<your-name>
    ```

---

### 4. Inscribe to the Hall

Edit `HALL_OF_GITFAME.md`, and insert your name at the top of the list:

!!! warning  "Warning"

    Add your name ON TOP of the Immortals list!

``` diff

## 🧙 Immortals of Git

+- 🛡️ Your legendary name
 - 🧝‍♀️ Ada Lovelace
 - 🧙‍♂️ Linus Torvalds

```

!!! warning "Warning"

    Always add your name to the top of the list. Otherwise a challenger might come to try to steal your place!

---

### 5. Commit Your Changes

Now that you have added your name, let's commit the change to your branch.

??? hint "Hint"

    ``` bash
    git add HALL_OF_GITFAME.md
    git commit -m "feat: add Your Name to Hall of GitFame"
    ```

---

### 6. Push Your Branch to GitHub

Now that you've had your changes done locally, you have to put it on the remote branch.

??? hint "Hint"

    ``` bash
    git push origin add-your-name
    ```

---

### 7. Create a Pull Request (The Final Trial)


Now is the time to create a PR (pull request) on GitHub

??? hint "Hint"

    - Head over to GitHub:

    - You'll see a message: ➕ “Compare & Pull Request” → Click it.

    - Set the base branch to olympgit

    - The compare branch should be your add-your-name branch

    - Add a message like:

            ```
            🏛️ Feat: Add [Your Name] to the Hall of GitFame

            Adding my humble name to the top of the Immortals list.
            Ready to resolve conflicts and claim my place.
            ```

    - Submit the Pull Request


---

### 8. Resolve the Merge Conflict (⚔️ The Git Duel)

If your Pull Request cannot be merged automatically:

1. Click **Resolve conflicts** on GitHub.
2. You’ll see something like:

``` diff
+<<<<<< HEAD
- 🛡️ Hercules
=======
- 🛡️ Your Legendary Name
+>>>>>> add-your-name
```

3. Manually *edit the conflict* to keep all names:

```
- 🛡️ Your Legendary Name
- 🛡️ Hercules
```

4. Click Mark as resolved

5. Commit the merge

---

### 9. Team Review & Approval (The Wisdom Council)

Before your PR can be merged into olympgit, your team captain, mentor, or peer must:

- 👁️ Review your changes

- 💬 Leave comments if anything needs improvement

- ✅ Approve your Pull Request

> ❗ Do not merge your own PR unless explicitly allowed by your instructor or team lead.

If changes are requested:

- Make the required edits in your branch

- Push them again (git push origin add-your-name)

- Your PR will update automatically

---

### 10. Merge the Pull Request (Upon Approval)

Once your PR is:

- ✅ Approved by your reviewer(s)

- ✅ Free of conflicts

Then, and only then:

- Click Squash and Merge

- Confirm the final commit message (or customize it)

---

## Conclusion

🎉 Your name is now inscribed among the Immortals!

### 🧠 What You’ve Learned

- Branching from a shared team branch

- Making isolated changes in a personal branch

- Committing and pushing to remote

- Opening and describing a Pull Request

- Resolving merge conflicts in GitHub

- Merging changes into a shared team branch

🎉 You've now learned how to use branches and Pull Requests to collaborate like a pro! 

Before ending our Git journey together, let's look at the [Git extension in Visual Studio Code](./git_as_extension.md).

!!! note "Note for Devs"

        Using a Dummy Branch for Solo Learners

        * Pre-create a branch called, for example, add-training-dummy from olympgit.

        * In that branch, edit HALL_OF_GITFAME.md and add:

        ```
        - 🛡️ Training Dummy
        ```

        * Push this branch to GitHub, but do NOT merge it.

        In the instructions, have the learner:

        * Branch off of olympgit

        * Add their own name at the top

        * Open a Pull Request to merge into olympgit

        * Then, as the instructor, merge the dummy PR before they do.

        * Now when they go to merge their own PR, GitHub will say:
            ⚠️ “This branch has conflicts that must be resolved”

        🎯 That’s your teaching moment: the learner must fix the conflict in the web editor or locally.


</details>