#!/usr/bin/env bash
set -e
# TRACK may be equal to "ansible" or "docker"
TRACK=$1

## Common manipulations
tar -xvzf GalaxyKickStart.tar.gz
rm -rf GalaxyKickStart/Dockerfile GalaxyKickStart/Dockerfile.test
mv Dockerfile Dockerfile.test GalaxyKickStart/
rm -rf GalaxyKickStart/group_vars/metavisitor GalaxyKickStart/group_vars/test
mv group_vars/metavisitor group_vars/test GalaxyKickStart/group_vars/
rm -rf GalaxyKickStart/extra-files/metavisitor GalaxyKickStart/extra-files/test
mv extra-files/metavisitor extra-files/test GalaxyKickStart/extra-files/
rm -rf GalaxyKickStart/inventory_files/*
mv inventory_files/metavisitor inventory_files/test GalaxyKickStart/inventory_files/
cd GalaxyKickStart/
# ansible-galaxy is required to prepare both the ansible and  docker tracks
echo "Upgrading pip to v 1.9";
pip install -U pip
pip --version
pip install ansible==2.2.0.0
ansible --version
echo "Editing group_vars/all"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all


if [ "$TRACK" = "ansible" ]; then
    sudo /etc/init.d/postgresql stop
    sudo apt-get -y --purge remove postgresql libpq-dev libpq5 postgresql-client-common postgresql-common
    sudo rm -rf /var/lib/postgresql
    sudo apt-get update -qq
    ansible-playbook -i inventory_files/test galaxy.yml
    echo "Sleeping 15 sec before display status"
    sleep 15
    sudo supervisorctl status
fi

if [ "$TRACK" = "docker" ]; then
    docker --version
    docker info
    sudo groupadd -r $GALAXY_TRAVIS_USER -g $GALAXY_GID
    sudo useradd -u $GALAXY_UID -r -g $GALAXY_TRAVIS_USER -d $GALAXY_HOME -p travis_testing\
        -c "Galaxy user" $GALAXY_TRAVIS_USER
    sudo mkdir $GALAXY_HOME
    sudo chown -R $GALAXY_TRAVIS_USER:$GALAXY_TRAVIS_USER $GALAXY_HOME
    docker build -t metavisitor -f Dockerfile.test .
    sudo mkdir /export && sudo chown $GALAXY_UID:$GALAXY_GID /export
    export CID1=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
                 --privileged=true \
                 -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
                 -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
                 -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
                 -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
                 -e NGINX_GALAXY_LOCATION=/subdir \
                 -v /tmp/:/tmp/ \
                 -v /export:/export \
                 metavisitor`


    echo "wait for export data of container"
    sleep 180s
    docker logs $CID1
    docker exec -it $CID1 supervisorctl status
    docker exec -it $CID1 service --status-all
    echo "Going to test docker container CID1 $CID1"
fi

if [ "$TRACK" = "build-docker" ]; then
    docker --version
    docker info
    sudo groupadd -r $GALAXY_TRAVIS_USER -g $GALAXY_GID
    sudo useradd -u $GALAXY_UID -r -g $GALAXY_TRAVIS_USER -d $GALAXY_HOME -p travis_testing\
        -c "Galaxy user" $GALAXY_TRAVIS_USER
    sudo mkdir $GALAXY_HOME
    sudo chown -R $GALAXY_TRAVIS_USER:$GALAXY_TRAVIS_USER $GALAXY_HOME
fi

if [ "$TRACK" = "build-docker" ] && [ "${TRAVIS_EVENT_TYPE}" = "pull_request" ]; then
    docker build -t metavisitor .
    docker tag metavisitor artbio/metavisitor-2:$TRAVIS_COMMIT
    docker tag metavisitor artbio/metavisitor-2:latest
fi
