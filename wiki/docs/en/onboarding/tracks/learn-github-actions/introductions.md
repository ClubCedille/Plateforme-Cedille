# Introduction to GitHub Actions

## What is GitHub Actions?

GitHub Actions is an automation platform integrated into GitHub that allows you
to create, manage, and run automated workflows directly from your GitHub
repositories. With GitHub Actions, you can set up Continuous Integration (CI)
and Continuous Deployment (CD) processes, automate tests, builds, deployments,
and much more.

The key strength of GitHub Actions lies in its native integration with GitHub,
enabling you to trigger workflows based on repository events like `push`, `pull
requests`, or even custom triggers such as scheduled `cron` jobs.

### Key Features of GitHub Actions
- **Full GitHub Integration**: Workflows can be triggered by GitHub events such
  as `push`, `pull request`, `issues`, and many more.
- **Flexibility**: GitHub Actions is highly customizable, with hundreds of
  actions available in the [GitHub
  Marketplace](https://github.com/marketplace?type=actions).
- **Hosted and Self-hosted Runners**: GitHub provides preconfigured build
  environments, or you can use your own machines to run workflows.

---

## Primary Use in Continuous Integration (CI) and Continuous Deployment (CD)

GitHub Actions is particularly useful for implementing Continuous Integration
(CI) and Continuous Deployment (CD) pipelines. Here’s an overview of each
concept:

### Continuous Integration (CI)

Continuous Integration is a process in which developers regularly merge their
code changes into the main branch of the repository. Automated tests are run to
ensure that the newly integrated code does not break the project. GitHub Actions
automates this process by creating workflows that run automatically whenever a
`push` or a `pull request` is made to a repository.

- **CI Use Case Examples**:
  - Automatically running unit tests after each `commit` or `pull request`.
  - Automatically building the code to check for syntax or compilation errors.

```yaml
name: CI Pipeline

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'

    - name: Install dependencies
      run: npm install

    - name: Run tests
      run: npm test
```

### Continuous Deployment (CD)

Continuous Deployment automates the deployment of your application to different
environments (development, staging, production). GitHub Actions can be used to
trigger deployments after successful tests. For instance, you can set up a
workflow to deploy an application to a cloud service like AWS, Azure, or GCP
after every `merge` to the main branch.

- **CD Use Case Examples**:
  - Deploying an application to AWS after a successful `merge` to the `main`
    branch.
  - Automating releases with workflows that automatically generate application
    versions and publish them.

```yaml
name: CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Deploy to AWS
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: Deploy application
      run: |
        aws s3 sync ./build s3://my-app-bucket
```

---

## Key Concepts of GitHub Actions

GitHub Actions is based on several key concepts that help structure and organize
automation workflows. Here’s a detailed explanation of the fundamental terms:

### Workflows

A **workflow** is an automation defined in a YAML file located in the
`.github/workflows/` directory. A workflow consists of one or more **jobs** that
run in response to specific events. For instance, a workflow can be triggered
whenever a developer pushes code to the repository.

- **Event Triggers**: Workflows are triggered by specific events, such as a
  `push`, `pull request`, or scheduled events with a `cron` job.
- **Job Definitions**: A workflow contains one or more jobs. Each job is a
  series of steps executed in an isolated environment.

### Jobs

A **job** is a sequence of **steps** that runs in an isolated environment. By
default, all jobs in a workflow run in parallel, but they can be configured to
run sequentially if one job depends on another.

- **Parallel Execution**: Multiple jobs can run in parallel to reduce total
  execution time.
- **Job Dependencies**: A job can depend on the completion of another job.

```yaml
jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Step 1
        run: echo "Job 1 Step 1"

  job2:
    needs: job1  # Depends on job1
    runs-on: ubuntu-latest
    steps:
      - name: Step 1
        run: echo "Job 2 Step 1"
```

### Actions

An **action** is an individual task you can run in a job. GitHub Actions offers
a large library of pre-built actions available in the [GitHub
Marketplace](https://github.com/marketplace?type=actions). You can also create
your own actions for specific needs.

- **Marketplace Actions**: You can reuse actions developed by others, such as
  `actions/checkout` to check out code or `actions/setup-node` to set up
  Node.js.
- **Custom Actions**: You can create project-specific actions using Bash scripts
  or by creating Docker containers. For a detailed example of creating a custom
  action, check out the
  [Cedille-Actions-By-Example](https://github.com/ClubCedille/cedille-actions-by-example)
  repository, which illustrates how to structure and configure an action like
  **KubeSketcher**, an action to generate Kubernetes namespace architecture
  diagrams.

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v2  # Predefined action from Marketplace

  - name: Run custom script
    run: ./my-custom-script.sh  # Custom action
```

### Runners

A **runner** is the machine that executes the job defined in a workflow. GitHub
offers **hosted runners** (machines preconfigured by GitHub), and you can also
configure your own **self-hosted runners** if you have specific requirements for
the runtime environment.

- **Hosted Runners**: GitHub provides hosted runners on Linux, Windows, and
  macOS with commonly used CI/CD tools already installed.
- **Self-hosted Runners**: If you have specific hardware or security
  requirements, you can configure your own runners using your machines.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest  # Uses a hosted runner on Ubuntu

  custom-build:
    runs-on: self-hosted  # Uses a self-hosted runner
```

---

## Differences Between GitHub Actions and Other CI/CD Tools

GitHub Actions stands out due to its native integration with GitHub,
flexibility, and ease of configuration. Here are some major differences between
GitHub Actions and other CI/CD tools like Jenkins, Travis CI, or CircleCI:

### Native Integration with GitHub

Unlike other CI/CD tools that require external integration with GitHub, GitHub
Actions is directly embedded in the GitHub interface. This means you can manage
your CI/CD workflows without leaving GitHub, with easy management of triggers,
secrets, and permissions.

### Flexibility

GitHub Actions is extremely flexible, allowing you to define your workflows
using a simple YAML file. You also have access to a wide variety of predefined
actions in the Marketplace and the ability to create custom actions.

### Execution within GitHub

Workflows run directly within GitHub using hosted runners. Other services, like
Jenkins, often require setting up your own execution servers.

### Feature Comparison

| CI/CD Tools | GitHub Actions | Jenkins | Travis CI | CircleCI |
|--------------------|----------------------|--------------------|--------------------|--------------------|
| **Integration** | Native GitHub | External | External | External |
| **Configuration** | YAML in repository | Jenkins interface | YAML in repository | YAML in repository |

| **Features** | **GitHub Actions** | **Jenkins** | **CircleCI** | **GitLab CI/CD** |
|-----------------------|-------------------------|--------------------|---------------------|--------------------------|
| **Runners** | Hosted / Self-hosted | Jenkins servers | Hosted only | Hosted / Self-hosted |
| **Marketplace** | Yes, with actions | Jenkins plugins | Yes | Yes |

---

## Conclusion

GitHub Actions is a powerful platform for automating your CI/CD pipelines
directly within GitHub. With its seamless integration, flexibility, and variety
of available tools, GitHub Actions simplifies workflow automation for developers
while remaining adaptable to the specific needs of each project. Whether for a
small project or a large DevOps infrastructure, GitHub Actions is a robust and
scalable solution.
