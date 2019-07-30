#!/usr/bin/env bash
set -e

# we have to push the docker image because the galaxykickstart context for the Dockerfile
# is buit dynamically
echo "building dynamically metavisitor docker image"

git clone https://github.com/artbio/galaxykickstart.git
cp Dockerfile galaxykickstart/
cp group_vars/metavisitor galaxykickstart/group_vars/
cp -a extra-files/metavisitor galaxykickstart/extra-files/
cp inventory_files/metavisitor galaxykickstart/inventory_files/
cd galaxykickstart/
docker pull artbio/ansible-galaxy-os:1604
docker build --cache-from artbio/ansible-galaxy-os:1604 -t metavisitor . # the Dockerfile was copied from the root dir of metavisitor repo

echo "pushing docker image to https://cloud.docker.com/u/artbio/repository/docker/artbio/metavisitor-2"
docker images
docker tag metavisitor artbio/metavisitor-2:latest
docker tag metavisitor artbio/metavisitor-2:$TRAVIS_COMMIT
LOGIN="docker login -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
$LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
docker push artbio/metavisitor-2:$TRAVIS_COMMIT || (sleep 5s && docker push artbio/metavisitor-2:$TRAVIS_COMMIT || echo "push failed twice, quitting" && exit 1)
docker push artbio/metavisitor-2:latest || (sleep 5s && docker push artbio/metavisitor-2:latest || echo "push failed twice, quitting" && exit 1)
