# Docker

Docker is a popular platform for building, shipping, and running applications in containers. Containers provide a lightweight and portable way to package and deploy software, allowing applications to run consistently across different environments, from development to production. Docker provides an easy-to-use interface for managing containers and images, making it easier for developers to create, test, and deploy applications.

With Docker, you can package an application and its dependencies into a container image, which can be easily shared and run on any system that supports Docker. Docker images can be built using a Dockerfile, which specifies the configuration of the container, such as the base image, environment variables, and application code.

Docker also provides a registry for storing and sharing Docker images, called Docker Hub, which contains a vast collection of pre-built images that can be used as a starting point for building custom images. But you can also create your own registry. Additionally, Docker provides a network interface for connecting containers and services, and a volume system for managing data persistence.

Overall, Docker provides a powerful and flexible toolset for developing and deploying applications in a containerized environment, helping to streamline the development and deployment process and improve application reliability and scalability.

Let's take a look at how we can use Docker to build and run the simple FastAPI application.

## Installing Docker

Docker is available for Linux, macOS, and Windows. You can download and install Docker from the [Docker website](https://www.docker.com/products/docker-desktop). I would highly recommend to install the Desktop version (for MacOS with M1/M2 chips there is no alternative). 

Start Docker Desktop and check the version:

```bash
docker --version
```

This will print the version of Docker installed on your system and you make sure that docker is installed.

## Building a Docker Image

For building a Docker image, we need to create a Dockerfile. A Dockerfile is a text file that contains the instructions for building a Docker image. It specifies the base image, environment variables, and application code that will be used to build the image. The Dockerfile for our example is shown below:

```dockerfile
# Use the official Python image as the base image
FROM python:3.10-slim-buster

# Set the working directory
WORKDIR /app

# Copy the application code to the working directory
COPY model.bin /app/
COPY requirements.txt /app/
COPY main.py /app/

# Install the dependencies from requirements.txt NOT requirements_dev.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port
EXPOSE 9696

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9696"]
```

The Dockerfile specifies the following:

- The base image to use for building the image. In this case, we are using the official Python image, which is based on the Debian Linux distribution.
- The working directory, which is the directory where the application code will be copied to.
- The application code to copy to the working directory.
- The dependencies to install.
- The port to expose. When we run the container, we will map this port to a port on the host machine. This makes the port accessible from outside the container.
- The command to run when the container starts.

## Building the Docker Image

To build the Docker image, we need to run the following command inside the service folder:

```bash
docker build -t fastapi-docker .
```

This command will build the Docker image using the Dockerfile in the current directory. The `-t` flag specifies the name of the image, and the . specifies the path to the Dockerfile.

## Running the Docker Image

To run the Docker image, we need to run the following command:

```bash
docker run -d --name fastapi -p 9696:9696 fastapi-docker
```

This command will run the Docker container in detached mode, mapping the port 9696 on the host machine to the port 9696 on the container. The `-d` flag specifies that the container should run in detached mode, and the `-p` flag specifies the port mapping. The `--name` flag specifies the name of the container, and the `fastapi-docker` specifies the name of the image to run.

Now we can access the application at http://localhost:9696/docs.

## Stopping the Docker Container

To stop the Docker container, we need to run the following command:

```bash
docker stop fastapi
```
