#!/usr/bin/env bash
set -e
apt-get install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip to v 1.9"
pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.2
ansible --version

tar -xvzf GalaxyKickStart.tar.gz && mv GalaxyKickStart-galaxy_[0-9][0-9].[0-9][0-9] GalaxyKickStart
rm -rf GalaxyKickStart/Dockerfile GalaxyKickStart/Dockerfile.test
cp Dockerfile Dockerfile.test GalaxyKickStart/
rm -rf GalaxyKickStart/group_vars/metavisitor GalaxyKickStart/group_vars/test
cp group_vars/metavisitor group_vars/test GalaxyKickStart/group_vars/
rm -rf GalaxyKickStart/extra-files/metavisitor GalaxyKickStart/extra-files/test
cp -r extra-files/metavisitor extra-files/test GalaxyKickStart/extra-files/
rm -rf GalaxyKickStart/inventory_files/*
cp inventory_files/metavisitor inventory_files/test GalaxyKickStart/inventory_files/

cd GalaxyKickStart/
echo "Editing group_vars/all"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
docker build -t metavisitor .
