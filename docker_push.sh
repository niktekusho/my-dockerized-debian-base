#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push nikgatto/my-dockerized-debian-base
