#!/bin/bash
set -e

APP_DIR="${1:-$HOME/express-greeting-app}"
IMAGE_NAME="express-greeting-app"
CONTAINER_NAME="express-app"

docker_cmd() {
  if docker info >/dev/null 2>&1; then
    docker "$@"
  else
    sudo docker "$@"
  fi
}

cd "$APP_DIR"

echo "Building Docker image..."
docker_cmd build -t "$IMAGE_NAME" .

echo "Stopping existing container..."
docker_cmd rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting new container..."
docker_cmd run -d -p 3000:3000 --name "$CONTAINER_NAME" "$IMAGE_NAME"

docker_cmd ps --filter "name=$CONTAINER_NAME"
echo "Deployment complete. App is running on port 3000."
