# 🖥️ Git in Visual Studio Code: A Beginner-Friendly Interface

While the **Git CLI** is powerful, it can feel overwhelming for beginners.
**Visual Studio Code (VSCode)** offers a built-in **Git extension** that
simplifies most Git operations with a clean and visual workflow.

This guide highlights how to perform essential Git tasks in VSCode, and how it
compares to the command line.

---

## 📄 File Status & Git Sidebar

- Click the **Source Control icon** on the left sidebar.
- VSCode displays:
  - Modified files
  - Staged changes
  - Untracked files
  - Conflicts (with markers)

> ✅ You can **stage** files with a simple click ➕, and **discard** changes
> with a trash icon.

---

## ✅ Committing Changes

**CLI:**

```bash
git add .
git commit -m "Your message"
```

VSCode:

    You can stage them all with the + sign or press on the commit button.

![Stage_and_commit](./img/stage_and_commit.png)

> 💡 VSCode also highlights changes line-by-line, letting you commit file chunks
> ("hunks") individually.

## 🚀 Pushing to GitHub

CLI:

```bash
git push origin your-branch
```

VSCode:

    After committing, click the … menu in the Source Control tab → Push

    Or click the sync icon (🔄) in the status bar

![Push_sync](./img/push_sync.png)

## ⬇️ Pulling Latest Changes

CLI:

```bash
git pull origin main
```

VSCode:

    Click … → Pull

![pull](./img/pull.png)

    Or click the sync icon in the bottom-left corner

![sync_bottom](./img/sync_bottom.png)

    Conflicts, if any, will be visually flagged in the editor

## 🔄 Fetching (Without Merging)

CLI:

```bash
git fetch
```

VSCode:

    Use … → Fetch to retrieve remote updates without merging them automatically

![fetch](./img/fetch.png)

> 🧠 Useful for previewing changes before pulling.

## 🌿 Creating a New Branch

CLI:

```bash
git checkout -b feature/branch-name
```

VSCode:

    Click on the branch name in the bottom-left corner

![branch_bottom](./img/branch_bottom.png)

    Select Create New Branch…  ![create_branch](./img/create_branch.png)

    Enter a name and select the base branch (usually main)

![branch_name](./img/branch_name.png)

## 🔁 Switching Branches

CLI:

```bash
git checkout branch-name
```

VSCode:

    Click the branch name in the bottom-left corner

    Select the branch you want from the dropdown list

![switch_branches](./img/switch_branches.png)

> 🔄 No need to remember branch names — they're listed for you.

## 🧹 Deleting a Branch

CLI:

```bash
git branch -d branch-name
git push origin --delete branch-name
```

VSCode:

    Go to Source Control → ... → Branch ![del_branch](./img/del_branch_1.png)

    Branch → Delete Branch...  ![del_branch_2](./img/del_branch_2.png)

> ⚠️ VSCode will ask for confirmation before deleting locally or remotely.

## 🔀 Merging Branches

CLI:

```bash
git checkout target-branch
git merge source-branch
```

VSCode:

    Go to Source Control → ... → Branch

![merge_branch_1](./img/del_branch_1.png)

    Branch → Merge...  ![merge_branch](./img/merge_branch.png)

> 📌 VSCode alerts you about incoming conflicts and allows side-by-side
> resolution.

## ⚔️ Resolving Merge Conflicts

VSCode shines here with visual tools:

- Conflicting lines are highlighted with:

```diff
+ <<<<<<< HEAD
your changes
=======
incoming changes
+ >>>>>>> other-branch
```

- Buttons appear above: Accept Current, Accept Incoming, Accept Both, or
  Compare.

This makes conflict resolution much more manageable than the CLI.

## Conclusion

VSCode makes Git accessible and visual — perfect for beginners

You can still use the Git CLI at any time via the built-in terminal

Learn the CLI eventually, but let VSCode guide your workflow early on.

We're at the end, go to the [next page](./git_complete.md).
