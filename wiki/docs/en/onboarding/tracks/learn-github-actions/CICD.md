# Optimizing CI/CD Workflows with GitHub Actions

Optimizing CI/CD workflows is essential to improve efficiency, reduce execution
times, and ensure pipeline stability. This detailed guide explores various
techniques to accelerate your workflows, optimize CI/CD pipelines, manage
dependency versions, and troubleshoot issues using GitHub Actions' integrated
debugging tools.

---

## 1. Speeding Up Workflows: Caching Dependencies and Reusing Workflows

### 1.1. Caching Dependencies

Caching dependencies is an efficient way to reduce the time spent installing
libraries and modules in your CI/CD workflows. GitHub Actions offers a built-in
**`cache`** action, which allows storing files like build dependencies or
intermediate results for reuse in subsequent runs.

#### Example: Caching Node.js Dependencies

```yaml
name: CI with Cache

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Check out source code
      - name: Checkout repository
        uses: actions/checkout@v2

      # Step 2: Cache npm dependencies
      - name: Cache Node.js modules
        uses: actions/cache@v2
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      # Step 3: Install dependencies
      - name: Install dependencies
        run: npm install

      # Step 4: Build project
      - name: Build project
        run: npm run build
```

#### Explanation of Step
- **`actions/cache@v2`**: This action caches Node.js modules located in the
  `node_modules` directory. The cache is based on the checksum (hash) of the
  `package-lock.json` file. If no changes are detected in this file, the cache
  is restored, reducing dependency installation time.
- **`restore-keys`**: This option allows partial cache restoration if the exact
  key is not found.

### 1.2. Reusing Workflows

Reusing workflows enables centralization of common pipeline parts into a
reusable file, simplifying the management of complex workflows. You can call one
workflow from another to avoid code duplication.

In our projects, we use a dedicated repository for reusable workflows. You can
check out
[**cedille-workflows**](https://github.com/ClubCedille/cedille-workflows), which
contains examples of workflows ready for reuse in different projects. This
repository centralizes common workflow definitions, such as Docker image
building, deployments, and dependency management.

Here is the updated section with an example illustrating the use of variables in
a reusable workflow:

```markdown
#### Example: Calling a Reusable Workflow

In this case, we have one workflow that performs tests and another that handles deployments. These workflows are reused from a central file.

```yaml
# .github/workflows/reusable-tests.yml
name: Reusable Test Workflow

on: workflow_call

jobs:
  tests:
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
# .github/workflows/deploy.yml
name: Deployment Pipeline

on:
  push:
    branches:
      - main

jobs:
  call-tests:
    uses: ./.github/workflows/reusable-tests.yml

  deploy:
    needs: call-tests
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Deploy to production
        run: ./deploy.sh
```

#### Example: Reusable Workflow with Variables

You can also define **input variables** in a reusable workflow for greater
flexibility. Here is an example that builds and pushes a Docker image to the
GitHub Container Registry (GHCR) using input variables:

```yaml
# .github/workflows/build-push-ghcr.yml
name: Reusable workflow to build and push docker container to GitHub Container Registry

on:
  workflow_call:
    inputs:
      container-name:
        required: true
        type: string
      context:
        required: false
        type: string
        default: '.'
      file:
        required: false
        type: string
        default: 'Dockerfile'

env:
  REGISTRY: ghcr.io/clubcedille

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - name: Check Out Repo
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to the Container Registry
        uses: docker/login-action@v1
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: ${{ inputs.context }}
          file: ${{ inputs.file }}
          push: true
          tags: ${{ env.REGISTRY }}/${{ inputs.container-name }}:latest
```

#### Example of Using the Reusable Workflo

This workflow can now be called from another workflow, while passing customized
variables to adapt its behavior:

```yaml
# .github/workflows/deploy-with-docker.yml
name: Deployment with Docker

on:
  push:
    branches:
      - main

jobs:
  deploy:
    uses: ./.github/workflows/build-push-ghcr.yml
    with:
      container-name: my-app
      context: ./my-app-directory
```

#### Explanatio
- **`workflow_call`**: Enables reusing the workflow by calling workflows defined
  elsewhere. Input variables allow customization of the reusable workflow’s
  behavior.
- **Input Variables (`inputs`)**: Variables like `container-name`, `context`,
  and `file` set specific values for each workflow call. This enables building
  and pushing different Docker images without altering the base workflow.
- **Reducing Duplication**: Using variables in reusable workflows centralizes
  common tasks while adapting their execution to specific needs, simplifying
  CI/CD pipeline maintenance.

---

## 2. Pipeline Optimization Strategies (Job Matrix, Dependent Jobs)

### 2.1. Job Matrix

The **job matrix** is a powerful GitHub Actions feature that allows multiple
configuration combinations to run in parallel. This is particularly useful for
testing your application on various language versions, environments, or
operating systems.

#### Example: Job Matrix with Node.js

```yaml
name: Node.js CI

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12, 14, 16]
        os: [ubuntu-latest, windows-latest, macos-latest]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v2
        with:
          node-version: ${{ matrix.node-version }}

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

#### Explanatio
- **`matrix.node-version`** and **`matrix.os`**: These two matrices enable
  testing on different Node.js versions (`12`, `14`, `16`) and across various
  operating systems (`ubuntu`, `windows`, `macos`).
- **Parallel Execution**: GitHub Actions executes all matrix combinations in
  parallel, significantly reducing the total execution time for
  multi-environment testing.

### 2.2. Dependent Jobs

Dependent jobs allow defining dependencies between jobs, meaning a job can wait
for another to complete successfully before starting.

#### Example: Dependent Jobs

```yaml
name: Build and Deploy

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build application
        run: npm run build

  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Run tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

#### Explanatio
- **`needs`**: The `needs` instruction defines a dependency between jobs. In
  this example, the `test` job only starts after the `build` job succeeds, and
  the `deploy` job waits for `test` to complete.

---

## 3. Managing Dependency and Action Versions

Properly managing dependency and action versions in your workflows ensures
stability and prevents errors due to unexpected changes in the libraries or
actions used.

### 3.1. Managing Action Versions

When using an action in a GitHub Actions workflow, it is essential to specify a
specific version to ensure your workflow remains stable, even if the action is
updated in the future.

#### Example: Using a Specific Action Version

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2.3.4  # Use a specific version
```

### 3.2. Managing Dependency Versions

Locking the versions of dependencies used in your project (for example, in
`package-lock.json`

 or `requirements.txt`) is also recommended. This ensures that each workflow
 execution uses the same library versions, minimizing errors from untested
 updates.

#### Example: Locked Dependencies in `package-lock.json`

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm ci  # Install dependencies with locked versions in package-lock.json
```

---

## 4. Debugging GitHub Actions Workflows

When a workflow fails or behaves unexpectedly, having the right tools to
diagnose and resolve the issue quickly is essential.

### 4.1. Enabling Detailed Logs

GitHub Actions allows enabling detailed logs to help diagnose errors. This can
be useful if a job fails without providing enough information in the standard
logs.

#### Enable Detailed Logs

1. Go to the workflow run page.
2. Click on the failed job to view the logs.
3. Use the **Rerun jobs with debug logging** option to rerun the job with more
   detailed logs.

### 4.2. Using `ACTIONS_STEP_DEBUG`

You can also enable debug mode by setting a special environment variable
`ACTIONS_STEP_DEBUG`.

#### Example: Enable Debug Mode in the Workflow

```yaml
jobs:
  debug-job:
    runs-on: ubuntu-latest

    steps:
      - name: Enable step debug logging
        run: echo "ACTIONS_STEP_DEBUG=true" >> $GITHUB_ENV

      - name: Checkout repository
        uses: actions/checkout@v2
```

### 4.3. Adding Custom Debugging Messages

In certain situations, you may need to add debugging messages to your workflows
to inspect values or verify checkpoints. You can use `core.debug` for this.

#### Example: Adding Debugging Messages

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Debug message
        run: |
          echo "DEBUG: Current directory is $(pwd)"
          echo "DEBUG: Branch is ${{ github.ref }}"
```

---

## Conclusion

Optimizing your CI/CD workflows in GitHub Actions is crucial for fast, stable,
and efficient executions. Caching dependencies, reusing workflows, using job
matrices, and managing dependencies are all essential strategies for improving
performance. Additionally, with built-in debugging tools, you can quickly
identify and fix issues in your workflows. These best practices enable you to
maintain robust and high-performance pipelines while minimizing errors and
interruptions.
