#!/bin/bash

IMAGE_NAME="ghostatdocker/react-app"
TAG="latest"

echo "Stopping old container..."
docker stop react-app || true
docker rm react-app || true

echo "Pulling latest image..."
docker pull $IMAGE_NAME:$TAG

echo "Running container..."
docker run -d -p 80:80 --name react-app $IMAGE_NAME:$TAG

echo "Deployment Completed"
