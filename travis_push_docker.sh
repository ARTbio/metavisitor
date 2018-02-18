#!/usr/bin/env bash
set -e
if [ "$TRAVIS_JOB" == "docker" ]; then
    # build full metavisitor image
    docker build -t metavisitor_full .
    
    
    # Next we upload to docker
    docker tag metavisitor_full artbio/metavisitor-2-beta:$TRAVIS_COMMIT
    docker tag metavisitor_full artbio/metavisitor-2-beta:latest
    LOGIN="docker login -e=$DOCKER_EMAIL -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
    $LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2-beta:$TRAVIS_COMMIT || (sleep 5s && docker push artbio/galaxy-kickstart-base:$TRAVIS_COMMIT || echo "push failed twice, quitting" && exit 1)
    docker push artbio/metavisitor-2-beta:latest || (sleep 5s && docker push artbio/galaxy-kickstart-base:latest || echo "push failed twice, quitting" && exit 1)
fi