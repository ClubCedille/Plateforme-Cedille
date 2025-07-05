# Best Practices and DevOps Patterns with GitHub

Adopting best practices and DevOps patterns is essential for ensuring robust,
scalable, and efficient CI/CD pipelines in complex projects. GitHub Actions,
with its automation features, enables workflow structuring, multi-environment
management, and streamlined team collaboration. This guide provides strategies
and best practices for structuring workflows, centralizing configurations,
managing development environments, and collaborating effectively through GitHub
Actions.

---

## 1. Structuring Workflows for Complex Projects

In complex projects, structuring workflows is crucial for maintaining a smooth
and manageable CI/CD lifecycle. This includes dividing workflows into specific
stages, reusing workflows, and managing job dependencies.

### 1.1. Divide Workflows into Clear Stages

It’s recommended to break a workflow into multiple **jobs** and **steps**,
assigning specific responsibilities to each job, such as testing, building, or
deploying. Each job can run in parallel or as a dependency, providing greater
flexibility.

#### Structured Workflow Example

```yaml
name: Complex Workflow

on:
  push:
    branches:
      - main

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run linter
        run: npm run lint

  test:
    runs-on: ubuntu-latest
    needs: lint # The 'test' job depends on 'lint'
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Run unit tests
        run: npm test

  build:
    runs-on: ubuntu-latest
    needs: test # The 'build' job depends on 'test'
    steps:
      - name: Build application
        run: npm run build

  deploy:
    runs-on: ubuntu-latest
    needs: build # The 'deploy' job depends on 'build'
    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

#### Explanation

- **Dependent Jobs**: The `test`, `build`, and `deploy` jobs depend on previous
  jobs, ensuring no deployment occurs before validation through tests or builds.
- **Modularity**: Each job has a defined role, making the workflow more readable
  and maintainable.

### 1.2. Workflow Modularization

GitHub Actions allows calling one workflow from another using `workflow_call`.
Modularizing workflows enables you to reuse parts of the pipeline (tests,
builds, etc.) across different projects, ensuring consistency in CI/CD
management across the organization.

#### Example of a Reusable Workflow

```yaml
# .github/workflows/tests.yml
name: Reusable Tests Workflow

on: workflow_call

jobs:
  run-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

```yaml
# .github/workflows/main.yml
name: Main Workflow

on:
  push:
    branches:
      - main

jobs:
  tests:
    uses: ./.github/workflows/tests.yml # Reuse the test workflow
```

### 1.3. Use Matrices to Optimize Runs

Using **matrices** allows testing across various combinations of environments
(OS, language versions, etc.) in parallel, reducing the total pipeline runtime.

#### Matrix Example

```yaml
name: Matrix Build

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
        node-version: [12, 14, 16]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

---

## 2. Using Centralized Configuration Files

For complex projects, centralizing workflow configuration can ensure consistency
across different pipelines and reduce duplication.

### 2.1. Centralize Secrets and Variables

GitHub allows managing **secrets** and **environment variables** at the
organization or repository level. This lets you store sensitive information like
API keys or credentials in a centralized and secure location.

#### Example: Using Secrets in a Workflow

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Deploy to AWS
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        run: ./deploy.sh
```

### 2.2. Shared Configuration Files

GitHub Actions allows creating shared YAML configuration files, enabling
standardized CI/CD processes across multiple projects. These files can include
common scripts or reusable workflows for different teams or repositories.

#### Example: Using a Central Configuration File

```yaml
# .github/workflows/shared-config.yml
name: Shared Config

on: workflow_call

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Install dependencies
        run: npm install
```

---

## 3. Team Collaboration in Software Development with GitHub Actions (PR Gating, Checks)

GitHub Actions streamlines team collaboration by automating checks and
integrating pull request (PR) gating controls.

### 3.1. Implementing PR Gating

**PR gating** prevents code from merging into a branch without successfully
passing specified tests or checks. You can configure **required checks** that
must pass before merging a pull request.

#### Example: Workflow to Validate a PR

```yaml
name: PR Validation

on:
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

### 3.2. Automatic Checks on Pull Requests

GitHub enables automatic **checks** on pull requests, such as running tests or
checking code style.

### 3.3. Protected Branch Policy

It’s recommended to protect critical branches (like `main` or `production`) by
configuring **protected branches**, which prevent direct commits or require
specific workflows to complete before merging.

#### Example: Protecting the `main` Branch

1. Go to **Settings** in the repository.
2. Navigate to **Branches**.
3. Add a branch rule for `main`.
4. Check **Require status checks to pass before merging**.

---

## Conclusion

Applying best practices and DevOps patterns with GitHub Actions allows you to
effectively structure CI/CD workflows, centralize configurations and secrets,
manage multiple environments, and collaborate seamlessly within a team. Using
tools such as environments, reusable workflows, protected branches, and pull
request checks enables building robust and scalable pipelines for complex
projects, while ensuring code quality and security.
