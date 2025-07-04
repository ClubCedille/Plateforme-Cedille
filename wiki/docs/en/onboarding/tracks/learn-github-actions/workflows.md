# Creating Custom Workflows with GitHub Actions

GitHub Actions allows you to create custom workflows tailored to your specific
CI/CD needs. Workflows are defined in YAML files and can automate a wide range
of tasks, from code testing to production deployment.

---

## 1. Defining Jobs and Steps

A GitHub Actions workflow is composed of multiple **jobs**, and each **job**
contains a series of **steps**. A job is a set of tasks running on a given
machine, while each step represents a command or specific action within that
job.

### Job Structure

A **job** must define:
- The environment in which it runs (`runs-on`).
- The **steps** to be executed.
- Optionally, dependencies between jobs or execution conditions.

### Example: Defining Jobs and Steps

```yaml
name: Custom Workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest  # Defines the environment (an Ubuntu machine)

    steps:
      - name: Checkout code  # Step 1: Retrieve the source code from the repository
        uses: actions/checkout@v2

      - name: Install dependencies  # Step 2: Install dependencies
        run: npm install

      - name: Run tests  # Step 3: Run tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy application
        run: ./deploy.sh
```

### Details:
- **`jobs:`** : The `jobs` section contains all jobs in the workflow. Each job
  is defined with a unique identifier (`build` and `deploy` here).
- **`runs-on:`** : Specifies the environment for the job (e.g.,
  `ubuntu-latest`).
- **`steps:`** : Each job contains one or more steps, which can execute shell
  commands (`run`) or use existing actions (`uses`).

---

## 2. Using Pre-Built Actions from GitHub Marketplace

GitHub Actions has a **Marketplace** where you can find and use community-built
actions. These actions can be easily integrated into your workflows to handle
common tasks like checking code, setting up environments, or deploying
applications.

### How to Use Actions from the Marketplace

To use an action from the Marketplace, add it to your `steps` using the following syntax:
```yaml
uses: <action>@<version>
```
Here’s an example using the `actions/checkout` action to retrieve a repository’s source code.

#### Example:

```yaml
steps:
  - name: Checkout code
    uses: actions/checkout@v2  # Uses the action to clone the repository
```

The `actions/checkout` action is commonly used to clone the repository onto the
machine where jobs are executed. You can find hundreds of other actions on the
[GitHub Marketplace](https://github.com/marketplace?type=actions), such as:
- **`actions/setup-node`** : Sets up a Node.js environment.
- **`actions/upload-artifact`** : Saves files or test results.

### Complete Example:

```yaml
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
```

---

## 3. Creating and Using Your Own Custom Actions

Besides using pre-built actions, GitHub Actions allows you to **create your own
custom actions** to meet specific needs. These actions can be written in
JavaScript or defined in Docker containers for more complex environments. For a
practical example, see the repository
[Cedille-Actions-By-Example](https://github.com/ClubCedille/cedille-actions-by-example),
which presents various custom actions, including **KubeSketcher**, which
generates Kubernetes namespace architecture diagrams from manifests, and
**WorkflowWikiExample**, designed to illustrate creating and using a custom
action.

Here’s the process followed to create the
**cedille-actions-by-example/WorkflowWikiExample** action:

```markdown
### Types of Custom Actions

1. **JavaScript Actions**: Actions written in JavaScript that run directly in the runner environment.
2. **Docker Actions**: Actions encapsulated in a Docker container, allowing for a more complex runtime environment.

### Creating a Simple Custom JavaScript Action

1. **Create a `WorkflowWikiExample` directory in your repository**.
2. **Create an `index.js` file** with the JavaScript code for your action:

```js
// index.js
const core = require('@actions/core');
const github = require('@actions/github');

try {
  const message = core.getInput('message');
  console.log(`Message: ${message}`);
} catch (error) {
  core.setFailed(error.message);
}
```

3. **Create an `action.yml` file** to describe the action:

```yaml
name: 'Print Message'
description: 'Prints a message to the console'
inputs:
  message:
    description: 'The message to print'
    required: true
runs:
  using: 'node20'
  main: 'index.js'
```

### Using the Custom Action

Once created, you can use your custom action in workflows just like any other
action.

```yaml
name: Custom Action Workflow

on: [push]

jobs:
  custom-action-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Run custom action
        uses: ClubCedille/Cedille-Actions-By-Example/WorkflowWikiExample@master
        with:
          message: "Hello from the custom action!"
```

### Docker Actions

If your action requires a specific environment, you can create a Docker action,
allowing you to run scripts in an isolated container.

#### Docker Action Example:
1. Create a `Dockerfile`:

```dockerfile
FROM node:14
COPY . /app
WORKDIR /app
RUN npm install
CMD ["node", "index.js"]
```

2. Create the action YAML for Docker:

```yaml
name: 'Custom Docker Action'
runs:
  using: 'docker'
  image: 'Dockerfile'
```

---

## 4. Secrets and Environment Variables

**Secrets** and **environment variables** allow you to secure sensitive
information and pass dynamic parameters to your workflows.

### Using Secrets

Secrets store sensitive information like API keys or credentials that you don’t
want exposed in your code. You can add secrets to your repository via GitHub’s
interface and reference them in your workflows.

#### Adding a Secret:
1. Go to the **Settings** of your repository.
2. Click **Secrets and variables** > **Actions**.
3. Add a new secret (e.g., `API_KEY`).

#### Using a Secret in a Workflow:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Use secret API key
        run: echo "Your API key is ${{ secrets.API_KEY }}"
```

### Using Environment Variables

Environment variables can also be defined and used within jobs or steps.

#### Example: Environment Variables:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    env:
      NODE_ENV: production
      API_URL: https://api.example.com

    steps:
      - name: Print environment variables
        run: echo "Environment: $NODE_ENV, API: $API_URL"
```

---

## 5. Parallel and Conditional Execution

### Parallel Execution

By default, jobs in a GitHub Actions workflow run **in parallel**. This allows
multiple jobs to execute simultaneously, reducing total workflow time.

#### Parallel Execution Example:

```yaml
jobs:
  build-frontend:
    runs-on: ubuntu-latest
    steps:
      - name: Build frontend
        run: npm run build-frontend

  build-backend:
    runs-on: ubuntu-latest
    steps:
      - name: Build backend run: npm run build-backend ``` In this example, the
        `build-frontend` and `build-backend` jobs will run in parallel.

### Conditional Execution

You can define conditions to control when jobs or steps are run, such as running specific actions only if a test fails or if the branch matches a certain condition.

#### Conditional Execution with `if`:

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest

    if: github.ref =='refs/heads/main'  # Run only if on 'main' branch

    steps:
      - name: Deploy to production
        run: ./deploy.sh
```

### Passing Information from One Job to Another

It’s possible to pass information between jobs in a GitHub Actions workflow by
defining **outputs** in one job and using those outputs in a following job. This
allows you to reuse data computed or retrieved in one job for use in another.

#### Example: Define and Use Outputs in Jobs

In this example, the `build` job generates a version number and passes it to the
`deploy` job.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Generate version number
        id: version_step
        run: echo "::set-output name=version::1.0.$(date +%s)"

  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2



 - name: Deploy application
        run: echo "Deploying version ${{ needs.build.outputs.version }}"
```

#### Explanation:

1. **Define an Output**: In the `build` job, the `::set-output` command is used
   to define an output called `version`. This version number is generated using
   the `date` command to create a unique value.

2. **Use the Output in Another Job**: In the `deploy` job, the output from the
   `build` job is referenced with `${{ needs.build.outputs.version }}`, allowing
   access to data generated in the first job for deployment purposes.

---

## Conclusion

Creating custom workflows in GitHub Actions allows you to automate your CI/CD
pipelines efficiently. Whether you use pre-built actions from the Marketplace or
create your own custom actions, GitHub Actions provides unparalleled
flexibility. Secrets, environment variables, and conditional execution give you
complete control over your workflows, enabling you to build robust, secure
processes for your project.

With these tools, you’re now ready to build workflows tailored to your needs,
enhance team collaboration, and reliably automate your deployments and testing.
