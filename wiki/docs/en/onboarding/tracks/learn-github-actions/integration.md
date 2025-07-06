# Integration with Docker and Kubernetes in GitHub Actions

GitHub Actions can be used to automate Docker- and Kubernetes-related tasks,
such as building and publishing Docker images, as well as deploying these images
to Kubernetes clusters. In this documentation, we’ll explore how to use GitHub
Actions to integrate Docker and Kubernetes into your CI/CD pipelines.

---

## 1. Building and Pushing Docker Images with GitHub Actions

Docker is a lightweight virtualization tool that allows you to create containers
for running applications in isolated environments. With GitHub Actions, you can
automate the building of these containers and push them to a Docker registry
(such as Docker Hub or GitHub Container Registry).

### Steps to Build and Push Docker Images

1. **Write a Dockerfile** The Dockerfile contains the instructions to create a
   Docker image from your project. Here is a simple example of a Dockerfile for
   a Node.js application:

   ```dockerfile
   # Use an official Node.js base image
   FROM node:14

   # Set the working directory
   WORKDIR /app

   # Copy the package.json file
   COPY package*.json ./

   # Install dependencies
   RUN npm install

   # Copy the rest of the project files
   COPY . .

   # Expose the application’s port
   EXPOSE 3000

   # Start the application
   CMD ["npm", "start"]
   ```

2. **Configure GitHub Actions to build and push the image**

   Once the Dockerfile is created, you can set up a GitHub Actions workflow to
   build the Docker image and then push it to a Docker registry.

### Example Workflow: Building and Pushing a Docker Image

The following workflow runs when a change is pushed to the `main` branch. It
builds a Docker image from the Dockerfile and pushes it to Docker Hub.

```yaml
name: Build and Push Docker Image

# Trigger the workflow on a push to the 'main' branch
on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest # Use an Ubuntu environment

    steps:
      # Step 1: Checkout the repository
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Log in to Docker Hub
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }} # Store the username as a secret
          password: ${{ secrets.DOCKER_PASSWORD }} # Store the password as a secret

      # Step 3: Build the Docker image
      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_USERNAME }}/my-app:latest .

      # Step 4: Push the Docker image to Docker Hub
      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_USERNAME }}/my-app:latest
```

### Workflow Explanation 1

- **`docker/login-action@v2`**: This action logs into Docker Hub using securely
  stored username and password in the repository’s secrets.
- **`docker build`**: This command builds a Docker image from the Dockerfile in
  the project root.
- **`docker push`**: This command pushes the Docker image to Docker Hub.

### Using GitHub Container Registry

GitHub Container Registry (GHCR) is an alternative to Docker Hub for hosting
Docker images. It’s integrated with GitHub and allows you to store and manage
your container images alongside your source code.

#### Example Workflow to Push to GitHub Container Registry (GHCR)

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
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Log in to GitHub Container Registry
        run:
          echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{
          github.actor }} --password-stdin

      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/my-app:latest .

      - name: Push Docker image
        run: docker push ghcr.io/${{ github.repository }}/my-app:latest
```

In this example, the image is pushed to GitHub Container Registry instead of
Docker Hub.

---

## 2. Automating Kubernetes Deployments with GitHub Actions

Kubernetes is a popular container orchestrator used to deploy, manage, and scale
containerized applications. GitHub Actions can be used to automate the
deployment of Docker images to a Kubernetes cluster.

### Steps to Deploy on Kubernetes with GitHub Actions

1. **Configure `kubectl` to interact with your Kubernetes cluster** First,
   configure GitHub Actions to use `kubectl`, the Kubernetes command-line tool,
   to interact with your Kubernetes cluster.

2. **Use Secrets to Store Sensitive Information** Store sensitive information,
   such as Kubernetes cluster credentials and certificates, in GitHub secrets to
   use them securely.

### Example Workflow: Automated Kubernetes Deployment

The following workflow uses `kubectl` to deploy the Docker image to a Kubernetes
cluster after it has been pushed to Docker Hub.

```yaml
name: Deploy to Kubernetes

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout the repository
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Install kubectl
      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'latest'

      # Step 3: Configure access to the Kubernetes cluster
      - name: Set up kubeconfig
        run: |
          mkdir -p ~/.kube
          echo "${{ secrets.KUBECONFIG }}" > ~/.kube/config

      # Step 4: Update the Kubernetes deployment
      - name: Deploy to Kubernetes
        run: |
          kubectl set image deployment/my-app my-app-container=${{ secrets.DOCKER_USERNAME }}/my-app:latest
```

### Workflow Explanation 2

- **`azure/setup-kubectl@v3`**: This action installs `kubectl` in the workflow
  environment.
- **`kubeconfig`**: The `kubeconfig` file contains authentication information to
  interact with the Kubernetes cluster and is stored securely in GitHub secrets.
- **`kubectl set image`**: This command updates the Kubernetes deployment with
  the new container image.

At CEDILLE, we use GitOps tools like **ArgoCD** to automatically manage
deployments and synchronize applications with Kubernetes clusters. ArgoCD
simplifies automation by monitoring Git repositories for changes and
automatically applying them to clusters, eliminating the need to manually handle
these aspects via GitHub Actions.

---

## 3. Examples of Using `docker`, `kubectl`, and `helm` in CI/CD Workflows

By combining Docker, `kubectl`, and Helm, you can create powerful CI/CD
workflows to automate container management and Kubernetes deployments. Here is
an example of a GitHub Actions workflow that incorporates both `kubectl` and
**Helm**.

### Example: Using Docker with `kubectl` and Helm

In this example, we will build a Docker image, push it to Docker Hub, and then
update a Kubernetes deployment with this new image. We also demonstrate how to
use **Helm** to manage more complex deployments.

#### CI/CD Workflow for Docker and Kubernetes

```yaml
name: CI/CD for Docker and Kubernetes

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Step 2: Log in to Docker Hub
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      # Step 3: Build Docker image
      - name: Build Docker image
        run: docker build -t ${{ secrets.DOCKER_USERNAME }}/my-app:latest .

      # Step 4: Push Docker image
      - name: Push Docker image
        run: docker push ${{ secrets.DOCKER_USERNAME }}/my-app:latest

      # Step 5: Set up kubectl
      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'latest'

      # Step 6: Deploy to Kubernetes with kubectl
      - name: Update Kubernetes Deployment with kubectl
        run: |
          kubectl set image deployment/my-app my-app-container=${{ secrets.DOCKER_USERNAME }}/my-app:latest

      # Step 7 (optional): Deploy application with Helm
      - name: Install Helm
        run: |
          curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

      - name: Deploy application with Helm
        run: helm upgrade --install my-app ./helm-chart --set image.tag=latest
```

### Workflow Explanation 3

1. **kubectl**: Step 6 updates the Kubernetes deployment’s container image using
   `kubectl`.
2. **Helm**: Steps 7 and onward demonstrate how to install **Helm** and use it
   to deploy or update a Kubernetes application from a Helm chart. Helm is
   particularly useful for managing more complex Kubernetes deployments.
3. **Secrets**: The Kubernetes configuration file (`kubeconfig`)

is stored in GitHub secrets to ensure the security of authentication
information.

In this workflow, you can choose to use either **kubectl** for simple
deployments or **Helm** for more complex deployments. Integrating both tools in
the same workflow allows you to manage a variety of use cases depending on the
complexity of your Kubernetes deployments.

---

## Conclusion

Integrating Docker and Kubernetes into your CI/CD workflows with GitHub Actions
simplifies the building, testing, and deployment of containerized applications.
Whether using Docker to create images or Kubernetes to orchestrate these
containers, GitHub Actions provides the tools needed to fully automate these
processes. This enables you to build, test, and deploy applications smoothly and
securely while reducing manual errors.

By using `docker`, `kubectl`, and Helm in your workflows, you can create robust
and flexible pipelines suitable for production, testing, or any other Kubernetes
environment.
