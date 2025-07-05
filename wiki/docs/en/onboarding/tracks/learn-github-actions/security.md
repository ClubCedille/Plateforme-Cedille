# Security and Permissions Management in GitHub Actions

Security is a crucial component of any CI/CD pipeline. GitHub Actions offers
built-in features for managing sensitive information, controlling workflow
access, and ensuring software dependency security. This document explores how to
use GitHub Secrets for managing sensitive data, define permissions on workflows,
and analyze dependencies with Dependabot.

---

## 1. Using GitHub Secrets to Manage Sensitive Information

Secrets in GitHub are used to store sensitive information such as API keys,
passwords, or access tokens, which are required for workflows but should not be
exposed in the source code.

### 1.1. What are GitHub Secrets?

**GitHub Secrets** are secure, encrypted variables stored by GitHub. They can be
used in workflows to pass sensitive information without exposing it in logs or
configuration files. For example, secrets are commonly used to authenticate with
third-party services such as AWS, Docker, or Slack.

### 1.2. Creating a Secret in GitHub

1. **Go to Settings** in the repository or organization.
2. Under **Secrets and variables**, click **Actions**.
3. Select **New repository secret** (for a repository) or **New organization
   secret** (to share across multiple repositories).
4. Enter a name for the secret (e.g., `AWS_ACCESS_KEY_ID`).
5. Enter the secret's value, then click **Add secret**.

### 1.3. Using Secrets in a GitHub Actions Workflow

Once created, secrets can be used in workflows by referencing them with `${{
secrets.SECRET_NAME }}`.

#### Example: Using Secrets for AWS Authentication

```yaml
name: Deploy to AWS

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Checkout source code
      - name: Checkout repository
        uses: actions/checkout@v2

      # Configure AWS credentials using secrets
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      # Deploy to AWS
      - name: Deploy to S3
        run: aws s3 sync ./build s3://my-app-bucket
```

### 1.4. Best Practices for Using Secrets

- **Limit Access to Secrets**: Only users who need to view or manage secrets
  should have access.
- **Use Organization-Level Secrets**: For multi-repo workflows, define
  organization-level secrets to share securely across repositories.
- **Encrypt Secrets**: Never include sensitive information directly in code or
  workflows; always use encrypted secrets.
- **Rotate Secrets Regularly**: Update secrets periodically to enhance security.

---

## 2. Workflow Permissions and Access Control

Security in GitHub Actions workflows also relies on **access permissions** and
**execution rights** management. GitHub allows you to control the actions a
workflow can perform and restrict access to certain events and users.

### 2.1. Workflow Permissions

GitHub allows configuration of default **permissions** that a workflow can
use. Permissions can be set globally for the entire repository or per workflow.

#### Configuring Workflow Permissions

Permissions can be set at two levels:

1. **Global (for the entire repository)**.
2. **Specific to a workflow**.

#### 2.1.1. Global Permissions for a Repository

Set default permissions for a repository under **Settings > Actions > Workflow
permissions**. The main options are:

- **Read repository content**: Restricts actions to read-only access (most
  secure option).
- **Read and write permissions**: Allows actions to read and modify the
  repository.

#### 2.1.2. Permissions in a Specific Workflow

Within a specific workflow, you can restrict permissions at the **job** or
**step** level.

##### Example: Defining Permissions in a Workflow

```yaml
name: Build and Deploy

on:
  push:
    branches:
      - main

permissions:
  contents: read # Restrict repository access to read-only
  packages: write # Allow write access to GitHub Packages

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
```

In this example:

- The workflow has **read-only** permission for repository contents.
- The workflow has **write** permission to GitHub Packages for publishing
  artifacts or Docker images.

### 2.2. Workflow Access Control

Workflow permissions can also be controlled by organization or repository
owners. Here are some best practices for securing workflows:

- **Require Approvals for Certain Workflows**: For critical events (like a
  production deployment), configure workflows to require manual approval before
  execution.

#### Example: Requiring Manual Approval for Deployment

```yaml
name: Production Deployment

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Await approval
        uses: actions/manual-approval@v2
        with:
          approver: "team-lead"
      - name: Deploy application
        run: ./deploy.sh
```

- **Limit Access to Secrets**: Only grant access to workflows and jobs that
  genuinely require it.
- **Use Protected Branches**: Restrict automatic workflows on production
  branches to prevent unauthorized changes.

---

## 3. Dependency Security Scanning with Dependabot and Renovate

Dependabot is a GitHub service that scans your project dependencies and
identifies security vulnerabilities. It provides automatic updates to fix these
vulnerabilities, enhancing the overall security of your applications.

In our repositories, however, we primarily use **Renovate**, an open-source
dependency management tool. Like Dependabot, Renovate scans dependencies and
provides automated updates. However, **Renovate** offers more advanced
configuration options, including update frequency, versioning strategies, and
support for a wide range of languages and package managers.

### Why Use Renovate?

- **Advanced Configuration**: Renovate enables detailed customization of update
  strategies, such as grouped updates, specific version ranges, and custom
  update schedules.
- **Extended Support**: It supports a wide range of package managers, making it
  ideal for multi-technology projects.
- **Easy Integration**: Like Dependabot, Renovate integrates directly with
  GitHub workflows and generates automated pull requests with dependency
  updates.

### Example Renovate Configuration File

In our projects, here’s a basic Renovate configuration example:

```json
{
  "extends": ["config:base"],
  "packageRules": [
    {
      "matchPackagePatterns": ["*"],
      "groupName": "All Dependencies",
      "groupSlug": "all-dependencies"
    }
  ],
  "schedule": ["every weekend"]
}
```

In this example:

- **extends**: Uses Renovate's base configuration.
- **packageRules**: Groups all dependencies in a single update batch.
- **schedule**: Updates are scheduled to run every weekend.

Renovate and Dependabot are both powerful tools for maintaining secure and
up-to-date dependencies in your projects, but Renovate is often preferred for
its flexibility and advanced configuration capabilities, as we do in our
repositories.

### 3.1. What is Dependabot?

**Dependabot** regularly scans your project dependencies and detects known
vulnerabilities in the libraries you use. When a vulnerability is found,
Dependabot automatically creates a **pull request** suggesting an update to a
more secure version.

### 3.2. Enabling Dependabot for Security Scanning

1. Go to your GitHub repository’s **Settings**.
2. Under **Security & Analysis**, enable **Dependabot alerts** and **Dependabot
   security updates**.

GitHub then automatically scans your project dependencies and notifies you if
vulnerabilities are detected.

### 3.3. Automatic Updates with Dependabot

Dependabot can automatically generate pull requests to update your dependencies
when security updates are available. These pull requests can then be reviewed
and merged to ensure that your project remains secure.

#### Example: Dependabot Configuration File

Dependabot can be configured via a `.github/dependabot.yml` file, defining which
dependencies to monitor and the update frequency.

```yaml
version: 2
updates:
  - package-ecosystem: "npm" # Manage npm dependencies
    directory: "/" # Directory with the package.json file
    schedule:
      interval: "daily" # Check for updates every day
  - package-ecosystem: "docker" # Manage Docker images
    directory: "/" # Directory with the Dockerfile
    schedule:
      interval: "weekly" # Check for updates weekly
```

### 3.4. Vulnerability Scanning in Code and Dependencies

Dependabot connects to a database of known vulnerabilities to check the packages
used in your projects. When a vulnerability is found:

- You receive a **Dependabot alert** in your repository’s **Security** tab.
- Dependabot can automatically create a **pull request** suggesting an update to
  a non-vulnerable version.

### 3.5. Tracking Security Updates

Dependabot enables you to:

- Track the history of vulnerabilities and patches.
- Implement automatic updates so your project always uses secure dependency
  versions.

---

## Conclusion

Security and permissions management in GitHub Actions is essential for
maintaining the confidentiality, integrity, and security of your CI/CD
pipelines. By using GitHub Secrets, you can safeguard sensitive information such
as API keys and credentials. Configuring workflow and secret access permissions
helps reduce the risk of compromise. Additionally, Dependabot offers a powerful
tool for monitoring and automatically addressing vulnerabilities in your
dependencies, further enhancing the overall security of your projects.

These tools and practices allow you to build robust and secure workflows,
adhering to best practices for security and permissions management.
