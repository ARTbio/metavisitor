#!/usr/bin/env bash
set -e
apt-get update -y
apt-get install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip"
pip install -U pip
pip --version
pip install ansible==2.7.4
ansible --version

wget https://github.com/ARTbio/GalaxyKickStart/archive/galaxy_18.05_ini.support.tar.gz
tar -xvzf galaxy_18.05_ini.support.tar.gz
mv GalaxyKickStart-galaxy_18.05_ini.support GalaxyKickStart
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
ansible-galaxy install -r requirements_roles.yml -p roles
ansible-playbook -i inventory_files/metavisitor galaxy.yml
echo "Sleeping 15 sec before restarting Metavisitor Test Galaxy server"
echo "zzzz zzzz..."
sleep 15
supervisorctl restart galaxy:
sleep 15
supervisorctl status
