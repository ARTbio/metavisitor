#!/usr/bin/env bash
set -e
# TRACK may be equal to "ansible" or "docker"
TRACK=$1

## Common manipulations
git clone https://github.com/artbio/galaxykickstart.git
cp Dockerfile galaxykickstart/
cp group_vars/metavisitor galaxykickstart/group_vars/
cp -a extra-files/metavisitor galaxykickstart/extra-files/
cp inventory_files/metavisitor galaxykickstart/inventory_files/

cd galaxykickstart/

if [ "$TRACK" = "ansible" ]; then
    sudo /etc/init.d/postgresql stop
    sudo apt-get -y --purge remove postgresql libpq-dev libpq5 postgresql-client-common postgresql-common
    sudo rm -rf /var/lib/postgresql
    sudo apt-get update -qq
    ansible-galaxy install -r requirements_roles.yml -p roles/
    ansible-playbook -i inventory_files/metavisitor galaxy.yml
    ansible-playbook -i inventory_files/metavisitor --tags=install_tools galaxy.yml # ensure all tools installed
    echo "Sleeping 15 sec before display status"
    sleep 15
    sudo supervisorctl status
fi

if [ "$TRACK" = "docker" ]; then
    docker info
    sudo groupadd -r $GALAXY_TRAVIS_USER -g $GALAXY_GID
    sudo useradd -u $GALAXY_UID -r -g $GALAXY_TRAVIS_USER -d $GALAXY_HOME -p travis_testing\
        -c "Galaxy user" $GALAXY_TRAVIS_USER
    sudo mkdir $GALAXY_HOME
    sudo chown -R $GALAXY_TRAVIS_USER:$GALAXY_TRAVIS_USER $GALAXY_HOME
    docker build -t artbio/metavisitor-2 . # the Dockerfile was copied from the root dir of metavisitor repo
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


    echo "long wait for export heavy tool data of container"
    sleep 300s
    docker logs $CID1
    docker exec -it $CID1 supervisorctl status
    docker exec -it $CID1 service --status-all
    echo "Going to test docker container CID1 $CID1"
fi
