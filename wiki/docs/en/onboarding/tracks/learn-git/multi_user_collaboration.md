# 🤝 Lab: Collaborative Development with Git (Multi-User)

This lab will teach you how to **collaborate on Git projects with multiple developers** using the best practices to avoid conflicts, maintain clean branches, and contribute effectively in a team setting.

---

## 🧠 Objectives

By the end of this lab, you will know how to:
- Use branches to work in parallel
- Sync and manage changes without conflicts
- Perform pull requests (PRs) for clean integration
- Resolve conflicts (if they happen)
- Follow proper commit and collaboration etiquette

---

## ⚙️ Prerequisites

- Git installed on your machine
- A GitHub account
- A shared repository (your own or a team project)

---
## 1. Principles

Here are the core principles of team development:

### 1.1. One feature = one branch

Each task, feature or bug fix gets its own branch.

The branches name follow a naming convention that follows this syntax:

`type/name`

Examples:

- `feature/login-form`
- `fix/404-error`
- `hotfix/crash-homepage`



---

## 🌳 Step 1: Clone the Repository

Start by cloning the remote repo locally.

<details>
    <summary> Hint </summary>

```bash
git clone git@github.com:your-team/project-name.git
cd project-name
```

This creates a local copy of the project where you'll do your work.

</details>

## 🌱 Step 2: Create a New Branch

Always work on a separate branch. Do not work directly on the main (or master) branch. This also applies in the situation where you're working on a feature, you have to branch out from that feature/branch. Let's do that now.

```bash
git checkout -b your
```

```bash
git add .
git commit -m "feat: Add responsive login form component"
```
