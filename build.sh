#!/bin/bash

BRANCH=$1

if [ "$BRANCH" == "dev" ]; then
  IMAGE="ghostatdocker/react-app-dev:latest"
elif [ "$BRANCH" == "master" ]; then
  IMAGE="ghostatdocker/react-app-prod:latest"
else
  echo "Invalid branch"
  exit 1
fi

echo "Building image: $IMAGE"
docker build -t $IMAGE .

echo "Pushing image..."
docker push $IMAGE
