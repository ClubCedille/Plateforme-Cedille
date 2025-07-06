# Setting up your first Docker container

## Install Docker

Before you begin, make sure Git and Docker is installed on your system. You can
download Docker from the
[official Docker website](https://www.docker.com/products/docker-desktop/).

## Running Your First Docker Container

**1. Clone the Repository:**

Open your terminal or command prompt after Git is installed and clone the
'welcome-to-docker' repository from GitHub using the following command:

```bash
git clone https://github.com/docker/welcome-to-docker
```

**2. Navigate to the Repository:**

Change your current directory to the cloned repository:

```bash
cd welcome-to-docker
```

**3. Run the Docker Container:**

Use the `docker run` command to start the container. In this case, we'll run the
'welcome-to-docker' container and map port 8088 on your host to port 80 inside
the container:

```bash
docker run -d -p 8088:80 docker/getting-started
```

- `-d`: Runs the container in detached mode, meaning it runs in the background.
- `-p 8088:80`: Maps port 8088 on your local machine to port 80 inside the
  container. This allows you to access the container's web service from your
  browser at `http://localhost:8088`.

**4. Access the Container:**

Open your web browser and navigate to
`http://localhost:8088`. You should see the
'welcome-to-docker' web page, indicating that the container is running
successfully.

## Search, Pull, and Run Containers from Docker Hub

**1. Search for Containers on Docker Hub:**

You can search for containers on Docker Hub using the `docker search` command.
For example, to search for containers related to **nginx**, use:

```bash
docker search nginx
```

**2. Pull a Container from Docker Hub:**

Use the `docker pull` command to download a container image from Docker Hub. For
example, to pull the official **nginx** container image, use:

```bash
docker pull nginx
```

**3. Run a Container from Pulled Image:**

Once you've pulled an image, you can run a container from it using `docker run`.
For example, to run an **nginx** container and map port 8080 on your host to
port 80 inside the container, use:

```bash
 docker run -d -p 8080:80 nginx
```

- `-d`: Runs the container in detached mode.
- `-p 8080:80`: Maps port 8080 on your local machine to port 80 inside the
  container.

## Stopping the Docker Container

**1. Find the Container ID or Name:**

Open a new terminal window and list all running Docker containers:

```bash
docker ps
```

- Note down the Container ID or Name of the running container.

![docker-ps](img/docker-ps.png)

**2. Stop the Container:**

Stop the container using the `docker stop` command followed by the Container ID
or Name:

```bash
docker stop <container_id_or_name>
```

- Replace `<container_id_or_name>` with the actual ID or Name of your container.

**3. Verify the Container Stopped:**

To verify that the container has stopped, you can list all containers (including
stopped ones) with:

```bash
docker ps -a
```

The stopped container should no longer be listed as running.

## Summary

Congratulations ! You've successfully run and stopped Docker containers, as well
as pulled and run containers from Docker Hub. Docker provides a powerful way to
manage and deploy applications in a consistent and efficient manner, making
development and deployment workflows smoother and more reliable.
