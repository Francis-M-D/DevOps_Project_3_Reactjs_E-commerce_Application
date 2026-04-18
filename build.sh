#!/bin/bash

IMAGE_NAME=ghostatdocker/react-app-dev

echo "Building Docker Image..."
docker build -t $IMAGE_NAME:latest .

echo "Pushing to DockerHub..."
docker push $IMAGE_NAME:latest
