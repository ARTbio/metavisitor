#!/usr/bin/env bash
set -e
# Next we upload to docker
if [ $TRAVIS_JOB = "build-docker" ] && [ "${TRAVIS_EVENT_TYPE}" = "pull_request" ]; then
    echo "pushing docker image to docker hub"
    LOGIN="docker login -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
    $LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2-beta:$TRAVIS_COMMIT || (sleep 5s && docker push artbio/metavisitor-2-beta:$TRAVIS_COMMIT || echo "push failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2-beta:latest || (sleep 5s && docker push artbio/metavisitor-2-beta:latest || echo "push failed twice, quitting" && exit 1)
fi

