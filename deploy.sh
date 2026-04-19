#!/bin/bash
echo "docker-compose down"
docker-compose down
echo "docker-compose pull"
docker-compose pull
echo "docker-compose build --no-cache"
docker-compose build --no-cache
echo "docker-compose up -d"
docker-compose up -d
