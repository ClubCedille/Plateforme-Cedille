### Working with Docker Hub

[Docker Hub](https://hub.docker.com/) is a cloud-based repository where Docker users and partners create, test, store, and distribute container images. It is the world's largest library and community for container images. In this guide, we'll show you how to interact with Docker Hub, including how to pull and push images, and highlight some of the useful features available on Docker Hub.

## Setting Up Docker Hub

**1. Create a Docker Hub Account:**

   Before you can use Docker Hub, you'll need to create an account. Visit the [Docker Hub website](https://hub.docker.com/) and sign up for a free account.

**2. Log In to Docker Hub:**

   Open your terminal and log in to Docker Hub using your account credentials:
   ```
   docker login
   ```

   You will be prompted to enter your Docker Hub username and password. Once authenticated, you can start interacting with Docker Hub.

## Pulling Images from Docker Hub

Docker Hub hosts a vast number of pre-built container images that you can use in your projects. To pull an image from Docker Hub, use the `docker pull` command.

**1. Search for an Image:**

   To find an image, you can search Docker Hub using the following command:
   ```
   docker search <image-name>
   ```

   For example, to search for a Node.js image, you would use:
   ```
   docker search node
   ```

   This command lists available images with the name "node" in Docker Hub.

**2. Pull an Image:**

   Once you find the image you need, you can pull it to your local machine:
   ```
   docker pull <image-name>
   ```

   For example, to pull the official Node.js image, you would use:
   ```
   docker pull node
   ```

   This command downloads the image from Docker Hub to your local system.

**3. Run the Pulled Image:**

   After pulling the image, you can run it using the `docker run` command:
   ```
   docker run -d -p 3000:3000 node
   ```

   This command starts a container from the Node.js image and maps port 3000 on your local machine to port 3000 in the container.

## Pushing Images to Docker Hub

If you have created a custom Docker image that you want to share with others, you can push it to Docker Hub.

**1. Tag Your Image:**

   Before you can push your image, you need to tag it with your Docker Hub username and repository name:
   ```
   docker tag <local-image> <dockerhub-username>/<repository-name>:<tag>
   ```

   For example, if your Docker Hub username is "myusername" and your repository name is "myapp", you would use:
   ```
   docker tag myapp myusername/myapp:latest
   ```

**2. Push the Image:**

   Once your image is tagged, you can push it to Docker Hub:
   ```
   docker push <dockerhub-username>/<repository-name>:<tag>
   ```

   Using the previous example, you would use:
   ```
   docker push myusername/myapp:latest
   ```

   This command uploads your image to Docker Hub, making it available for others to pull and use.

## Useful Features of Docker Hub

**1. Automated Builds:**

   Docker Hub can automatically build images from a GitHub or Bitbucket repository. This is useful for continuous integration and continuous deployment (CI/CD) workflows. You can set up automated builds in the Docker Hub repository settings.

**2. Webhooks:**

   Webhooks allow you to trigger actions after a successful push or pull of an image. You can use webhooks to integrate Docker Hub with other services, such as triggering a deployment process after an image is pushed.

**3. Organizations and Teams:**

   Docker Hub supports organizations and teams, making it easier to manage permissions and collaborate on projects. You can create an organization, add team members, and assign roles to control who can access and modify your images.

**4. Official Images:**

   Docker Hub hosts a variety of official images that are maintained by Docker and other trusted entities. These images are generally well-documented, regularly updated, and provide a good starting point for many applications.

**5. Repositories:**

   You can create multiple repositories under your Docker Hub account to organize your images. Each repository can hold multiple versions of an image, tagged with different tags (e.g., `latest`, `v1.0`, `v2.0`).

**6. Image Insights:**

   Docker Hub provides insights into your images, such as the number of pulls, stars, and the last updated time. This information can help you track the popularity and usage of your images.

## GitHub Container Registry

[GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry) is another popular option for storing and managing container images that Club Cedille uses a lot. It is tightly integrated with GitHub, making it a convenient choice for developers who already use GitHub for source code management. Here are some key features:

**1. Integration with GitHub Repositories:**

   - GitHub Container Registry allows you to store container images alongside your code repositories. This integration simplifies your workflow by keeping your code and container images in one place.

**2. Access Control and Permissions:**

   - You can control who has access to your container images using GitHub's existing permission model. This makes it easy to manage access for your team members.

**3. Support for Public and Private Images:**

   - Similar to Docker Hub, GitHub Container Registry supports both public and private images. You can choose to share your images with the community or restrict access to specific users or teams.

**4. GitHub Actions Integration:**

   - You can use GitHub Actions to automate your workflows, including building and pushing images to the GitHub Container Registry. This is useful for CI/CD pipelines, ensuring that your images are always up-to-date.

**5. Free for Public Repositories:**

   - GitHub Container Registry offers free usage for public repositories, making it an attractive option for open-source projects.

## Summary

Docker Hub is a powerful platform for sharing and distributing Docker images. By leveraging Docker Hub, you can streamline your development and deployment workflows, collaborate with others, and access a vast library of container images. Whether you're pulling official images for your projects or sharing your custom images with the community, Docker Hub is an essential tool in the Docker ecosystem.

If you're interested you could also check out one of the [Cedille Club's GitHub pipeline packages](https://github.com/orgs/ClubCedille/packages). GitHub pipeline packages are a set of tools and configurations that help automate various aspects of the software development lifecycle, such as building, testing, and deploying applications. By using these packages, developers can ensure consistent and repeatable processes, improve efficiency, and reduce the chances of errors during deployment.