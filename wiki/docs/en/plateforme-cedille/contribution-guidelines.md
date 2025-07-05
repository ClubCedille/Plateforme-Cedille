# Contribution Guide

Welcome to the CEDILLE platform contribution guide! This document provides
information on how you can contribute to the CEDILLE platform, including best
practices, contribution guidelines, and useful resources.

## Prerequisites

Before you start contributing to the CEDILLE platform, make sure you meet the
following prerequisites:

1. **GitHub Account**: You will need a GitHub account to contribute to the
   project.
2. **Join our [GitHub organization](https://github.com/clubcedille/)**: To
   access the CEDILLE platform repositories, you must join the CEDILLE club
   GitHub organization. To do so, ask a team member to invite you to join the
   organization.
3. **Backlog Board**: In the
   [**Projects**](https://github.com/orgs/ClubCedille/projects) tab of the
   CEDILLE club GitHub repository, you will find a backlog board organized to
   facilitate task and project management. This board provides an overview of
   available tasks, categorized by types such as features to develop, bugs to
   fix, or improvements to make. Each task includes a description, priority, and
   sometimes an estimated time requirement. You can review this board to
   identify tasks that match your skills or interests and choose the ones you
   want to work on. This approach allows you to contribute autonomously while
   ensuring that projects advance in a coherent and organized manner.

## How to Contribute to Various Projects ✍️

To contribute to one of our projects, follow the steps below and send us your
GitHub username to be added to our organization:

1. **Clone the Project Locally**: Use the `git clone` command to clone the
   project to your machine. Example:
   `sh git clone https://github.com/ClubCedille/cedille.etsmtl.ca.git ` This
   command downloads a complete copy of the repository to your local machine,
   allowing you to work offline.

2. **Open the Project with Your IDE**: Use your preferred IDE to open the cloned
   project. An IDE (Integrated Development Environment) such as Visual Studio
   Code, IntelliJ IDEA, or others will help you edit the code and manage your
   changes more effectively.

3. **Create a New Branch**: Before you start working on changes, create a new
   branch for your contributions using the command:
   `sh git branch [branch_name] ` Then switch to this branch with:
   `sh git checkout [branch_name] ` Creating branches allows you to work on
   specific features or fixes without affecting the main branch of the project.

4. **Make Your Changes**: Make the necessary changes in your development
   environment. After finishing, save your changes with the command:
   `sh git commit -am “describe your changes here” ` It is important to write
   clear and descriptive commit messages to facilitate understanding of the
   changes made.

5. **Push Your Branch**: Push your branch to the remote repository using:
   `sh git push -u origin [branch_name] ` The `-u` flag configures the local
   branch to track the remote branch, making future synchronizations easier.

6. **Open a Pull Request**: On the GitHub site, navigate to your branch and
   click on “New pull request” to open a new request. Fill out the Pull Request
   template with a brief description of your changes and submit it for review.
   Be sure to select at least one club member to review the request.

7. **Review and Merge**: Once the Pull Request has been reviewed and approved,
   merge the branch into the main branch using one of the following options:
   - **Manual merge via the git command line**:
     ```sh
     git merge [branch_name] --no-ff
     ```
   - **Merge via the GitHub user interface**: On the Pull Request page, use the
     appropriate button that will appear once your commit has been approved.

     ![Pull Request](img/pullRequest.png)

8. **Keep Your Copy Up-to-Date**: Before starting work, make sure to pull the
   latest changes from the project using: `sh git pull origin main ` This
   ensures you are working with the most recent version of the code and avoids
   merge conflicts.

9. **Use Graphical Tools if Needed**: If you find the command line difficult to
   manage, consider using a graphical git interface like GitKraken or
   SourceTree. These tools provide a visual interface for managing your commits,
   branches, and Pull Requests, making code management more intuitive.
