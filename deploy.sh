#!/bin/bash

docker compose down --remove-orphans      # Removes containers for services not defined in the current YAML
docker rm -f react-app 2>/dev/null || true # Forcefully remove the specific name if it still exists
docker compose pull
docker compose up -d --force-recreate     # Ensures containers are replaced even if no config changed

