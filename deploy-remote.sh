#!/bin/bash
set -e

APP_DIR="${1:-$HOME/express-greeting-app}"
IMAGE_NAME="express-greeting-app"
CONTAINER_NAME="express-app"

cd "$APP_DIR"

echo "Building Docker image..."
docker build -t "$IMAGE_NAME" .

echo "Stopping existing container..."
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting new container..."
docker run -d -p 3000:3000 --name "$CONTAINER_NAME" "$IMAGE_NAME"

docker ps --filter "name=$CONTAINER_NAME"
echo "Deployment complete. App is running on port 3000."
