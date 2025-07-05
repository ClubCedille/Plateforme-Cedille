# What is Docker?

Docker is an [open-source platform](https://www.docker.com) that allows you to
package your application along with all its dependencies into a standardized
unit called a container. These containers are lightweight and portable, meaning
you can easily move them across different environments. Each container is
isolated from the underlying infrastructure and other containers, ensuring
consistency and security. Once you have created a Docker image, you can run it
as a Docker container on any machine with Docker installed, regardless of the
operating system. This eliminates the need to worry about compatibility issues,
as the container encapsulates everything the application needs to run.

![docker](img/docker.jpg)

## Why Choose Docker?

Docker has become popular because of its significant impact on software
development and deployment. Here are some key reasons for its widespread
adoption:

1. **Portability**: Docker allows developers to package their applications along
   with all dependencies into lightweight containers. This ensures consistent
   performance across various computing environments, from development to
   production.

2. **Reproducibility**: By encapsulating applications and their dependencies
   within containers, Docker ensures that software setups remain consistent
   across development, testing, and production environments. This reduces the
   "it works on my machine" problem.

3. **Efficiency**: Docker's container-based architecture optimizes resource
   utilization. It allows multiple isolated applications to run on a single host
   system, making better use of available resources and improving overall
   efficiency.

4. **Scalability**: Docker makes it easier for developers to handle increased
   workloads. Its scalability features allow applications to scale up or down
   seamlessly, ensuring they can handle varying levels of demand without issues.

## Important Components of Docker

Here are some of the key components of Docker, explained in detail:

1. **Docker Daemon (Docker Engine)**: This is the core part of Docker that
   handles the creation, running, and management of containers. It consists of a
   server (a long-running daemon process),
   [REST API](https://docs.docker.com/engine/api/v1.41/), and a command-line
   interface (CLI).

2. **Docker Image**: A
   [Docker image](https://docs.docker.com/engine/reference/glossary/#image) is a
   read-only template that includes your application code, libraries, and
   dependencies. It is used to create containers. Once an image is built, it can
   be used to run containers repeatedly, ensuring consistency across different
   environments.

3. **Docker Hub**: [Docker Hub](https://hub.docker.com) is a cloud-based
   repository where you can find, share, and manage Docker images. It allows you
   to upload your own images and download images created by others, facilitating
   easy sharing and collaboration.

4. **Dockerfile**: A
   [Dockerfile](https://docs.docker.com/engine/reference/builder/) is a script
   that contains a series of instructions on how to build a Docker image. It
   includes commands to specify the base image, install software packages, copy
   files, and set environment variables. By running a Dockerfile, you can create
   a Docker image.

5. **Docker Registry**: A [Docker registry](https://docs.docker.com/registry/)
   is a storage and distribution system for Docker images. You can store images
   in both public and private modes. Public registries, like Docker Hub, allow
   anyone to access the images, while private registries restrict access to
   specific users or organizations. This allows for secure storage and
   distribution of images within a team or company.

![components](img/components.png)

## What is a Dockerfile?

A [Dockerfile](https://docs.docker.com/engine/reference/builder/) uses a Domain
Specific Language (DSL) and contains instructions for generating a Docker image.
The Dockerfile defines the processes to quickly produce an image. When creating
your application, you should create a Dockerfile in a specific order, as the
Docker daemon runs all the instructions from top to bottom.

- A Dockerfile is a text document containing necessary commands that, when
  executed, help assemble a Docker image.
- Docker images are created using Dockerfiles.

## What is a Docker Image?

A [Docker Image](https://docs.docker.com/engine/reference/glossary/#image) is a
file composed of multiple layers, used to execute code in a Docker container. It
is essentially a set of instructions for creating Docker containers.

- **Executable Package**: A Docker image is an executable package of software
  that includes everything needed to run an application, such as the code,
  runtime, libraries, environment variables, and configuration files.

- **Set of Instructions**: The image contains all the instructions on how to
  create and run a container, determining which software components will run and
  how they should be configured.

- **Container Creation**: When a Docker image is run, it creates a Docker
  container. The container is a virtual environment that encapsulates the
  application code along with all its dependencies, ensuring the application
  runs quickly and reliably across different computing environments.

## What is a Docker Container?

A
[Docker container](https://docs.docker.com/engine/reference/glossary/#container)
is a runtime instance of a Docker image. It allows developers to package
applications along with all the necessary dependencies, such as libraries and
configurations, into a single unit.

- **Runtime Instance**: A container is essentially a live instance of an image
  that is running as a process on the host machine. It encapsulates the
  application code and its runtime environment, ensuring the application can run
  in an isolated and consistent manner across different environments.

- **Isolated Execution**: Containers provide isolation for applications, meaning
  they run independently of the host and other containers. This isolation
  ensures that changes or dependencies within one container do not affect
  others, enhancing security and reliability.

- **Example**: For instance, if you have a Docker image containing Ubuntu OS
  with an Nginx server configured, running this image with the `docker run`
  command will create a container. This container will then run the Nginx server
  within the Ubuntu OS environment, isolated from other containers and the host
  system.

## What is a Container Registry?

A [container registry](https://docs.docker.com/registry/) is a service where
developers and DevOps teams can store, manage, and share container images. It
serves as a centralized resource for container images, allowing users to push
their own images for private or public use and pull images created by others.
Container registries can be cloud-based or on-premises, and they support a
variety of use cases and workflows in the development and deployment of
containerized applications.

### Key Features of a Container Registry

- **Repository Service**: A container registry acts as a repository where
  container images are stored and organized. Users can upload their container
  images to the registry for storage and distribution.

- **Cloud-Based and On-Premises Options**: Container registries can operate on
  the cloud or be hosted on-premises. Cloud-based registries offer the benefit
  of accessibility from anywhere via the internet, while on-premises registries
  provide more control over the infrastructure and data.

- **Public and Private Registries**: Container registries support both public
  and private repositories. Public repositories allow images to be shared openly
  with the community, while private repositories restrict access to authorized
  users or teams.

- **Usage in DevOps**: Container registries are widely used by DevOps teams for
  managing containerized applications. They facilitate collaboration by enabling
  teams to share and deploy standardized images reliably.

- **Availability and Requirements**: Container registries are available for all
  operating systems and are essential tools for anyone working with containers.
  Users accessing a container registry need basic knowledge of container
  commands to push and pull images effectively.

### Popular Container Registries

- **Docker Hub**: A widely-used [cloud-based registry](https://hub.docker.com)
  provided by Docker. It allows users to store and share container images
  publicly or privately.

- **Amazon Elastic Container Registry (ECR)**: A managed container registry
  service by [AWS](https://aws.amazon.com/ecr/) that integrates with other AWS
  services and supports both public and private repositories.

- **Google Container Registry (GCR)**: A private container registry provided by
  [Google Cloud Platform](https://cloud.google.com/container-registry), offering
  high availability and integration with Google Cloud services.

- **Azure Container Registry (ACR)**: A managed container registry service by
  [Microsoft Azure](https://azure.microsoft.com/en-us/services/container-registry/)
  that supports Docker and Open Container Initiative (OCI) images.

- **GitHub Container Registry**: A service provided by
  [GitHub](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
  for storing and managing container images alongside source code repositories.
