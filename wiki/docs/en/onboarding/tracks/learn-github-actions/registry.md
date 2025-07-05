# Using GitHub Container Registry (GHCR)

GitHub Container Registry (GHCR) is a feature of GitHub Packages that enables
you to store and manage Docker container images alongside your GitHub
projects. GHCR integrates seamlessly with CI/CD workflows via GitHub Actions,
simplifying the creation, storage, and deployment of Docker images in your
projects.

---

## 1. Introduction to GitHub Container Registry

GitHub Container Registry (GHCR) is an integrated container registry service in
GitHub, allowing developers to manage Docker container images directly within
their GitHub repositories. GHCR is designed to provide flexible permission
management, image visibility, and integration with GitHub Actions workflows.

### Example: Cedille’s Container Registry

For a real-world example of GHCR usage, check out the [Cedille container
registry](https://github.com/orgs/ClubCedille/packages). This registry hosts
container images that the club uses for its projects, integrated with CI/CD
workflows and managed directly through GitHub Actions.

### Key Features of GHCR

- **Centralized Storage**: GHCR allows you to store Docker images alongside your
  project’s source code, simplifying versioning and deployments.
- **Flexible Permissions**: Images can be private, public, or have custom
  permissions managed for users and teams.
- **Integration with GitHub Actions**: GHCR integrates directly with GitHub
  Actions CI/CD workflows, allowing automated Docker image creation and
  deployment.
- **Support for Docker and OCI**: GHCR supports Docker and Open Container
  Initiative (OCI) compliant images.

---

Here’s how you can integrate this example into your Dockerized projects in the
section **Pushing and Pulling Container Images to GitHub Container Registry**:

## 2. Pushing and Pulling Container Images in GitHub Container Registry

GitHub Container Registry allows users to **push** (upload) and **pull**
(download) Docker images from their GitHub projects, similar to other Docker
registries such as Docker Hub.

### Example: Workflow to Build and Push a Docker Image to GHCR

In Cedille’s projects, workflows are used to automate the build and publish
process of Docker images to GHCR. Below is an example of the
[build-push-ghcr.yaml](https://github.com/ClubCedille/cedille-workflows/blob/master/.github/workflows/build-push-ghcr.yaml)
file used to build and push Docker containers.

### Workflow Explanation for [build-push-ghcr.yaml](https://github.com/ClubCedille/cedille-workflows/blob/master/.github/workflows/build-push-ghcr.yaml
- **workflow_call**: This workflow is designed to be reusable by other
  workflows, allowing container name, Docker context, and Dockerfile
  specification.
- **Docker Buildx**: Used for building multi-platform images (e.g., amd64,
  arm64).
- **Docker Layer Caching**: Docker layers are cached to speed up builds.
- **Pushing Docker Images**: Images are pushed to the GitHub registry (GHCR)
  with tags based on the commit or PR branch, and a `latest` tag is added if the
  push is on the `main` or `master` branch.

This example shows how Cedille uses GHCR to manage Docker images with automated,
robust CI/CD workflows.

### 2.1. Authenticating to GitHub Container Registry

To interact with GHCR, you need to authenticate to GitHub using a personal
access token (PAT) with the following permissions:
- `read:packages`
- `write:packages`
- `delete:packages` (if you wish to delete images)
- `repo` (if pushing images to private repositories)

#### Creating a Personal Access Token (PAT)

1. Go to your **GitHub Settings**.
2. Under **Developer settings**, click **Personal access tokens**.
3. Create a new token with the permissions mentioned above.

### 2.2. Pushing a Docker Image to GitHub Container Registry

To push a Docker image to GHCR, follow these steps:

#### 1. Logging In to GitHub Container Registry

Use the following Docker command to authenticate with GHCR using your personal
access token (PAT):

```bash
echo $GHCR_PAT | docker login ghcr.io -u <github-username> --password-stdin
```

- **`$GHCR_PAT`** is your personal access token (PAT).
- **`<github-username>`** is your GitHub username.

#### 2. Building a Docker Image

Build a Docker image from your project. For example, if you have a `Dockerfile`
in the root directory of your project:

```bash
docker build -t ghcr.io/<github-username>/<image-name>:<tag> .
```

- **`<github-username>`**: Your GitHub username.
- **`<image-name>`**: The name of the Docker image.
- **`<tag>`**: A tag to identify the image version (e.g., `v1.0`, `latest`).

#### 3. Pushing the Docker Image to GHCR

Once the image is built, push it to GHCR using the following command:

```bash
docker push ghcr.io/<github-username>/<image-name>:<tag>
```

### 2.3. Pulling a Docker Image from GitHub Container Registry

To pull a Docker image stored in GHCR, authenticate first, then run the pull
command.

#### 1. Authentication

If you aren’t already logged in to GHCR, authenticate as follows:

```bash
echo $GHCR_PAT | docker login ghcr.io -u <github-username> --password-stdin
```

#### 2. Pull the Docker Image

Use the `docker pull` command to download an image from GHCR:

```bash
docker pull ghcr.io/<github-username>/<image-name>:<tag>
```

---

## 3. Integrating Images with GitHub Actions Workflows

GitHub Actions integrates seamlessly with GitHub Container Registry, enabling
you to create CI/CD workflows that include automated Docker image build, test,
and deployment.

### Example Workflow to Build and Push a Docker Image to GHCR

Below is a sample GitHub Actions workflow that builds a Docker image from a
repository and automatically pushes it to GHCR.

```yaml
name: Build and Push Docker Image to GHCR

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Step 2: Authenticate to GHCR
      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      # Step 3: Build Docker image
      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/my-app:latest .

      # Step 4: Push image to GHCR
      - name: Push Docker image to GHCR
        run: docker push ghcr.io/${{ github.repository }}/my-app:latest
```

### Explanation of Step

1. **Checkout repository**: This step retrieves the repository’s source code.
2. **Log in to GitHub Container Registry**: Logs into GHCR using GitHub’s access
   token (`GITHUB_TOKEN`).
3. **Build Docker image**: Builds a Docker image from the Dockerfile in the
   project’s root directory.
4. **Push Docker image to GHCR**: Pushes the built Docker image to GHCR using
   the path `ghcr.io/<organization-or-username>/<image-name>`.

### Workflow Example to Pull an Image and Deploy with Docker

The following GitHub Actions workflow pulls a Docker image from GHCR and deploys
it to a target machine (e.g., a production server).

```yaml
name: Pull and Deploy Docker Image from GHCR

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Authenticate to GHCR
      - name: Log in to GitHub Container Registry
        run: echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      # Pull the Docker image
      - name: Pull Docker image from GHCR
        run: docker pull ghcr.io/${{ github.repository }}/my-app:latest

      # Run the Docker container
      - name: Run Docker container
        run: docker run -d -p 8080:80 ghcr.io/${{ github.repository }}/my-app:latest
```

---

## 4. Access Control and Permissions on Registries

One of GHCR’s significant advantages is fine-grained **access control**. You can
manage who has access to your container images and define specific permissions
for each image or repository.

### 4.1 Repository Permissions

Access permissions for images hosted in GHCR depend on the access permissions
for the associated repository:
- **Public Repositories**: Images in public repositories can be viewed and
  pulled by any GitHub user.
- **Private Repositories**: Images in private repositories are accessible only
  to people or teams with appropriate repository permissions.

### 4.2 Permissions for Public and Private Images

You can set specific permissions for GHCR images, independent of the repository
they’re hosted in. Images can be:
- **Private**: Only users or teams granted access can pull or push images.
- **Public**: Anyone can pull the image.

#### Make an Image Public or Private

1. Go to the **Packages** page of your GitHub repository.
2. Select the Docker image you want to modify.
3. Click **Package settings**.
4. Change the image’s visibility to **Public** or **Private

**.

### 4.3 Managing Permissions for Users and Teams

You can grant read or write permissions on your images to specific users or
teams within your GitHub organization. This allows you to restrict access to
sensitive images while facilitating team collaboration.

#### Grant Access to a User or Team

1. Go to the **Settings** of the GitHub repository containing the image.
2. Under **Manage access**, add the users or teams to whom you wish to grant
   access.
3. Assign specific roles (read, write, or admin) based on the desired access
   level.

---

## Conclusion

GitHub Container Registry (GHCR) is a powerful and flexible solution for
managing your Docker images directly within GitHub. By enabling you to push,
pull, and deploy container images in your CI/CD workflows via GitHub Actions,
GHCR integrates seamlessly into modern development pipelines. With its advanced
access control options, you can manage permissions granularity to ensure the
security of your images.

With these tools, you’re now ready to use GHCR to optimize your CI/CD workflows,
enhance collaboration, and simplify Docker image management.
