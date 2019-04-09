#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Previous build step ensures the image is working
docker build -t nikgatto/my-dockerized-debian-base .

# If the Travis tag env var is undefined then use latest
if [ -z "${TRAVIS_TAG:-}" ]; then
	PUBLISH_TAG="latest"
else
	PUBLISH_TAG=${TRAVIS_TAG}
fi

echo "Publish Tag is: ${PUBLISH_TAG}"

# Finally push the image to the Docker Hub
docker push nikgatto/my-dockerized-debian-base:"${PUBLISH_TAG}"
