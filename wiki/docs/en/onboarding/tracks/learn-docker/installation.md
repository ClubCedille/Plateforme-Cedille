# Installation

Docker Inc. distributes several versions of Docker tailored for different
environments:

- **Docker Desktop**: Available for macOS and Windows, Docker Desktop provides
  an integrated environment for building, testing, and deploying containerized
  applications.
- **Docker Community Edition (CE)**: Designed for Linux environments, Docker CE
  is a free version of Docker suitable for personal use and small-scale
  deployments.
- **Docker Enterprise**: Catering to enterprise-level deployments, Docker
  Enterprise offers additional features like advanced management capabilities
  and enterprise-grade security.

## Installing Docker

### Docker Desktop

For **Windows** and **macOS**, Docker Desktop is the recommended choice. It
installs Docker Engine, Docker CLI client, Docker Compose, Docker Machine, and
Kubernetes tools, providing a comprehensive Docker environment.

- Windows Installation Guide: [Docker Desktop for
  Windows](https://docs.docker.com/desktop/install/windows/)
- macOS Installation Guide: [Docker Desktop for
  macOS](https://docs.docker.com/desktop/install/mac-install/)

![docker destop](img/docker-desktop.svg)

### Docker Community Edition (CE)

If you are using **Linux**, Docker CE is suitable for both personal use and
server deployments. Installation instructions can typically be found on the
[Docker website](https://docs.docker.com/engine/install/ubuntu/) or your Linux
distribution's package manager.

### Docker Enterprise

For organizations with complex Docker deployments, Docker Enterprise provides a
robust platform with enterprise-level support and additional management tools.

- More Information: [Docker
  Enterprise](https://www.docker.com/products/business/)

## Docker Hub

**Docker Hub** serves as a centralized resource for container image discovery,
distribution, and collaboration. Similar to GitHub, Docker Hub allows users to
store and share Docker images.

To get started with Docker and access Docker Hub, you need to create a Docker
Hub account:

- Sign up at [Docker Hub](https://hub.docker.com/).

![dockerhub](img/dockerhub.PNG)


## Installing Git (optionnal)

- **Windows:**

Download Git from [git-scm.com](https://git-scm.com/download/win) and run
the installer. Follow the prompts and choose the default options.

- **macOS:**

Git should already be available on macOS. You can verify by opening Terminal and typing:

    ```bash
    git --version
    ```
If Git is not installed, you will be prompted to install it.

- **Linux (Ubuntu/Debian):**

 Open a terminal and install Git using apt-get:

    ```bash
    sudo apt-get update
    sudo apt-get install git
    ```

- **Linux (Fedora):**

Open a terminal and install Git using dnf:

    ```bash
    sudo dnf install git
    ```

- **Other Linux Distributions:**

Use the package manager specific to your distribution to install Git.
