#!/bin/bash

BRANCH=$1

if [ "$BRANCH" == "prod" ]; then
    docker build -t ghostatdocker/react-app-prod:latest .
else
    docker build -t ghostatdocker/react-app-dev:latest .
fi
