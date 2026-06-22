# DevOps Module 4 Activity 2

An Express.js greeting application containerized with Docker for COMP-4001: Developing in a DevOps Environment.

## Project Structure

```
module4-activity2/
├── .github/workflows/ci-cd.yml   # GitHub Actions CI/CD pipeline
├── server.js
├── package.json
├── public/
│   └── index.html
├── Dockerfile
├── deploy-remote.sh              # Deployment script used by CD
├── vm-deploy.sh                  # Local Vagrant deployment script
├── scripts/
│   └── setup-github-runner.sh    # One-time VM runner setup
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

## CI/CD Pipeline

The GitHub Actions workflow in `.github/workflows/ci-cd.yml` provides:

| Stage | Trigger | What it does |
|-------|---------|--------------|
| **CI** | Every push and pull request to `main` | Builds the Docker image, runs the container, and smoke-tests GET/POST |
| **CD** | Push to `main` or manual run | Deploys on the Vagrant VM via a self-hosted runner |

### One-time VM setup (self-hosted runner)

CD deploys on your Vagrant VM using a GitHub Actions self-hosted runner (required because the VM uses a private IP that GitHub cloud runners cannot reach).

1. Start the VM:

   ```bash
   vagrant up
   vagrant ssh
   ```

2. Inside the VM, clone or sync this repo, then run:

   ```bash
   cd /vagrant   # or your project path
   bash scripts/setup-github-runner.sh
   ```

3. When prompted, paste the registration token from:
   [GitHub → Settings → Actions → Runners → New self-hosted runner](https://github.com/Rajandeep1/Module4-devops-activity2/settings/actions/runners/new)

4. Log out and back in (or run `newgrp docker`) so Docker works without `sudo`.

### Using the pipeline

- **Push to `main`** — CI runs on GitHub, then CD deploys on the VM automatically.
- **Open a pull request** — CI runs only (no deployment).
- **Manual deploy** — GitHub → Actions → CI/CD Pipeline → Run workflow.

After a successful deploy, open `http://192.168.56.67:3000`.

## Dockerfile Best Practices

- **Dependency caching**: `package.json` is copied and `npm install` runs before copying the rest of the app to leverage Docker layer caching.
- **Production dependencies**: `npm install --production` installs only runtime dependencies, reducing image size.
- **Non-root user**: The container runs as `appuser` instead of root for improved security.

## Author

COMP-4001 DevOps Module 4 Activity 2
