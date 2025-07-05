# Understanding Bind Mounts in Docker

Docker isolates all content, code, and data within a container from your local
filesystem. Sometimes, however, you may want the container to access a directory
on your system. This is where bind mounts come in handy.

## Using Bind Mounts to Access Local Folders

If you want to access data on your system, you can use a bind mount. A bind
mount lets you share a directory from your host's filesystem into the container,
allowing the container to access and modify files in that directory.

### Example: Adding a Bind Mount to a Docker Compose Project

We will use the repository at
[https://github.com/docker/bindmount-apps](https://github.com/docker/bindmount-apps)
to demonstrate how to add a bind mount to a Docker Compose project.

**1. Clone the Repository:**

   ```bash
   git clone https://github.com/docker/bindmount-apps
   cd bindmount-apps
   ```

**2. Modify the `compose.yaml` File:**

   To add a bind mount to this project, open the `compose.yaml` file and
   uncomment the following lines:

   ```yaml
   services:
     todo-app:
       # ...
       volumes:
         - ./app:/usr/src/app
         - /usr/src/app/node_modules
   ```

**Explanation:**

- The `volumes` element tells Compose to mount the local folder `./app` to
     `/usr/src/app` in the container for the `todo-app` service. This particular
     bind mount overwrites the static contents of the `/usr/src/app` directory
     in the container and creates what is known as a development container.
- The second instruction, `/usr/src/app/node_modules`, prevents the bind
     mount from overwriting the container's `node_modules` directory to preserve
     the packages installed in the container.

**3. Run the Docker Compose Application:**

   Open a terminal in your project directory and run the following command:
   ```bash
   docker-compose up -d
   ```

   **Explanation:** This command will start the application with the configured
   bind mount. Docker will mount the `./app` directory from your host to
   `/usr/src/app` in the container.

**4. Developing with Bind Mounts:**

   Now, you can take advantage of the container’s environment while you develop
   the app on your local system. Any changes you make to the `app` directory on
   your local system are reflected in the container.

   For example, in your local directory, open `app/views/todos.ejs` in an IDE or
   text editor, update the `Enter your task` string, and save the file. Visit or
   refresh `http://localhost:3001` to see the changes.

## Summary

Bind mounts are useful for development environments where you need to interact
with the container and your local filesystem simultaneously. They allow you to
edit files on your host system and have those changes reflected inside the
container in real-time. This makes it easier to develop and test your
application without the need to rebuild the Docker image after every change.
