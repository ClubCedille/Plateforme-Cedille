## What is Docker Compose?

[Docker Compose](https://docs.docker.com/compose/) is a tool that allows you to
define and manage multi-container Docker applications. With Docker Compose, you
can describe the configuration of your application’s services in a
[YAML file](https://www.redhat.com/en/topics/automation/what-is-yaml#:~:text=YAML%20is%20a%20human%2Dreadable,is%20for%20data%2C%20not%20documents.),
making it easy to start, stop, and manage the entire application stack with a
single command.

## Example Application with Docker Compose

In this example, we will run a simple todo application built using ExpressJS and
Node.js, with todos saved in a MongoDB database.

**1. Clone the Repository:**

Open your terminal or command prompt and clone the repository containing the
sample application:

```sh
git clone https://github.com/docker/multi-container-app
```

**Explanation:** This command downloads a copy of the repository to your local
machine.

**2. Navigate to the Repository:**

Change your current directory to the cloned repository:

```sh
cd multi-container-app
```

**Explanation:** This command changes the current working directory to the
`multi-container-app` folder where the application code is located.

**3. Explore the `compose.yaml` File:**

The `compose.yaml` file defines the services (containers) needed to run the
application. Open this file in a text editor to see the configuration:

```yaml
version: '3'
services:
  web:
    image: node:14
    working_dir: /app
    volumes:
      - .:/app
    ports:
      - '3000:3000'
    command: 'npm start'
  database:
    image: mongo:4.2
    ports:
      - '27017:27017'
```

**Explanation:** This YAML file defines two services: `web` and `database`. The
`web` service uses a Node.js image and runs the application, while the
`database` service uses a MongoDB image. Ports are mapped to allow access from
your host machine.

**4. Run the Application:**

Use the `docker compose up` command to build and run the application:

```sh
docker compose up -d
```

**Explanation:**

- `docker compose up`: Builds, (re)creates, starts, and attaches to containers
  for a service.
- `-d`: Runs the containers in detached mode, meaning they run in the
  background.

**5. Access the Application:**

Open your web browser and navigate to `http://localhost:3000`. You should see
the todo application running.

**Explanation:** The `web` service maps port 3000 in the container to port 3000
on your host machine, making the application accessible via
`http://localhost:3000`.

**6. Interact with the Application:**

Add some tasks in the frontend. The tasks are saved in the MongoDB database.

**Explanation:** The `database` service uses MongoDB, which stores the tasks you
add through the frontend.

**7. Stop the Application:**

To stop the running containers, use the `docker compose down` command:

```sh
docker compose down
```

**Explanation:** This command stops and removes containers, networks, volumes,
and images created by `docker compose up`.

## Detailed Breakdown of `compose.yaml`

- **version:** Specifies the version of Docker Compose syntax being used.
- **services:** Defines the different services (containers) that make up your
  application.
  - **web:**
    - **image:** Specifies the Docker image to use for this service (`node:14`).
    - **working_dir:** Sets the working directory inside the container to
      `/app`.
    - **volumes:** Maps the current directory on the host to `/app` in the
      container, allowing code changes to be reflected without rebuilding the
      image.
    - **ports:** Maps port 3000 on the host to port 3000 in the container.
    - **command:** Runs the command `npm start` to start the application.
  - **database:**
    - **image:** Specifies the Docker image to use for this service
      (`mongo:4.2`).
    - **ports:** Maps port 27017 on the host to port 27017 in the container.

## Additional Docker Compose Features

#### Real-Time Updates with `docker compose watch`

When developing with Docker, you may need to automatically update and preview
your running services as you edit and save your code. The `docker compose watch`
command helps with this.

**1. Run the Application with Watch Mode:**

```sh
docker compose watch
```

**Explanation:** This command monitors changes in your source code and
automatically restarts the affected services.

**2. Make Real-Time Changes:**

Change the text in line 18 of `app/views/todos.ejs` to see your changes in
real-time.

**Explanation:** Modifying the code in your project directory will trigger a
restart of the relevant service, reflecting changes immediately.

**3. Stop Watch Mode:**

Use `Ctrl + C` to stop watch mode.

**Explanation:** This keyboard shortcut interrupts the watch command, stopping
it from running.

## Managing Your Application Stack

Having your configuration stored in a Compose file makes it easy to manage your
application stack.

**2. Delete and Restart the Application:**

Simply select the app stack in Docker Desktop and then select Delete. When you
want to restart, run `docker compose up` in the project folder again. Note that
when the db container is deleted, any todos created are also lost.

**Explanation:** Docker Desktop provides a graphical interface to manage your
containers. Deleting and restarting the stack using Docker Compose commands
ensure a clean state.

## Example: Setting up a Simple Web Application with Docker Compose

Let's create a basic example using Docker Compose to run a web application with
a frontend and backend service.

**1. Install Docker Compose:**

Docker Compose typically comes bundled with Docker Desktop for Windows and
macOS. For Linux users, you can follow the installation instructions from the
[official Docker documentation](https://docs.docker.com/compose/install/).

**2. Create a Docker Compose YAML File:**

Create a file named `docker-compose.yml` in your project directory. This file
will define the services, networks, and volumes for your application.

```yaml
version: '3.8' # Use the latest version of Compose syntax

services:
  frontend:
    image: nginx:latest
    ports:
      - '8080:80'
    volumes:
      - ./frontend:/usr/share/nginx/html
    networks:
      - app-network

  backend:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: myapp
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - app-network

networks:
  app-network:

volumes:
  db-data:
```

**Explanation:**

- `version`: Specifies the Docker Compose file format version.
- `services`: Defines the containers that make up your application (`frontend`
  and `backend` in this example).
- `frontend`:
  - `image`: Specifies the Docker image to use (nginx in this case).
  - `ports`: Maps port 8080 on the host to port 80 inside the container.
  - `volumes`: Mounts the `./frontend` directory on the host to
    `/usr/share/nginx/html` in the container.
  - `networks`: Attaches the container to the `app-network`.
- `backend`:
  - `image`: Specifies the Docker image for the backend service (mysql:5.7).
  - `environment`: Sets environment variables required by MySQL.
  - `volumes`: Mounts a volume named `db-data` to persist MySQL data.
  - `networks`: Attaches the container to the `app-network`.
- `networks`: Defines a network named `app-network` for communication between
  services.
- `volumes`: Defines a volume named `db-data` for persistent storage of MySQL
  data.

**3. Run Your Docker Compose Application:**

Open a terminal or command prompt in your project directory where
`docker-compose.yml` is located, and run the following command:

```sh
docker-compose up -d
```

**Explanation:**

- `docker-compose up`: Builds, (re)creates, starts, and attaches to containers
  for a service.
- `-d`: Runs containers in detached mode (in the background).

**4. Access Your Application:**

The frontend service (nginx) will be accessible at `http://localhost:8080` in
your web browser.

**Explanation:** The `frontend` service maps port 80 in the container to port
8080 on your host machine, making the application accessible via
`http://localhost:8080`.

**5. Stop and Remove Containers:**

To stop and remove containers created by `docker-compose up`, use the following
command:

```sh
docker-compose down
```

**Explanation:** This command stops and removes containers, networks, volumes,
and images created by `docker-compose up`.

## Summary

Docker Compose simplifies the process of managing multi-container Docker
applications by allowing you to define and run them.

If your'e interested you could also check out the one of the
[CEDILLE Club's GitHub Actions workflow configuration file](https://github.com/ClubCedille/point-virgule/blob/master/.github/workflows/main.yml).
GitHub Actions is a CI/CD service provided by GitHub, allowing you to automate
the build, test, and deployment of your code.
