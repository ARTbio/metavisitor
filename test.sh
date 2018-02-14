#!/usr/bin/env bash
set -e
echo "Upgrading pip to v 1.9"
pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.2
ansible --version

git clone https://github.com/ARTbio/GalaxyKickStart.git
rm -rf GalaxyKickStart/Dockerfile GalaxyKickStart/Dockerfile.test
mv Dockerfile Dockerfile.test GalaxyKickStart/
rm -rf GalaxyKickStart/group_vars/metavisitor GalaxyKickStart/group_vars/test 
mv group_vars/metavisitor group_vars/test GalaxyKickStart/group_vars/
rm -rf GalaxyKickStart/extra-files/metavisitor GalaxyKickStart/extra-files/test
mv extra-files/metavisitor extra-files/test GalaxyKickStart/extra-files/
rm -rf GalaxyKickStart/inventory_files/*
mv inventory_files/metavisitor inventory_files/test GalaxyKickStart/inventory_files/

cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
echo "Editing group_vars/all"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
ansible-playbook -i inventory_files/test galaxy.yml
echo "Sleeping 15 sec before display status"
sleep 15
supervisorctl status
echo "shut down supervisor service"
service supervisor stop
sleep 5
docker build -t metavisitor -f Dockerfile.test .
