Docker isolates all content, code, and data within a container from your local
filesystem. This means that when you delete a container, all the content within
it is deleted. Sometimes, you may want to persist data that a container
generates. This is where Docker volumes come in handy.

## Using Docker Volumes to Persist Data

If you want to persist data even after a container is deleted, you can use a
volume. A volume is a location in your local filesystem that is managed by
Docker. Volumes are useful because they allow you to store data outside of the
container’s lifecycle.

### Example: Adding a Volume to a Docker Compose Project

We will reuse the repository at
[https://github.com/docker/multi-container-app](https://github.com/docker/multi-container-app)
to demonstrate how to add a volume to a Docker Compose project.

**1. Clone the Repository:**

   ```
   git clone https://github.com/docker/multi-container-app
   cd multi-container-app
   ```

**2. Modify the `compose.yaml` File:**

   To add a volume to this project, open the `compose.yaml` file and uncomment
   the following lines:

   ```yaml
   services:
     todo-database:
       # ...
       volumes:
         - database:/data/db

   # ...
   volumes:
     database:
   ```

**Explanation:**

   - The `volumes` element nested within `todo-database` tells Compose to mount
     the volume named `database` to `/data/db` in the container for the
     `todo-database` service.
   - The top-level `volumes` element defines and configures a volume named
     `database` that can be used by any of the services in the Compose file.

**3. Run the Docker Compose Application:**

   Open a terminal in your project directory and run the following command:
   ```
   docker-compose up -d
   ```

   This command will start the application with the configured volume. Docker
   will check for the `database` volume and create it if it does not exist.

**4. Persisting Data:**

   Now, no matter how often you delete and restart the container, your data is
   persisted. The data stored in the `/data/db` directory within the container
   is saved to the `database` volume. This volume is accessible to any container
   on your system by mounting the `database` volume.

   To stop and remove containers, networks, and volumes created by `docker-compose up`, use:
   ```
   docker-compose down
   ```

   To remove the volume as well, use:
   ```
   docker-compose down -v
   ```

## Summary

Volumes in Docker provide a powerful way to persist and share data between
containers. They ensure that your data remains intact and accessible even if the
containers are deleted or restarted. By leveraging volumes, you can build robust
and reliable containerized applications that manage and store data efficiently.
