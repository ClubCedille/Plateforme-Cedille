# 💻 Lab: GitHub Profile ReadMe

Welcome to your first GitHub Profile README Lab! In this short tutorial, you will create a **personalized and animated GitHub profile README** that includes cool visuals and live stats. Your profile README is what visitors see when they visit your GitHub page — so let’s make it stand out!

---

## What a GitHub Profile README Is

When you create a repository with the exact **same name as your GitHub username**, GitHub will treat its `README.md` as the main presentation of your profile.

> Example: If your GitHub username is `johndoe`, create a repo named `johndoe`.

---

## Step 1: Create the Repository

1. Go to [GitHub](https://github.com/)
2. Click the ➕ icon in the top right corner > `New repository`
3. Repository name: `YourUserName`
4. Check `Add a README file`
5. Click `Create repository`

---

## Step 2: Clone your Repository

### 2.1. Go to your working local directory.

<details>
    <summary> Hint </summary>

```bash

cd /YourWorkingDirectory  (ex: /home/username/gitrepos/)

```

</details>

### 2.2. Clone your repository to that local directory

<details>
    <summary> Hint / Hax / Cheatcode </summary>

`git clone git@github.com/YourUserName/YourUserName`

</details>

### 2.3. Open your README.md file in your code/text editor (ex: VSCode)

## Step 3: Copy our template :)

We will leave you to explore many different designs on **Step 5**, but for now we want to get started with someone nice. Then, you can add/remove elements as you see fit.

Copy the following block of Markdown text to your README.md file in your code/text editor.

```markdown

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

## 📌 About Me
- 🔭 I’m currently studying [DOMAINE D'ETUDES] at ETS Montréal.
- 🌱 I’m currently learning [FIELDS OF INTEREST]

---

## 🎯 Fun Fact
💡 [Fun fact about yourself]

```

## Step 4: Edit Your README.md

You can now edit the informations to suit you. Here are the main changes you need make:
0. In the title, change "YOUR NAME" to your actual name.
1. You can edit the text displayed but clicking on the link and pasting the Markdown code. Look the [Typing SVG] tag in the Markdown file.
2. For the "Technologies & tools", you can look through the list of badges [here](https://github.com/inttter/md-badges) and copy-paste the ones that fits your skills.
3. In the GitHub Stats section, make sure to change the "username=..." & "user=..." to your actual username in GitHub.
4. In the About me section, you can add your field of study and your field of interest.
5. Fun Fact section : optional, you can remove it if you want.


## Step 5: Explore the Inspiration Repository

Visit [awesome-github-profile-readme](https://github.com/abhisheknaiidu/awesome-github-profile-readme) to explore:

- 🪄 **General Profile Sections** (headers, bios, skills, etc.)
- 📊 **Stats & Contributions**
- 🎞️ **GIFs and Animations**
- 💼 **Work and Project Showcases**
- 🧠 **Learning & Tech Stack**
- 🎯 **Goals and Fun Facts**

You can pick a few sections that you like, but we'll leave that to later. Now is time to update our README.md on GitHub!

---

## Step 6: Update Your Changes

Now is time to update our changes.

Now, remember, to update your changes, you need to:

1. Stash your changes.
2. Commit your changes.
3. Push your changes.

It's pretty intuative in the VSCode extension. However, we want you to guess on the CLI:

<details>
<summary> Hint </summary>

```bash

git stash
git commit -m "Changes Title"
git push origin main

```

</details>


## Step 7: Check the Results!

Go to your GitHub profile page: https://github.com/YourUserName

Enjoy the result!

## Next Chapter - Multiuser Git Management (Team Management)

Congratulations on doing your first **_real_** git workflow.

Now, it's time to harness the real power of Git : Team Development.

Let's meet again in the [next section](multi_user_collaboration.md) !


<details>
<summary> DO NOT CLICK ON THIS!</summary>

    I wonder what that is...

    #!FLAG-git-good-at-profiles

    Maybe we'll find all the meaning at the very end of this track... Let's keep going!

</details>
