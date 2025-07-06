# Your first steps with Git/Github

## Using Git

### 1. Download Git CLI

First, you need to
[download the Git Command-Line Interface](https://git-scm.com/downloads).

### 2. Set up Git

Once installed, configure your Git credentials with these commands:

```bash
git config --global user.name "Your Name"
git config --global user.email "yourEmail@example.com"
```

### 3. Authenticate with Github

We need to authenticate our local computer with our account over at Github.
Multiple ways are available, but we prioritise SSH since it is the most secure.

For this step, please head over to
[this page](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
for everything you'll need to setup SSH. Ignore the part about hardware security
key.

!!! note "Note"

```text
Keep in mind, if you put a password for your private SSH key, it will ask you to put it every time you interact with the remote repository - that means for fetch, push, pull and other actions (which we will see right now). Do not fall in the same trap as the editor of this tutorial. :(
```

!!! warning "WARNING"

```text
_Please complete the SSH setup before proceeding any further. We want you to learn to clone and interact with the repository through SSH, and not HTTPS_!!
```

### 4. Clone a repository

It is now time to start working on a repo ! You can clone your own default repo,
and we will add stuff to your `readme.md`. _Make sure to execute this command
where you want to add your local repo_.

```bash
git clone git@github.com:YourUsename/YourUsername.git
```

### 5. Adding a file to the repo

While being in your local repo, create a new file :

| Linux           | Windows                  |
| --------------- | ------------------------ |
| `touch test.md` | `echo test123 > test.md` |

Let's now add your file to be tracked by Git:

```bash
git add test.md
```

### 6. Commit changes

Add some text to `test.md` and commit them to the history using:

```bash
git commit -m "Added some text"
```

The `-m "Added some text"` is an option to add a message along with your commit.
It is required in our case.

### 7. Push changes

After a couple of commits, you would want to share them with everyone by pushing
them to the remote repo.

```bash
git push origin main
```

> `origin` refers to the remote repository. `git remote -v` to view existing
>
> remotesm and `git remote add <name> <url>` to add a new remote. By default,
> the first remote is named origin.
>
> `main` is the branch you’re pushing to.

You can now head over to _github.com/YourUsername/YourUsername.git_ to see
your new files added to the remote repo.

### 8. Pull new changes

While on the Github website, add a new file to your remote repo using the button
on the top left. As you'll see, it won't be synchronised with your local repo,
unless you use the following:

```bash
git fetch origin main
git pull origin main
```

> `git fetch` is optional and let's you know what new changes are available
>
> before using `git pull` to retrieve them.

---

Now that you've learn the basics of using Git through its CLI, you may now use a
visual client such as [Github Desktop](https://desktop.github.com/download/) or
the extensions in your IDE (Most of them have one installed by default.).

> While these tools are useful for beginners, a lot of users in the club still
>
> prefer to use the CLI for its advanced functionnality. The one integrated in
>
> VSCode is a great started, as it provides a GUI, while also having the
>
> possibility of using CLI.

## Github specifics tools

### Issues

A big part of why we chose Github is because of its issue tracking. It is a way
to track and manage bugs or upcoming features within a repo. We may assign a
user to it, or add a comment to someone's suggested fix.

This wiki is hosted on our repo **Plateforme-Cedille**. You can see its issues
[over here](https://github.com/ClubCedille/Plateforme-Cedille/issues).

### Pull requests

If anyone started pushing their changes into the remote repo, it would become
_chaos_. A pull request (often called a PR) is a proposed change to the
codebase, which an approved user (such as the captain of CEDILLE) may pull into
the main branch.

While trying to do a PR, you may get **merge conflicts**

### Merge conflicts

A merge conflict can happen when trying to change a line somebody else has
changed. You will have access to a suite of tools that lets you choose between
which version you want to keep.

### Cool stuff

- Template Repositories: Create repository templates that other developers can
  use as a starting point. This is great for boilerplate projects or when you
  want to share a common setup.

- `readme.md`: This file gives an overview of a projects and how to install/use
  it.

- `.gitignore`: Defines which files and directories Git should ignore, often
  used for files that should not be tracked (Ex. environment files, build
  outputs and logs)

- Stashing changes: Use `git stash` to temporarily save your changes without
  committing them. This is handy when you need to switch branches but have
  uncommitted work. To retrive them, you may use `git stash pop`.
  [More information](https://git-scm.com/docs/git-stash)

- Recovery: If you ever lose a commit or make a mistake, `git reflog` can help
  you recover it by showing a history of all actions you have executed.

- Github Actions: Actions are automatic workflows, which are often used to
  automatically test for bugs, deploy your code etc. For more, see
  [this guide](/onboarding/tracks/learn-github-actions/)

With your new, fresh, amazing, (expert), skills in git, we can now proceed to
the first git lab (and not GitLab) : Creat your own
[Github Profile ReadMe](github_profile.md) !

??? danger "But WAIT! What is that?..."

```text
!FLAG-why-are-you-git

Hmm...Maybe if I keep going, I'll get more clues...
```
