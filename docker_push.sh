#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Previous build step ensures the image is working
docker build -t nikgatto/my-dockerized-debian-base .

# Finally push the image to the Docker Hub
docker push nikgatto/my-dockerized-debian-base:latest
