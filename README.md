# DevOps Module 4 Activity 2

An Express.js greeting application containerized with Docker for COMP-4001: Developing in a DevOps Environment.

## Project Structure

```
DEVOPS-MODULE-4-ACTIVITY2/
├── server.js
├── package.json
├── public/
│   └── index.html
├── Dockerfile
└── .dockerignore
```

## Description

This project demonstrates how to containerize a Node.js Express web application using Docker. The app accepts a user's name via a form and returns a personalized greeting along with the container's IP address.

## Docker Build and Run

Build the image:

```bash
docker build -t express-greeting-app .
```

Run the container:

```bash
docker run -p 3000:3000 express-greeting-app
```

Open your browser and navigate to `http://192.168.56.67:3000`.

## Dockerfile Best Practices

- **Dependency caching**: `package.json` is copied and `npm install` runs before copying the rest of the app to leverage Docker layer caching.
- **Production dependencies**: `npm install --production` installs only runtime dependencies, reducing image size.
- **Non-root user**: The container runs as `appuser` instead of root for improved security.

## Author

COMP-4001 DevOps Module 4 Activity 2
