#!/usr/bin/env bash
set -e

# we have to push the docker image because the galaxykickstart context for the Dockerfile
# is buit dynamically

if [ $TRAVIS_JOB = "docker" ] && [ "${TRAVIS_BRANCH}" = "master" ]; then
    echo "pushing docker image to https://cloud.docker.com/u/artbio/repository/docker/artbio/metavisitor-2"
    docker images
    docker tag metavisitor artbio/metavisitor-2:latest
    docker tag metavisitor artbio/metavisitor-2:$TRAVIS_COMMIT
    LOGIN="docker login -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
    $LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2:$TRAVIS_COMMIT || (sleep 5s && docker push artbio/metavisitor-2:$TRAVIS_COMMIT || echo "push failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2:latest || (sleep 5s && docker push artbio/metavisitor-2:latest || echo "push failed twice, quitting" && exit 1)
fi