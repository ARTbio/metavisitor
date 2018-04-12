#!/usr/bin/env bash
set -e
apt-get install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip to v 1.9"
pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.2
ansible --version
apt-key adv --recv-keys --keyserver hkp://p80.pool.sks-keyservers.net:80 58118E89F3A912897C070ADBF76221572C52609D
add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-trusty main"
apt-get update -y
apt-get -y install docker-engine
echo "Docker system is installed\n"

tar -xvzf GalaxyKickStart-galaxy_17.09.tar.gz
rm -rf GalaxyKickStart/Dockerfile GalaxyKickStart/Dockerfile.test
mv Dockerfile Dockerfile.test GalaxyKickStart/
rm -rf GalaxyKickStart/group_vars/metavisitor GalaxyKickStart/group_vars/test
mv group_vars/metavisitor group_vars/test GalaxyKickStart/group_vars/
rm -rf GalaxyKickStart/extra-files/metavisitor GalaxyKickStart/extra-files/test
mv extra-files/metavisitor extra-files/test GalaxyKickStart/extra-files/
rm -rf GalaxyKickStart/inventory_files/*
mv inventory_files/metavisitor inventory_files/test GalaxyKickStart/inventory_files/

cd GalaxyKickStart/
echo "Editing group_vars/all"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
docker build -t metavisitor .
