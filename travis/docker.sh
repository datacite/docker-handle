#!/bin/bash

set -e

# Login
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD";

# We want to tag builds as appropriate
if [ "${TRAVIS_TAG?}" ]; then
    TAG=$TRAVIS_TAG;
elif [ "$TRAVIS_BRANCH" == "master" ]; then
    # Tag master as 'latest'
    # Note 'latest' does not mean latest version, it's just tag we're giving
    # master and then gets used by docker by default when you don't
    # specify a tag.
    TAG="latest"
else
    # Otherwise just tag it with whatever branch we're on
    TAG=$TRAVIS_BRANCH;
fi

echo "Tagging builds with ":$TAG

docker build --quiet --rm -f Dockerfile -t 'datacite/docker-handle':$TAG .

# Run tests within the docker builds
# TODO

# Push master and tagged releases
# Don't push other branches by default

if [ "$TRAVIS_BRANCH" = "master" ] || [ "$TRAVIS_TAG" ]; then
    docker push 'datacite/docker-handle':$TAG;
    echo "Pushed docker image to" 'datacite/docker-handle':$TAG;
fi