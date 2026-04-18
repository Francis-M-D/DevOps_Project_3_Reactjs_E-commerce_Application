#!/bin/bash

echo "Stopping existing container..."
docker stop react-app || true
docker rm react-app || true

echo "Pulling latest image..."
docker pull ghostatdocker/react-app-dev:latest

echo "Running container..."
docker run -d -p 80:80 --name react-app ghostatdocker/react-app-dev:latest
