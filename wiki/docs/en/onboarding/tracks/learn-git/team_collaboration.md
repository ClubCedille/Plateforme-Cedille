# 🌿 Git Tutorial: Branching from a Branch and Merging via Pull Request

This tutorial teaches you how to:

1. ✅ Branch out from an existing feature branch
2. ✏️ Work on a sub-feature
3. 🔄 Open a Pull Request (PR) to merge it back into the original feature branch

It's designed for **beginners** using the Git CLI and GitHub.

---

## 🧠 What is Branching?

**Branching** in Git is like creating a parallel universe of your code, where
you can work freely without affecting the original project.

It allows you to:

🌿 Create a separate space to develop new features 🧪 Experiment or fix bugs
without breaking anything 👨‍👩‍👧‍👦 Collaborate with others working on different tasks
🔁 Merge your work back into the main branch when it's ready

Each branch starts from a specific point (usually `main` or another feature) and
evolves independently. This way, teams can work **simultaneously and safely** on
many parts of a project.

> 🔐 Branching is the foundation of collaborative development. Without it,
> everyone would be working on the same files at the same time — leading to
> chaos and lost work.

---

## 🧠 What is a Pull Request?

A **Pull Request (PR)** is a request to merge your branch into another branch
(like `main`, `develop`, or another feature). It allows others to:

- 👀 Review your code
- 🧪 Run automated tests
- 💬 Leave comments or suggestions
- ✅ Approve the changes

> 🔐 PRs are essential for **code quality**, **team communication**, and
> **avoiding broken code in production**.

---

## 🌐 Why Branching and Pull Requests Are Critical

![Git branching diagram](./img/team_collab.png)

This diagram shows a typical situation in a team project:

- 🟢 `Master` (or `main`) is the **stable production-ready code**.
- 🔵 **Your Work** is done on a separate feature branch.
- 🟠 **Someone Else’s Work** happens independently, also on a separate branch.

Without branches and Pull Requests, all work would be done **on the same
timeline, in the same files**, which would lead to:

- 🔥 Conflicts
- 🐛 Bugs being merged unintentionally
- ❌ Loss of stable code

---

### ✅ How Branches Help

- You isolate your changes from others.
- You can work freely without affecting the `main` code.
- You reduce the risk of breaking things for the team.
- You can test and experiment in your branch safely.

---

### ✅ How Pull Requests Help

- You get your code **reviewed** before merging.
- GitHub shows **conflicts automatically**, so you can fix them before it's too
  late.
- You have a **discussion space** around your code.
- You keep `main` clean and stable at all times.

> 💡 Think of branches as your "workbench" and PRs as the "quality gate" before
> putting your work on the team’s final product.

---

### 🔁 What This Diagram Represents

- **You** and **someone else** branched off `master` at the same time.
- You both worked independently on your own features.
- You merged your work back through PRs (ideally).
- The `master` stays clean and up-to-date, with minimal conflict.

---

## Typical Workflow

Here's how someone would generate proceed in order to work on a feature in
parallel:

1. Start from your main feature branch

2. Create a sub-feature branch

3. Make your changes

4. Push to GitHub git push origin feature/header-component

5. Go to GitHub and create a Pull Request targeting feature/main-layout

6. After approval, merge using GitHub’s interface

7. Clean up

Here's a more detailed step-by-step tutorial on how to do it.

---

!!! warning "FOR READING ONLY"

```text
**ALL THE NEXT POINTS DESCRIBED ARE MEANT TO BE READ, NOT DONE. YOU WILL PRACTICE THEM IN THE LAB.**
```

---

## 🧩 Scenario

You're working on a larger feature: `feature/main-layout` You want to create a
sub-feature: `feature/layout-component` You’ll merge it back via a Pull Request
— not locally.

---

## 📦 Step 1: Go to Your Project Folder

```bash
cd path/to/your/project
```

If you haven’t cloned the project yet:

```bash
git clone git@github.com:your-team/project-name.git
cd project-name
```

---

## 🔀 Step 2: Switch to the Base Branch

This is the feature you're building on top of.

```bash
git checkout feature/main-layout
git pull origin feature/main-layout
```

---

## 🌱 Step 3: Create a New Branch from It

```bash
git checkout -b feature/layout-component
```

📌 You're now working **on a new branch based on `feature/main-layout`**.

---

## ✏️ Step 4: Make Changes to the Code

Use your favorite editor (VSCode, etc.) to:

- Add your new feature or fix
- Save your files

---

## ✅ Step 5: Add and Commit Your Changes

```bash
git add .
git commit -m "feat: add new layout component"
```

> 💡 Commit messages should be meaningful. Use formats like `feat:`, `fix:`,
> `docs:`, etc.

---

## ☁️ Step 6: Push Your Branch to GitHub

```bash
git push origin feature/layout-component
```

You’ve now published your branch online and it’s ready for review.

---

## 🔁 Step 7: Open a Pull Request

1. Go to your repository on [GitHub](https://github.com)
2. You’ll see a prompt: ➕ **Compare & pull request** → Click it
3. Set the **base branch** as `feature/main-layout`
4. Set the **compare branch** as `feature/layout-component`
5. Add a **clear title and description**
6. Click **Create pull request**

> 🧠 Don’t forget to write what your code does and why you made these changes.

---

## 👀 Step 8: Get Your PR Reviewed

Your teammates can now:

- Review your code
- Comment or suggest improvements
- Approve or request changes

If someone requests changes:

```bash
# Make the edits
git add .
git commit -m "fix: adjust component"
git push origin feature/layout-component
```

The PR will update automatically.

---

## 🔀 Step 9: Merge the Pull Request

Once approved and ready:

1. Go to the PR on GitHub
2. Click **Squash and merge** or **Rebase and merge**
3. Confirm the merge

✅ Your code is now merged into `feature/main-layout`.

---

## 🧹 Step 10: Clean Up Old Branches

After merging:

```bash
git branch -d feature/layout-component           # delete local
git push origin --delete feature/layout-component  # delete remote
```

---

## 📘 Full Recap: PR-Based Feature Flow

```bash
# Start from your main feature branch
git checkout feature/main-layout
git pull origin feature/main-layout

# Create a sub-feature branch
git checkout -b feature/layout-component

# Make your changes
git add .
git commit -m "feat: add component"

# Push to GitHub
git push origin feature/layout-component

# → Go to GitHub and create a Pull Request targeting feature/main-layout

# After approval → merge using GitHub’s interface

# Clean up
git branch -d feature/layout-component
git push origin --delete feature/layout-component
```

---

## Next Section - Lab: Hall of GitFame

Now you've had a guide on how to collaborate on a project with a team using Git,
let's put that to practice with the **[OLYMPGIT](./merge_conflicts.md)**.

!!! warning "BUT WAIT"

```text
**I think the Hall of GitFame is under renovation... I've seen so many
orange cones on the entrance. Maybe we should just skip by! - (yes, just
skip it, it's not done yet...)**
```
