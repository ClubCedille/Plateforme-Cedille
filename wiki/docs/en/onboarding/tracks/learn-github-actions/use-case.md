# Practical Use Cases: DevOps with GitHub Actions

GitHub Actions is a powerful tool for implementing CI/CD pipelines in a DevOps
environment. It enables automation throughout the development lifecycle,
including builds, tests, deployments, and integration with cloud services and
Docker containers. This guide presents detailed use cases for implementing
robust CI/CD pipelines using GitHub Actions, Docker, and AWS.

---

## 1. Deploying a Node.js Application with Docker and GitHub Actions

In this example, we’ll see how to automate the deployment of a Dockerized
Node.js application using Docker and GitHub Actions.

### 1.1. Preparing the Dockerfile

Start by creating a `Dockerfile` to containerize the Node.js application.

#### Sample Node.js Dockerfile

```dockerfile
# Use a Node.js base image
FROM node:14

# Create a working directory in the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the remaining application files
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
```

### 1.2. Creating a GitHub Actions Workflow for Build and Deployment

Next, configure GitHub Actions to automate building and deploying this
application to a server or Docker service. The following workflow builds the
Docker image and pushes it to **GitHub Container Registry** (GHCR).

#### Sample Workflow: Build and Push Docker Image

```yaml
name: Build and Deploy Node.js Docker App

on:
  push:
    branches:
      - main # Trigger workflow on pushes to the 'main' branch

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Authenticate with GitHub Container Registry (GHCR)
      - name: Log in to GitHub Container Registry
        run:
          echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io -u ${{
          github.actor }} --password-stdin

      # Step 3: Build the Docker image
      - name: Build Docker image
        run: docker build -t ghcr.io/${{ github.repository }}/node-app:latest .

      # Step 4: Push the image to GHCR
      - name: Push Docker image to GitHub Container Registry
        run: docker push ghcr.io/${{ github.repository }}/node-app:latest
```

### 1.3. Deploying the Application

Now, you can deploy the Docker image to a production server or a service like
**Docker Swarm**, **Kubernetes**, or **AWS ECS**.

---

## 2. CI/CD for a Python Application Hosted on AWS with Docker Integration

This example demonstrates setting up a CI/CD pipeline for a Dockerized Python
application hosted on **AWS Elastic Beanstalk** with Docker integration.

### 2.1. Preparing the Dockerfile for the Python Application

Create a `Dockerfile` to containerize the Python application. This example
demonstrates a Dockerfile for a Flask app.

#### Sample Python Dockerfile

```dockerfile
# Use a Python base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the source code
COPY . .

# Expose the application port
EXPOSE 5000

# Start the Flask app
CMD ["python", "app.py"]
```

### 2.2. Configuring a GitHub Actions Workflow for AWS Elastic Beanstalk

The following workflow is designed to build the Docker image and automatically
deploy it to AWS Elastic Beanstalk.

#### Sample Workflow: Build and Deploy on AWS Elastic Beanstalk

```yaml
name: Build and Deploy to AWS Elastic Beanstalk

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: AWS Authentication
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      # Step 3: Build the Docker image
      - name: Build Docker image
        run: docker build -t my-python-app:latest .

      # Step 4: Deploy the application to Elastic Beanstalk
      - name: Deploy to Elastic Beanstalk
        run: |
          zip -r app.zip .
          aws elasticbeanstalk create-application-version --application-name MyPythonApp --version-label latest --source-bundle S3Bucket=my-app-bucket,S3Key=app.zip
          aws elasticbeanstalk update-environment --environment-name MyPythonApp-env --version-label latest
```

---

## 3. Automating a Complete DevOps Pipeline: Testing, Building, Deploying

This example demonstrates setting up a full DevOps pipeline, including automated
testing, building, and deploying an application.

### 3.1. Comprehensive Workflow with Unit Tests, Build, and Deployment

The following workflow automates the entire process of testing, building, and
deploying a Node.js application hosted on **Heroku**.

#### Sample Comprehensive Workflow

```yaml
name: CI/CD Pipeline for Node.js App

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Install dependencies
      - name: Install dependencies
        run: npm install

      # Step 3: Run unit tests
      - name: Run unit tests
        run: npm test

  build:
    runs-on: ubuntu-latest
    needs: test # Executes after the 'test' job

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Build the application
      - name: Build application
        run: npm run build

  deploy:
    runs-on: ubuntu-latest
    needs: build # Executes after the 'build' job

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Authenticate with Heroku
      - name: Login to Heroku
        run:
          echo "${{ secrets.HEROKU_API_KEY }}" | docker login --username=_
          --password-stdin registry.heroku.com

      # Step 3: Deploy the image to Heroku
      - name: Deploy to Heroku
        run: |
          docker build -t registry.heroku.com/my-app/web .
          docker push registry.heroku.com/my-app/web
          heroku container:release web --app my-app
```

#### Explanation

- **Tests**: Runs unit tests using `npm test`.
- **Build**: If the tests pass, the application is built with `npm run build`.
- **Deployment**: If the build is successful, the application is deployed to
  Heroku using Docker images.

### 3.2. Success or Failure Notification

You can add Slack notifications to alert the team about CI/CD pipeline success
or failure.

#### Example: Slack Notification after Build

```yaml
name: CI/CD Pipeline with Slack Notifications

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout the source code
      - name: Checkout code
        uses: actions/checkout@v2

      # Step 2: Install dependencies
      - name: Install dependencies
        run: npm install

      # Step 3: Build the application
      - name: Build application
        run: npm run build

      # Step 4: Deploy the application
      - name: Deploy application
        run: ./deploy.sh

  notify:
    runs-on: ubuntu-latest
    needs: build-and-deploy

    steps:
      - name: Send Slack notification on success
        if: success()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build succeeded for ${{ github.repository }}!"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: Send Slack notification on failure
        if: failure()
        run: |
          curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"Build failed for ${{ github.repository }}!"}' \
          ${{ secrets.SLACK_WEBHOOK_URL }}
```

---

## 4. Collaboration with Teams: GitHub Organizations and Teams

In a DevOps environment, effective collaboration within teams and organizations
on GitHub is essential.

### 4.1. Managing GitHub Teams

GitHub allows managing teams within an organization, enabling:

- **Permission Management**: Assign specific access roles (read, write, admin)
  to different members or teams.
- **Shared Secrets**: Organization-wide secrets can be used across repositories,
  facilitating shared authentication for external services (like AWS, Docker,
  etc.).

### 4.2. Shared Workflow Across Multiple Repositories

You can create reusable workflows at the organizational level to share across

multiple repositories.

#### Example: Reusable Workflow for Builds

```yaml
name: Reusable Build Workflow

on: workflow_call

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install dependencies
        run: npm install

      - name: Build application
        run: npm run build
```

In each repository, you can then call this reusable workflow to standardize the
build process across the organization.

---

## Conclusion

These practical use cases demonstrate how GitHub Actions can be used to automate
the full DevOps lifecycle. Whether working with Node.js, Python, Docker, or AWS,
GitHub Actions enables building robust, automated, and scalable CI/CD pipelines.
By integrating tests, builds, notifications, and team collaboration through
GitHub organizations, you can easily manage and optimize your DevOps processes
while ensuring smooth team collaboration across the organization.
