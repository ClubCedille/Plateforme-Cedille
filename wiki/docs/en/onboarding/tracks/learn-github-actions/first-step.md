# Getting Started with GitHub Actions

GitHub Actions is an integrated platform that enables you to create, run, and
automate workflows directly within GitHub. In this section, we will explore how
to set up a basic workflow, understand the YAML syntax used to define these
workflows, and discover the various available event triggers.

---

## 1. Basic Setup: `.github/workflows`

To start using GitHub Actions, you need to create a specific directory in your
GitHub repository to store your workflow files. This directory should be named
**`.github/workflows`**.

### Steps to create your first workflow
1. **Create the directory**: In the root of your project, create the
   `.github/workflows` directory.
2. **Add a workflow file**: Workflows are defined in YAML files (with the `.yml`
   extension). For example, you can create a file named `ci.yml` for a CI
   workflow.

### Example of a repository structure with a workflow

```text
my-project/
├── .github/
│   └── workflows/
│       └── ci.yml
├── src/
├── README.md
└── package.json
```

The workflow file contains all the steps that GitHub Actions must execute when
an event is triggered, such as a `push` or `pull request`. This YAML file
specifies the jobs, actions, and other parameters that form the basis of your
CI/CD pipeline.

---

## 2. Simple Example of a CI Workflow

Here is a simple CI workflow example that runs every time a change is pushed to
the `main` branch. This workflow installs dependencies, runs tests, and builds
the project.

```yaml
name: CI Pipeline  # Workflow name

# This workflow is triggered on a push or pull request to the 'main' branch
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:  # Job name
    runs-on: ubuntu-latest  # Environment where the job runs

    steps:
      # Step 1: Check out the source code
      - name: Checkout repository
        uses: actions/checkout@v2

      # Step 2: Set up Node.js
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      # Step 3: Install dependencies
      - name: Install dependencies
        run: npm install

      # Step 4: Run tests
      - name: Run tests
        run: npm test

      # Step 5: Build the project
      - name: Build project
        run: npm run build
```

### Explanation
- **`name:`**: Gives a name to the workflow. This name is visible in the GitHub
  Actions interface.
- **`on:`**: Specifies the events that trigger the workflow. In this example,
  the workflow runs when there is a `push` or `pull request` on the `main`
  branch.
- **`jobs:`**: Defines the different jobs in the workflow. Each job can contain
  multiple steps.
- **`runs-on:`**: Indicates the environment where the job will be executed
  (here, an Ubuntu machine hosted by GitHub).
- **`steps:`**: Steps to execute within the job, which may include pre-built
  actions (such as `actions/checkout@v2`) or commands to run.

---

## 3. YAML Syntax for Defining Workflows

GitHub Actions workflows are written in YAML, a format that is simple to read
and write, allowing you to structure workflows with jobs, steps, actions, and
variables. Here is a detailed explanation of the basic syntax for GitHub Actions
YAML files.

### General Structure of a GitHub Actions YAML File
```yaml
name: Workflow name

on:  # Event trigger(s)
  push:
    branches:
      - main

jobs:  # Jobs to execute
  job_name:  # Job name
    runs-on: environment  # Execution environment (e.g., ubuntu-latest, windows-latest, macos-latest)

    steps:  # Steps to execute within this job
      - name: Step name
        uses: action@version  # Using a pre-defined action
        with:  # Arguments passed to the action
          param: value

      - name: Step name
        run: shell_command  # Shell command to execute
```

### Common YAML Elements
- **`name:`**: Workflow name.
- **`on:`**: Events that trigger the workflow, such as `push`, `pull_request`,
  `schedule`, or others.
- **`jobs:`**: Defines the jobs, which contain steps to execute.
- **`runs-on:`**: Specifies the execution environment for the job (e.g.,
  `ubuntu-latest`, `windows-latest`, `macos-latest`).
- **`steps:`**: Steps in a job, which can include pre-defined actions or custom
  commands to execute.

### Examples of Steps
1. **Using a Predefined Action**:
```yaml
   - name: Checkout code uses: actions/checkout@v2 ``` Here, we use the
     `actions/checkout@v2` action to retrieve the repository’s source code.
```
2. **Running a Custom Command**:
```yaml
   - name: Run tests run: npm test
```
   This step runs the `npm test` command to
     execute the project's tests.

---

## 4. Triggers (events): `push`, `pull_request`, `schedule`, etc.

GitHub Actions workflows can be triggered by a variety of events. Here are the most common triggers:

### 4.1. `push`

The `push` trigger is used to run a workflow whenever a `push` is made to the repository. You can also specify specific branches or paths for which the workflow should run.

#### Example
```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'src/**'
```
- **`branches:`**: The workflow will trigger only when changes are pushed to the
  `main` branch.
- **`paths:`**: The workflow will only run if the modified files are located in
  the `src` directory.

### 4.2. `pull_request`

The `pull_request` trigger runs a workflow when a new pull request is created or
updated.

#### Example
```yaml
on:
  pull_request:
    branches:
      - main
```
In this example, the workflow will be triggered for all pull
requests opened on the `main` branch.

### 4.3. `schedule`

The `schedule` trigger allows you to define workflows that run at specific times, similar to a cron job.

#### Example
```yaml
on:
  schedule:
    - cron: "0 0 * * 1"
```
This example triggers the workflow every Monday at
midnight (UTC). The `cron` format is the same as that used in Linux cron jobs.

### 4.4. Other Triggers

- **`workflow_dispatch`**: Allows a workflow to be manually triggered through the GitHub UI.
- **`workflow_call`**: Allows a workflow to be invoked from another workflow. This is useful for reusing workflows across multiple projects or repositories.
- **`release`**: Triggers the workflow when a new release is published.
- **`issue_comment`**: Executes the workflow when a comment is added to an issue.
- **`push_tag`**: Triggers the workflow when a tag is pushed.

#### Example of `workflow_dispatch`
```yaml
on:
  workflow_dispatch:
```

This workflow can be manually triggered from the GitHub Actions interface. For
example, here is [a real use
case](https://github.com/ClubCedille/Plateforme-Cedille/blob/master/.github/workflows/add-new-member.yml)
of `workflow_dispatch` for the CEDILLE Platform, allowing the addition of a new
member to the organization via the GitHub Actions user interface:

```yaml
name: Add a new member to the organization
on:
  workflow_dispatch:
    inputs:
      github_username:
        description: 'GitHub username'
        required: true
        type: string
      github_email:
        description: 'GitHub Email'
        required: true
        type: string
      team_sre:
        description: 'Add to SRE team?'
        required: false
        type: boolean
      cluster_role:
        description: 'Cluster Role'
        required: true
        type: choice
        options:
          - None
          - Reader
          - Operator
          - Admin
```

In this example, the workflow allows the administrator to add a new member to
the organization, modify Terraform files, and create a Pull Request to apply
these changes.

#### Example of `workflow_call`
```yaml
on:
  workflow_call:
```

The `workflow_call` trigger allows a workflow to be called from another
workflow. This is an effective way to share and reuse workflows across multiple
projects or teams. For example, in the
[cedille-workflows](https://github.com/ClubCedille/cedille-workflows)
repository, we use this trigger type to centralize and reuse standardized
workflows across different projects.

Here is an example of using `workflow_call`:

```yaml
name: Reuse a workflow

on:
  workflow_call:
    inputs:
      environment:
        description: 'Target environment (dev, staging, prod)'
        required: true
        type: string

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2



      - name: Run build run: echo "Building for ${{ inputs.environment }}" ```
        In this example, the workflow can be invoked by other workflows to
        perform a specific task, such as building or deploying to a particular
        environment.

---

## Conclusion

With GitHub Actions, the basic setup for automating CI/CD workflows is simple
and powerful. By creating workflows in the `.github/workflows` directory, you
can automate tasks in response to various events such as `push`, `pull_request`,
or scheduled times via `schedule`. The YAML syntax allows you to easily define
jobs and steps, and the flexibility of triggers makes GitHub Actions adaptable
to different development and deployment scenarios.

GitHub Actions is designed to be intuitive and extendable using pre-built or
custom actions, making it an essential tool for any modern CI/CD pipeline.
